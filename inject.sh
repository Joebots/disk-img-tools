echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo ======================================================================================================================================================
echo "| stage 2 executing in \"`uname -a`\" |"
echo ======================================================================================================================================================
echo 

DEPENDENCIES="tightvncserver vim git chromium-browser"

apt-get -y install $DEPENDENCIES 

echo $NODEJS_ID
# install nodejs
ln -s /opt/joebotics/$NODEJS_ID/ /opt/joebotics/nodejs
ln -s /opt/joebotics/nodejs/bin/node /usr/bin/node 
ln -s /opt/joebotics/nodejs/bin/npm /usr/bin/npm

