ROOTFS=$BUILD_HOME/`basename $DISKIMG`-root
BOOTFS=$BUILD_HOME/`basename $DISKIMG`-boot
OS_ENV=$BUILD_HOME/arch-env/`basename $DISKIMG`.sh

# mount disk image
echo ============================================================
printf "mounting $DISKIMG to \n\t$BOOTFS \n\t$ROOTFS\n"

sudo kpartx -a -v $DISKIMG

sleep 1 

mkdir -p $ROOTFS 
mkdir -p $BOOTFS

sudo mount /dev/mapper/loop0p1  $BOOTFS
sudo mount /dev/mapper/loop0p2  $ROOTFS

