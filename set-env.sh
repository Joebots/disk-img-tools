ARCH_ENV=$BUILD_HOME/arch-env/$QARCH.sh

if [[ !(-n $ARCH_ENV) ]]; then
    echo cannot find environment file for $QARCH
    exit
fi

echo loading environment $ARCH_ENV
. $ARCH_ENV
cp $ARCH_ENV /tmp/
ls -l /tmp/$QARCH.sh
sleep 5

npm_config_arch=$NODEJS_ARCH

