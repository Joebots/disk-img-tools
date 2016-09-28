BUILD_HOME=/home/joebotics/jb-host/raspi-build
OS_IMG=2016-05-27-raspbian-jessie.img
ROOTFS=$BUILD_HOME/$OS_IMG-root
BOOTFS=$BUILD_HOME/$OS_IMG-boot

sudo kpartx -a -v $BUILD_HOME/imgs/$OS_IMG

sleep 2 

mkdir -p $ROOTFS 
mkdir -p $BOOTFS

sudo mount /dev/mapper/loop1p1  $BOOTFS
sudo mount /dev/mapper/loop1p2  $ROOTFS

echo executing chroot
sudo proot -q qemu-arm -S $ROOTFS -b $BOOTFS:/boot /bin/bash
echo exited chroot

echo unmounting kpartx loopback connectors
sudo umount /dev/mapper/loop1p*
sudo dmsetup remove /dev/mapper/loop*

echo deleting unmounted filesystem dirs
sudo rm -fr $BOOTFS $ROOTFS

