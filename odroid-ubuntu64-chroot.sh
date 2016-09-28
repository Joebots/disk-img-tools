BUILD_HOME=/home/joebotics/jb-host/raspi-build
OS_IMG=ubuntu-16.04-minimal-odroid-c2.img
ROOTFS=$BUILD_HOME/$OS_IMG-root
BOOTFS=$BUILD_HOME/$OS_IMG-boot

DEPENDENCIES="vim git"

sudo kpartx -a -v $BUILD_HOME/imgs/$OS_IMG

sleep 2 

mkdir -p $ROOTFS 
mkdir -p $BOOTFS

sudo mount /dev/mapper/loop0p1  $BOOTFS
sudo mount /dev/mapper/loop0p2  $ROOTFS

echo executing chroot
sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot uname -a 
sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot apt-get install $DEPENDENCIES 
echo exited chroot

echo unmounting kpartx loopback connectors
sudo umount /dev/mapper/loop0p*
sudo dmsetup remove /dev/mapper/loop*

echo deleting unmounted filesystem dirs
sudo rm -fr $BOOTFS $ROOTFS
