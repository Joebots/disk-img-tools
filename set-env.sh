ROOTFS=$BUILD_HOME/${OS}-root
BOOTFS=$BUILD_HOME/${OS}-boot

if [[ !(-n $NODE_PROJECTS) ]]; then
    NODE_PROJECTS=/home/joebotics/
fi

if [[ !(-n $OS_ENV) ]]; then
    echo cannot find environment file $OS_ENV
    exit
fi

echo copying environment to /tmp for use in stage 2 chroot scripts
cp $OS_ENV /tmp/
ls -l /tmp/${OS}.img.sh

echo loading environment $OS_ENV
. /tmp/${OS}.img.sh
