# --- IPv4 setup ---
ipset -q flush masscan-exclude-v4
ipset -q create masscan-exclude-v4 hash:net family inet

# --- IPv6 setup ---
ipset -q flush masscan-exclude-v6
ipset -q create masscan-exclude-v6 hash:net family inet6

# --- Populate both sets from the same exclude list ---
curl --compressed https://raw.githubusercontent.com/scriptzteam/masscan-exclude/refs/heads/main/exclude.conf 2>/dev/null \
  | cut -f1 \
  | while read ip; do
      if [[ $ip == *:* ]]; then
        ipset add masscan-exclude-v6 "$ip"
      else
        ipset add masscan-exclude-v4 "$ip"
      fi
    done

# --- IPv4 iptables rules ---
iptables -D INPUT -m set --match-set masscan-exclude-v4 src -j DROP 2>/dev/null
iptables -I INPUT -m set --match-set masscan-exclude-v4 src -j DROP
iptables -D OUTPUT -m set --match-set masscan-exclude-v4 dst -j DROP 2>/dev/null
iptables -I OUTPUT -m set --match-set masscan-exclude-v4 dst -j DROP

# --- IPv6 ip6tables rules ---
ip6tables -D INPUT -m set --match-set masscan-exclude-v6 src -j DROP 2>/dev/null
ip6tables -I INPUT -m set --match-set masscan-exclude-v6 src -j DROP
ip6tables -D OUTPUT -m set --match-set masscan-exclude-v6 dst -j DROP 2>/dev/null
ip6tables -I OUTPUT -m set --match-set masscan-exclude-v6 dst -j DROP
