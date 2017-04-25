#!/usr/bin/env bash
sudo qemu-system-aarch64 \
-m 1024 \
-M virt \
-nographic \
-drive if=none,file=$1,id=hd0 \
#-netdev type=tap,id=net0 \
#-device virtio-blk-device,drive=hd0 \
#-device virtio-net-device,netdev=net0,mac=$randmac
#-cpu cortex-a57 \
#-pflash flash0.img \
#-pflash flash1.img \
#-drive if=none,file=vivid-server-cloudimg-arm64-uefi1.img,id=hd0 \
