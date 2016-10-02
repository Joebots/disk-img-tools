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

DEPENDENCIES="tightvncserver vim git chromium-browser"

apt-get -y update
apt-get -y install $DEPENDENCIES 

# set up nodejs
printf "\n\n=========== setting up nodejs symlinks for $NODEJS_ID\n"
ln -s /opt/joebotics/$NODEJS_ID /opt/joebotics/nodejs
ln -s /opt/joebotics/nodejs/bin/node /usr/bin/node 
ln -s /opt/joebotics/nodejs/bin/npm /usr/bin/npm

# copy global node node_modules
printf "\n\n=========== copying  global node node_modules\n"
mkdir -p /opt/joebotics/lib/node_modules
chown -R root:root /tmp/node_modules/*
mv /tmp/node_modules/* /opt/joebotics/lib/node_modules



