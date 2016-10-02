# download code from git master
echo ============================================================
echo cloning joebotics nodejs code
cd /tmp 
rm -fr node-projects simmer-maven

git clone git@github.com:Joebots/node-projects.git
cd node-projects/build
npm install
cd ../..

sudo mv node-projects $ROOTFS/opt/joebotics/node-projects

cd $BUILD_HOME

