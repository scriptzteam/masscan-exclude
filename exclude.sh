ipset -q flush masscan-exclude
ipset -q create masscan-exclude hash:net
for ip in $(curl --compressed https://raw.githubusercontent.com/scriptzteam/masscan-exclude/refs/heads/main/exclude.conf 2>/dev/null | cut -f 1); do ipset add masscan-exclude $ip; done
iptables -D INPUT -m set --match-set masscan-exclude src -j DROP 2>/dev/null
iptables -I INPUT -m set --match-set masscan-exclude src -j DROP
iptables -D OUTPUT -m set --match-set masscan-exclude dst -j DROP 2>/dev/null
iptables -I OUTPUT -m set --match-set masscan-exclude dst -j DROP
