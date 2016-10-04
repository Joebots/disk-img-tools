
if [[ !(-n $OS_ENV) ]]; then
    echo cannot find environment file $OS_ENV
    exit
fi

echo loading environment $OS_ENV
. $OS_ENV

echo copying environment to /tmp for use in stage 2 chroot scripts
cp $OS_ENV /tmp/
ls -l /tmp/`basename $DISKIMG`.sh


