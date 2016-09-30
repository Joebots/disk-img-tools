echo 
echo 
echo 
echo 
echo ======================================================================================================================================================
echo "| stage 2 in \"`uname -a`\" |"
echo ======================================================================================================================================================
echo 

DEPENDENCIES="tightvncserver vim git chromium-browser"

apt-get -y update
apt-get -y install $DEPENDENCIES 

# install nodejs
echo setting up nodejs symlinks
ln -s /opt/joebotics/$NODEJS_ID/ /opt/joebotics/nodejs
ln -s /opt/joebotics/nodejs/bin/node /usr/bin/node 
ln -s /opt/joebotics/nodejs/bin/npm /usr/bin/npm

echo installing odroid-gpio for nodejs
npm install odroid-gpio
mv node_modules/* /opt/joebotics/lib/node_modules
rm -fr node_modules


