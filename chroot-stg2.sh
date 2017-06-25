#!/usr/bin/env bash

printf "\n\n\n"
echo "================================ chroot-stg2.sh start ======================================"

echo ======================================================================================================================================================
echo "| chroot stage 2 in \"`uname -a`\" |"
echo ======================================================================================================================================================
echo 
OS_ENV=$1.img.sh

# Load environment
echo loading environment /tmp/$OS_ENV
. /tmp/$OS_ENV
echo ==================
cat /tmp/$OS_ENV
echo ==================

#apt-get -y update
#apt-get -y install $DEPENDENCIES 

# set up nodejs
printf "\n\n=========== setting up symlinks for $NODEJS_ID\n"
ln -s /opt/joebotics/$NODEJS_ID         /opt/joebotics/nodejs
ln -s /opt/joebotics/nodejs/bin/node    /usr/bin/node 
ln -s /opt/joebotics/nodejs/bin/npm     /usr/bin/npm
ln -s /opt/joebotics/nodejs/bin/node    /usr/local/bin/node 
ln -s /opt/joebotics/nodejs/bin/npm     /usr/local/bin/npm

# copy global node node_modules
printf "\n\n=========== installing odroid global module in /opt/joebotics/lib/node_modules\n"
mkdir -p /opt/joebotics/lib/node_modules
cd /opt/joebotics/lib
#/usr/bin/npm install odroid-gpio

# fix permissions
printf "\n\n=========== fixing permissions\n"

# simmer launcher......
chown root:odroid /opt/joebotics/bin/launch-simmer.sh
chmod g+x /opt/joebotics/bin/launch-simmer.sh

# simmer killer......
chown root:odroid /opt/joebotics/bin/stop-simmer.sh
chmod g+x /opt/joebotics/bin/stop-simmer.sh

# everything else......
chown root:odroid /opt
chown root:odroid /opt/joebotics
chown -R root:odroid /opt/joebotics
chown -R odroid:odroid /home/odroid

# add applications to PATH
ln -s /opt/joebotics/bin/launch-simmer.sh /usr/local/bin/launch-simmer
ln -s /opt/joebotics/bin/stop-simmer.sh /usr/local/bin/stop-simmer


echo "================================ chroot-stg2.sh done ======================================"

