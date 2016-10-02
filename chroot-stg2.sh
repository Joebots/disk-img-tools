printf "\n\n\n"
echo ======================================================================================================================================================
echo "| chroot stage 2 in \"`uname -a`\" |"
echo ======================================================================================================================================================
echo 

# Load environment
echo loading environment /tmp/$1.sh
. /tmp/$1.sh
echo ==================
cat /tmp/$1.sh
echo ==================

DEPENDENCIES="rsync tightvncserver vim git chromium-browser"

apt-get -y update
apt-get -y install $DEPENDENCIES 

# set up nodejs
printf "\n\n=========== setting up nodejs symlinks for $NODEJS_ID\n"
ln -s /opt/joebotics/$NODEJS_ID /opt/joebotics/nodejs
ln -s /opt/joebotics/nodejs/bin/node /usr/bin/node 
ln -s /opt/joebotics/nodejs/bin/npm /usr/bin/npm
ln -s /opt/joebotics/nodejs/bin/node /usr/local/bin/node 
ln -s /opt/joebotics/nodejs/bin/npm /usr/local/bin/npm

# copy global node node_modules
printf "\n\n=========== installing odroid global module in /opt/joebotics/lib/node_modules\n"
mkdir -p /opt/joebotics/lib/node_modules
cd /opt/joebotics/lib
npm install odroid-gpio

# fix permissions
chown -R root:root /opt/joebotics



