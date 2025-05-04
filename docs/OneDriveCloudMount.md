# Mounting OneDrive with rclone

This guide documents the setup and mounting process for accessing Microsoft OneDrive using `rclone`. This includes both the manual script and the automated `systemd` user service that runs the mount at login.

> 🔧 This is **not part of the Dotbot install process** by default, but configuration and symlinks are stored in the repo.

---

## Prerequisites

### 1. Install rclone
```bash
sudo apt install rclone
```

### 2. Install FUSE (if not already present)
```bash
sudo apt install fuse
```

---

## Configure rclone for OneDrive

### Step 1: Run configuration
```bash
rclone config
```
- Select `n` for new remote
- Name it (e.g., `onedrive`)
- Select `23` for Microsoft OneDrive
- Follow the authentication steps in your browser
- When finished, confirm it works:
```bash
rclone lsd onedrive:
```

---

## OneDrive Mount Script

### File: `~/config-files/bin/OneDriveCloudMount.sh`
```bash
#!/bin/bash
# Mount OneDriveCloud using rclone

MOUNT_POINT="$HOME/OneDrive"
mkdir -p "$MOUNT_POINT"

if mount | grep "$MOUNT_POINT" > /dev/null; then
    notify-send "OneDriveCloud" "Already mounted at $MOUNT_POINT"
    exit 0
fi

rclone mount onedrive: "$MOUNT_POINT" --vfs-cache-mode writes --daemon

if mount | grep "$MOUNT_POINT" > /dev/null; then
    notify-send "OneDriveCloud" "Successfully mounted at $MOUNT_POINT"
else
    notify-send "OneDriveCloud" "⚠️ Mount failed"
fi
```

---

## FUSE: Allow user mounts

Ensure the following is set in `/etc/fuse.conf`:
```bash
sudo nano /etc/fuse.conf
```
Uncomment or add:
```
user_allow_other
```

---

## Automate with systemd

### Service file: `~/.config/systemd/user/onedrive-cloud-mount.service`
Source: `~/config-files/.config/systemd/user/onedrive-cloud-mount.service`
```ini
[Unit]
Description=Mount OneDrive using rclone
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=%h/config-files/bin/OneDriveCloudMount.sh
RemainAfterExit=true

[Install]
WantedBy=default.target
```

### Enable the service:
```bash
systemctl --user daemon-reload
systemctl --user enable onedrive-cloud-mount.service
systemctl --user start onedrive-cloud-mount.service
```

### Allow user-level services to persist
```bash
sudo loginctl enable-linger $USER
```

---

## Troubleshooting

If the mount fails:
```bash
fusermount -u ~/OneDrive   # or
sudo umount ~/OneDrive
```

Run the script manually to debug:
```bash
bash ~/config-files/bin/OneDriveCloudMount.sh
```

Or run with log output:
```bash
rclone mount onedrive: ~/OneDrive \
  --vfs-cache-mode writes \
  --log-file ~/rclone.log \
  --log-level DEBUG
```

---

## Summary

- ✅ Manual mount script: `~/config-files/bin/OneDriveCloudMount.sh`
- ✅ Auto-mount at login via `systemd --user`
- ✅ Symlink to service file managed by Dotbot
- ❌ Not enabled automatically during base install
