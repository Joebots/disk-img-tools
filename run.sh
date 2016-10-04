BUILD_HOME=/home/joebotics/jb-host/raspi-build

# parse cli args
. $BUILD_HOME/parse-args.sh

# mount disk image
. $BUILD_HOME/mount.sh

# set up environment variables
. $BUILD_HOME/set-env.sh

echo executing chroot
if [[ -n $STG2EXEC ]]; then
	
	# download code from git master
	. $BUILD_HOME/get-code.sh

	# download and prep nodejs
	. $BUILD_HOME/get-node.sh
	
	# overlay file system
	echo synching file system from $BUILD_HOME/fs-overlay t- $FSROOT
	sudo rsync -av $BUILD_HOME/fs-overlay/ $ROOTFS

	cp $STG2EXEC /tmp/`basename $STG2EXEC`
	sudo proot -q qemu-$QARCH -S $ROOTFS -b $BOOTFS:/boot /bin/bash /tmp/`basename $STG2EXEC` $OS

else
	sudo proot -q qemu-$QARCH -S $ROOTFS -b $BOOTFS:/boot /bin/bash 
fi

# umount, rmdirs, etc
. $BUILD_HOME/cleanup.sh

