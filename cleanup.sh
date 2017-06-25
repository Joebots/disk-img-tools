echo "================================ cleanup.sh start ======================================"

echo unmounting kpartx loopback connectors
sync
sudo umount /dev/mapper/loop0p*
sudo dmsetup remove /dev/mapper/loop*
sudo losetup -d /dev/loop0

echo deleting unmounted filesystem dirs
sudo rm -fr $BOOTFS $ROOTFS
sudo rm /tmp/${OS}.img.sh

echo "================================ cleanup.sh end ======================================"
