#!/bin/bash

# Define the mount point
mount_point="/mnt/filetransferusb"

# Check if the mount point exists, create it if not
if [ ! -d "$mount_point" ]; then
  sudo mkdir -p "$mount_point"
  if [ $? -ne 0 ]; then
    echo "Error: Could not create mount point at $mount_point"
    exit 1
  fi
fi

# Find the USB drive (assuming it's the last added block device)
usb_device=$(lsblk -o KNAME,TYPE | grep 'disk' | tail -n 1 | awk '{print "/dev/"$1}')

if [ -z "$usb_device" ]; then
  echo "Error: Could not automatically detect USB drive."
  echo "Please plug in the USB drive and try again."
  exit 1
fi

# Determine if the USB device has partitions, and mount the first one
partition=$(lsblk -n -o KNAME "$usb_device" | grep -Po '^[a-z]+\d+')
if [ -n "$partition" ]; then
  device_to_mount="/dev/${partition}1" # Assuming the first partition
else
  device_to_mount="$usb_device" # Mount the whole device if no partitions
fi

# Mount the USB drive
sudo mount "$device_to_mount" "$mount_point"
if [ $? -eq 0 ]; then
  echo "USB drive mounted successfully at $mount_point"
else
  echo "Error: Failed to mount USB drive $device_to_mount to $mount_point"
  exit 1
fi

exit 0
