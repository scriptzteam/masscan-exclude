# 🚫 masscan-exclude: Exclude Unwanted IP Ranges from Masscan Scans

## 📘 Overview

The `exclude.sh` script is designed to help you exclude specific IP ranges from your Masscan scans. 

The `exclude.conf` file is designed to help you exclude specific IP ranges from your Masscan scans.  `masscan 0.0.0.0/0 -p0-65535 --excludefile exclude.conf`

These ranges include:
- 🔒 Private IPs
- 🌐 Reserved IPs
- 🕸️ Bogon IPs
- 🌍 Root DNS servers
- 🏛️ Government and law enforcement IPs

By filtering out these ranges, you can focus your scans on more relevant targets and avoid unnecessary traffic to sensitive or internal networks.

## ⚙️ Prerequisites

Before running the script `exclude.sh`, ensure you have the following installed:

- ✅ `ipset` – for managing IP sets
- ✅ `iptables` – for configuring firewall rules
- ✅ `curl` – for fetching the exclusion list

## 🛠️ Installation & Usage

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/scriptzteam/masscan-exclude.git
   cd masscan-exclude

2. **Run the Script:**

   ```./exclude.sh```

This will:
```
Download the latest exclude.conf file.
Flush and recreate the masscan-exclude IP set.
Populate the set with IPs to exclude.
Update iptables rules to drop incoming and outgoing traffic to/from these IPs.
```
