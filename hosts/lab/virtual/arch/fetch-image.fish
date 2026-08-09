#!/usr/bin/env fish

set VM_DIR "$HOME/virtual/arch"
set RAW_IMAGE "$VM_DIR/Arch-Linux-x86_64-basic.qcow2"
set DISK_IMAGE "$VM_DIR/arch.qcow2"

mkdir -p "$VM_DIR/home"
cd "$VM_DIR"

if test -f "$DISK_IMAGE"
    echo "Disk image already exists at $DISK_IMAGE"
    exit 0
end

if not test -f "$RAW_IMAGE"
    echo "Downloading official Arch basic QCOW2 image..."
    curl -L -O https://geo.mirror.pkgbuild.com/images/latest/Arch-Linux-x86_64-basic.qcow2
end

echo "Preparing 20GB QCOW2 image..."
cp "$RAW_IMAGE" "$DISK_IMAGE"
qemu-img resize "$DISK_IMAGE" 20G

echo "Image successfully created at $DISK_IMAGE"
