# Mounting OneDrive with rclone

This guide documents the manual setup and mounting process for accessing Microsoft OneDrive using `rclone`. This script is **not included** in the automated `install.conf.yaml` install process, but is tracked here for reference and future automation if desired.

## Prerequisites

### 1. Install rclone
```bash
sudo apt install rclone
```

### 2. Install FUSE (if not already present)
```bash
sudo apt install fuse
```

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

## Verify and Use the Mount Script

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

### Step 1: Ensure FUSE allows non-root mounting
Edit `/etc/fuse.conf`:
```bash
sudo nano /etc/fuse.conf
```
Uncomment or add:
```
user_allow_other
```

### Step 2: Run the script manually
```bash
bash ~/config-files/bin/OneDriveCloudMount.sh
```

### Step 3: Troubleshooting
If mount fails:
```bash
fusermount -u ~/OneDrive   # or
sudo umount ~/OneDrive
```
Then retry the mount.

You can also run interactively to see logs:
```bash
rclone mount onedrive: ~/OneDrive --vfs-cache-mode writes
```

Or with logging:
```bash
rclone mount onedrive: ~/OneDrive \
  --vfs-cache-mode writes \
  --log-file ~/rclone.log \
  --log-level DEBUG
```

---

## Future Considerations
- Create a systemd service for persistent mount across reboots
- Use `nohup` instead of `--daemon` if the script proves unreliable
- Store credentials securely if config is shared across systems

---

## Notes
- This process does not run automatically during install.
- Script location: `~/config-files/bin/OneDriveCloudMount.sh`
- Mount target: `~/OneDrive`


