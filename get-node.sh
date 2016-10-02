# load nodejs env
. $BUILD_HOME/arch-env/$QARCH.sh

wget https://nodejs.org/dist/$NODEJS_VER/$NODEJS_FILE
mv $NODEJS_FILE /tmp
unxz /tmp/$NODEJS_FILE
tar -xf /tmp/$NODEJS_ID.tar --directory /tmp
sudo chown -R root:root /tmp/$NODEJS_ID
sudo mkdir -p $ROOTFS/opt/joebotics/$NODEJS_ID
sudo mv /tmp/$NODEJS_ID $ROOTFS/opt/joebotics
sudo rm -fr /tmp/$NODEJS_ID*

#cd /tmp

printf "\n\n=========== installing odroid-gpio for nodejs\n"
npm install odroid-gpio
mkdir -p /tmp/node_modules
mv node_modules/odroid-gpio /tmp/node_modules/odroid-gpio 
rm -fr node_modules

#cd $BUILD_HOME


