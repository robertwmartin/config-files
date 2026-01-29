# WireGuard VPN Setup

This guide documents the WireGuard VPN configuration for secure remote access to the home network and NAS.

---

## Overview

**Architecture:**
- **Server:** OPNsense firewall (supergeer.robertwmartin.com)
- **Client:** Ubuntu laptop (vannevar)
- **VPN Subnet:** 10.0.8.0/24
- **Home Network:** 192.168.10.0/24
- **NAS:** hornig (192.168.10.14)

**Purpose:** Secure remote access to Synology NAS file shares

---

## Server Configuration (OPNsense)

### Prerequisites
- OPNsense 23.1+ (WireGuard built-in)
- Dynamic DNS configured (supergeer.robertwmartin.com)

### Server Setup

**1. Enable WireGuard**
- Go to **VPN → WireGuard → Settings**
- Check "Enable WireGuard"
- Save

**2. Create Server Instance**
- Go to **VPN → WireGuard → Instances**
- Click Add
- Name: `wg0`
- Listen Port: `51820`
- Tunnel Address: `10.0.8.1/24`
- Click "Generate new keypair"
- Save and note the **Public Key**

**3. Add Client Peer**
- Go to **VPN → WireGuard → Endpoints**
- Click Add
- Name: `vannevar` (or client hostname)
- Public Key: (from client - see client setup below)
- Allowed IPs: `10.0.8.2/32`
- Instance: `wg0`
- Save and Apply

**4. Firewall Rules**

**Allow WireGuard inbound (WAN):**
- **Firewall → Rules → WAN**
- Action: Pass
- Protocol: UDP
- Source: any
- Destination: WAN address
- Destination Port: 51820

**Allow VPN clients to LAN:**
- **Firewall → Rules → WireGuard**
- Action: Pass
- Protocol: any
- Source: WireGuard net (10.0.8.0/24)
- Destination: 192.168.10.0/24

---

## Client Configuration (Ubuntu Laptop)

### Install WireGuard
```bash
sudo apt update
sudo apt install wireguard
```

### Generate Client Keys
```bash
wg genkey | tee ~/wg-laptop-privatekey | wg pubkey > ~/wg-laptop-publickey
cat ~/wg-laptop-publickey  # Add this to OPNsense peer configuration
```

**IMPORTANT:** Store private key securely (password vault, encrypted backup)

### Create Configuration
```bash
sudo mkdir -p /etc/wireguard
sudo cp ~/config-files/network-devices/wireguard/wg0.conf.template /etc/wireguard/wg0.conf
sudo vi /etc/wireguard/wg0.conf
```

**Replace placeholders:**
1. `YOUR_LAPTOP_PRIVATE_KEY_HERE` - from `~/wg-laptop-privatekey`
2. `YOUR_OPNSENSE_PUBLIC_KEY_HERE` - from OPNsense server instance

**Set permissions:**
```bash
sudo chmod 600 /etc/wireguard/wg0.conf
```

---

## Usage

**Connect to VPN:**
```bash
sudo wg-quick up wg0
```

**Disconnect:**
```bash
sudo wg-quick down wg0
```

**Check status:**
```bash
sudo wg show
```

**Test connectivity:**
```bash
ping 192.168.10.14  # NAS
ping 192.168.10.1   # Gateway
```

---

## Accessing NAS File Shares

Once VPN is connected:

**Via File Manager:**
1. Press `Ctrl+L` in file manager
2. Enter: `smb://192.168.10.14`
3. Authenticate with Synology credentials

**Via Command Line:**
```bash
# Mount share (example)
sudo mkdir -p /mnt/nas
sudo mount -t cifs //192.168.10.14/share /mnt/nas -o username=your_user
```

---

## Optional: Passwordless sudo for WireGuard

To avoid entering password each time:
```bash
sudo visudo
```

Add:
```
yourusername ALL=(ALL) NOPASSWD: /usr/bin/wg-quick
```

---

## Troubleshooting

**Can't resolve hostnames:**
- DNS is intentionally not set to avoid breaking internet access
- Use IP addresses (192.168.10.14) instead of hostnames
- Or add `DNS = 192.168.10.1` to config (may break internet DNS)

**Connection fails:**
- Check OPNsense firewall rules
- Verify DDNS is resolving correctly: `nslookup supergeer.robertwmartin.com`
- Check OPNsense logs: **VPN → WireGuard → Log File**

**Can ping but can't access shares:**
- Verify Synology firewall allows connections from 10.0.8.0/24
- Check SMB service is running on NAS

---

## Security Notes

- Private keys are NOT stored in dotfiles repository
- Each client should have unique keys
- Keys stored in password vault or encrypted backup
- Split tunnel configuration (only home network routed through VPN)
- PersistentKeepalive maintains connection through NAT

---

## Network Details

- **Server VPN IP:** 10.0.8.1
- **Laptop VPN IP:** 10.0.8.2
- **VPN Port:** 51820 (UDP)
- **Endpoint:** supergeer.robertwmartin.com:51820
- **AllowedIPs:** 192.168.10.0/24 (home network only)

---

## Last Updated

January 2026
