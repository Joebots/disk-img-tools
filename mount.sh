#!/usr/bin/env bash

echo; echo; echo "================================ mount.sh start ======================================"

# mount disk image
echo ============================================================
printf "mounting $DISKIMG to \n\t$BOOTFS \n\t$ROOTFS\n"

sudo kpartx -a -v $DISKIMG

sleep 1 

mkdir -p $ROOTFS 
mkdir -p $BOOTFS

sudo mount /dev/mapper/loop0p1  $BOOTFS
sudo mount /dev/mapper/loop0p2  $ROOTFS

echo "================================ mount.sh done ======================================"