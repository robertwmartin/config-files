# OneDrive Cloud Mount via rclone

This guide documents the setup used to automatically mount OneDrive at login using rclone and a user-level systemd service.

---

## Overview

OneDrive is mounted using `rclone` to a local folder:

```
~/OneDriveCloudMount
```

This setup uses:

- A custom shell script
- A user systemd service
- Dotbot integration
- Notifications for success or failure

---

## Mount Script

**Path:** `bin/OneDriveCloudMount.sh`

```bash
#!/bin/bash

MOUNT_POINT="$HOME/OneDriveCloudMount"

# Create mount point if it doesn't exist
mkdir -p "$MOUNT_POINT"

# Unmount if already mounted but failed (cleanup)
if mountpoint -q "$MOUNT_POINT"; then
    fusermount -u "$MOUNT_POINT"
fi

# Attempt mount (no --daemon)
rclone mount onedrive: "$MOUNT_POINT" --vfs-cache-mode writes

# Notify on result
if mount | grep "$MOUNT_POINT" > /dev/null; then
    notify-send "OneDriveCloud" "Successfully mounted at $MOUNT_POINT"
else
    notify-send "OneDriveCloud" "⚠️ Mount failed"
fi
```

> ✅ `--daemon` was **removed** so systemd can properly manage the foreground `rclone` process.

---

## Systemd Service

**Path:** `.config/systemd/user/onedrive-cloud-mount.service`

```ini
[Unit]
Description=Mount OneDrive using rclone
After=graphical-session.target
Requires=graphical-session.target

[Service]
Type=simple
ExecStartPre=/bin/sleep 5
ExecStartPre=/bin/bash -c '/bin/fusermount -u /home/rmartin/OneDriveCloudMount || true'
ExecStart=/home/rmartin/config-files/bin/OneDriveCloudMount.sh
Restart=on-failure

[Install]
WantedBy=default.target
```

> ✅ `ExecStartPre` unmounts any broken mountpoint left over from a crash or reboot
> ✅ `sleep 5` ensures system dependencies like DBus are available

---

## Enable the Service

```bash
loginctl enable-linger $USER
systemctl --user daemon-reload
systemctl --user enable onedrive-cloud-mount.service
```

---

## Dotbot Integration

Add to `install.conf.yaml`:

```yaml
- link:
    ~/.config/systemd/user/onedrive-cloud-mount.service: .config/systemd/user/onedrive-cloud-mount.service
```

---

## Final Notes

- The mount will be available automatically after login.

- You’ll see a desktop notification if it succeeds or fails.

- If debugging is ever needed:
  
  ```bash
  journalctl --user -u onedrive-cloud-mount.service
  ```
