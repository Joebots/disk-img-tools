BUILD_HOME=/home/joebotics/jb-host/raspi-build
OS_IMG=ubuntu-16.04-minimal-odroid-c2.img

ROOTFS=$BUILD_HOME/$OS_IMG-root
BOOTFS=$BUILD_HOME/$OS_IMG-boot

# mount disk image
sudo kpartx -a -v $BUILD_HOME/imgs/$OS_IMG

sleep 1 

mkdir -p $ROOTFS 
mkdir -p $BOOTFS

sudo mount /dev/mapper/loop0p1  $BOOTFS
sudo mount /dev/mapper/loop0p2  $ROOTFS

## download and prep nodejs
#. $BUILD_HOME/get-node.sh

echo executing chroot
cp $BUILD_HOME/inject.sh /tmp/inject.sh
sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot /bin/bash /tmp/inject.sh 
#sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot /bin/bash 

echo unmounting kpartx loopback connectors
sudo umount /dev/mapper/loop0p*
sudo dmsetup remove /dev/mapper/loop*

echo deleting unmounted filesystem dirs
sudo rm -fr $BOOTFS $ROOTFS
