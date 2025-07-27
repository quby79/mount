#!/bin/bash

username=$(whoami)
mount_point="/home/$username/sec"

# Check if the mount point is currently mounted
if mountpoint -q "$mount_point" 2>/dev/null; then
    echo "Mount point $mount_point is currently mounted. Unmounting..."
    
    # Unmount the directory
    if sudo umount "$mount_point"; then
        echo "Successfully unmounted $mount_point"
    else
        echo "Failed to unmount $mount_point" >&2
        exit 1
    fi
else
    echo "Mount point $mount_point is not mounted. Mounting..."
    
    # Create the mount point directory if it doesn't exist
    if [ ! -d "$mount_point" ]; then
        echo "Creating mount point directory: $mount_point"
        mkdir -p "$mount_point"
    fi

sudo mount /dev/kvg/secure "$mount_point"
fi