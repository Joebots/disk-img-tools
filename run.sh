#!/usr/bin/env bash

echo; echo; echo "================================ run.sh start ======================================"

if [[ !(-n $BUILD_HOME) ]]; then
    BUILD_HOME=$(pwd)
fi

if [[ !(-n $JOEBOTICS_HOME) ]]; then
    JOEBOTICS_HOME=$BUILD_HOME/jb-src
    mkdir -p $JOEBOTICS_HOME
fi

FS_OVERLAY=$BUILD_HOME/fs-overlay

# parse cli args
. $BUILD_HOME/parse-args.sh

# set up environment variables
. $BUILD_HOME/set-env.sh

# mount disk image
. $BUILD_HOME/mount.sh

# download code from git master
. $BUILD_HOME/get-code.sh

# download and prep nodejs
. $BUILD_HOME/get-node.sh

# overlay file system
echo synching file systems from $FS_OVERLAY
sudo rsync -av $BUILD_HOME/fs-overlay/root-fs/opt/ $ROOTFS/opt
sudo rsync -av $BUILD_HOME/fs-overlay/root-fs/etc/ $ROOTFS/etc
sudo rsync -av $BUILD_HOME/fs-overlay/root-fs/home/odroid/ $ROOTFS/home/odroid

#echo sudo rsync -av $BUILD_HOME/fs-overlay/boot-fs/ $BOOTFS
sudo cp -fr $BUILD_HOME/fs-overlay/boot-fs/* $BOOTFS

if [[ -n $STG2EXEC ]]; then
        
	# chroot and run STG2EXEC
	echo executing chroot script $STG2EXEC
	cp $STG2EXEC /tmp/`basename $STG2EXEC`
	sudo proot -q qemu-$QARCH -S $ROOTFS -b $BOOTFS:/boot /bin/bash /tmp/`basename $STG2EXEC` $OS

#else
	#echo executing chroot
	#sudo proot -q qemu-$QARCH -S $ROOTFS -b $BOOTFS:/boot /bin/bash 
fi

# add odroid user to gpio group
sudo proot -q qemu-$QARCH -S $ROOTFS -b $BOOTFS:/boot addgroup gpio
sudo proot -q qemu-$QARCH -S $ROOTFS -b $BOOTFS:/boot usermod -a -G gpio odroid

# umount, rmdirs, etc
. $BUILD_HOME/cleanup.sh

echo "================================ run.sh done ======================================"
