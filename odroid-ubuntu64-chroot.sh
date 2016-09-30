BUILD_HOME=/home/joebotics/jb-host/raspi-build
OS_IMG=ubuntu64-16.04-minimal-odroid-c2-20160815.img

ROOTFS=$BUILD_HOME/$OS_IMG-root
BOOTFS=$BUILD_HOME/$OS_IMG-boot

# mount disk image
echo ============================================================
echo mounting $OS_IMG to $ROOTFS $BOOTFS
sudo kpartx -a -v $BUILD_HOME/imgs/$OS_IMG

sleep 1 

mkdir -p $ROOTFS 
mkdir -p $BOOTFS

sudo mount /dev/mapper/loop0p1  $BOOTFS
sudo mount /dev/mapper/loop0p2  $ROOTFS

# download code from git master
echo ============================================================
echo cloning joebotics nodejs code
cd /tmp 
rm -fr node-projects simmer-maven
git clone git@github.com:Joebots/node-projects.git

cd node-projects/build
npm install

cd /tmp
mv node-projects $ROOTFS/opt/joebotics

cd $BUILD_HOME

## download and prep nodejs
echo "downloading and preparing nodejs"
. $BUILD_HOME/get-node.sh

echo executing chroot
cp $BUILD_HOME/chroot-stg2.sh /tmp/chroot-stg2.sh
sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot /bin/bash /tmp/chroot-stg2.sh
#sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot /bin/bash 

echo unmounting kpartx loopback connectors
sudo umount /dev/mapper/loop0p*
sudo dmsetup remove /dev/mapper/loop*

echo deleting unmounted filesystem dirs
sudo rm -fr $BOOTFS $ROOTFS
