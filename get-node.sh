NODEJS_VER=v4.6.0
NODEJS_ARCH=arm64
NODEJS_ID=node-$NODEJS_VER-linux-$NODEJS_ARCH
NODEJS_FILE=$NODEJS_ID.tar.xz

wget https://nodejs.org/dist/$NODEJS_VER/$NODEJS_FILE
mv $NODEJS_FILE /tmp
unxz /tmp/$NODEJS_FILE
tar -xvf /tmp/$NODEJS_ID.tar --directory /tmp
sudo chown -R root:root /tmp/$NODEJS_ID
sudo mv /tmp/$NODEJS_ID $ROOTFS/opt/joebotics
sudo rm -fr /tmp/$NODE_ID*

