# load nodejs env
. $BUILD_HOME/arch-env/`basename $DISKIMG`.sh

cd /tmp

wget https://nodejs.org/dist/$NODEJS_VER/$NODEJS_FILE
unxz $NODEJS_FILE
tar -xf $NODEJS_ID.tar --directory /tmp
sudo chown -R root:root $NODEJS_ID
sudo mkdir -p $ROOTFS/opt/joebotics/$NODEJS_ID
sudo mv $NODEJS_ID $ROOTFS/opt/joebotics
sudo rm -fr $NODEJS_ID*

cd $BUILD_HOME


