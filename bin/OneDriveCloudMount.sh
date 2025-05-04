#!/bin/bash
# Mount OneDriveCloud using rclone

MOUNT_POINT="$HOME/OneDriveCloudMount"

# Create mount point if it doesn't exist
mkdir -p "$MOUNT_POINT"

# Check if already mounted
if mount | grep "$MOUNT_POINT" > /dev/null; then
    notify-send "OneDriveCloud" "Already mounted at $MOUNT_POINT"
    exit 0
fi

# Attempt mount
rclone mount onedrive: "$MOUNT_POINT" --vfs-cache-mode writes 

# Check success
if mount | grep "$MOUNT_POINT" > /dev/null; then
    notify-send "OneDriveCloud" "Successfully mounted at $MOUNT_POINT"
else
    notify-send "OneDriveCloud" "⚠️ Mount failed"
fi

