# download code from git master
echo ============================================================
echo cloning joebotics nodejs code
rm -fr /tmp/node-projects /tmp/simmer-maven

cd /tmp
git clone git@github.com:Joebots/node-projects.git
cd node-projects/build
npm install

sudo mkdir -p $ROOTFS/opt/joebotics/node-projects
sudo mv /tmp/node-projects/* $ROOTFS/opt/joebotics/node-projects

cd $BUILD_HOME

