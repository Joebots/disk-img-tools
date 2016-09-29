BUILD_HOME=/home/joebotics/jb-host/raspi-build
OS_IMG=ubuntu-16.04-minimal-odroid-c2.img

ROOTFS=$BUILD_HOME/$OS_IMG-root
BOOTFS=$BUILD_HOME/$OS_IMG-boot

DEPENDENCIES="tightvncserver vim git chromium-browser"

NODEJS_VER=v4.6.0
NODEJS_ARCH=arm64
NODEJS_ID=node-$NODEJS_VER-linux-$NODEJS_ARCH
NODEJS_FILE=$NODEJS_ID.tar.xz

# mount disk image
sudo kpartx -a -v $BUILD_HOME/imgs/$OS_IMG

sleep 1 

mkdir -p $ROOTFS 
mkdir -p $BOOTFS

sudo mount /dev/mapper/loop0p1  $BOOTFS
sudo mount /dev/mapper/loop0p2  $ROOTFS

# download and prep nodejs
wget https://nodejs.org/dist/$NODEJS_VER/$NODEJS_FILE
mv $NODEJS_FILE /tmp
unxz /tmp/$NODEJS_FILE
tar -xvf /tmp/$NODEJS_ID.tar --directory /tmp
sudo chown -R root:root /tmp/$NODEJS_ID
sudo mv /tmp/$NODEJS_ID $ROOTFS/opt/joebotics
sudo rm -fr /tmp/$NODE_ID*

echo executing chroot
sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot uname -a 
sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot apt-get -y install $DEPENDENCIES 

#install nodejs
sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot ln -s /opt/joebotics/$NODEJS_ID/bin/node /usr/bin/node 
sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot ln -s /opt/joebotics/$NODEJS_ID/bin/npm /usr/bin/npm

sudo proot -q qemu-aarch64 -S $ROOTFS -b $BOOTFS:/boot ln -s /bin/bash 

echo exited chroot

echo unmounting kpartx loopback connectors
sudo umount /dev/mapper/loop0p*
sudo dmsetup remove /dev/mapper/loop*

echo deleting unmounted filesystem dirs
sudo rm -fr $BOOTFS $ROOTFS
