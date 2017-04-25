#!/usr/bin/env bash

echo; echo; echo "================================ get-code.sh start ======================================"

# download code from git master
JB_NODE_SRC=$JOEBOTICS_HOME/node-projects
JB_DEST_HOME=$ROOTFS/opt/joebotics
JB_NODE_DEST=$JB_DEST_HOME/node-projects

echo ============================================================
echo "get-code.sh $JOEBOTICS_HOME"
cd $JOEBOTICS_HOME

if [[ -n $CLEAN_CODE ]]; then
    echo ============================================================
    echo "get-code cleaning $JB_NODE_SRC $JB_DEST_HOME"
    sudo rm -fr $JB_NODE_SRC 
    sudo rm -fr $JB_NODE_DEST
    CLONE_CODE=true
fi

if [[ -n $FETCH_CODE ]]; then
    echo ============================================================
    echo "fetching into $JB_NODE_SRC"
    cd $JB_NODE_SRC
    git fetch
    COPY_CODE=true
fi

if [[ -n $CLONE_CODE ]]; then
    echo ============================================================
    echo cloning joebotics nodejs code into $JB_NODE_SRC
    echo "cloning into $JB_NODE_SRC which should equal $JOEBOTICS_HOME/node-projects"
    #mkdir -p $JB_NODE_SRC
    #cd $JB_NODE_SRC
    cd $JOEBOTICS_HOME
    git clone git@github.com:Joebots/node-projects.git
    cd node-projects/build
    npm install
    #sudo rm -fr $JB_NODE_DEST
    COPY_CODE=true
fi

if [[ -n $COPY_CODE ]]; then
    echo ============================================================
    echo copying code from $JB_NODE_SRC to $JB_DEST_HOME
    sudo mkdir -p $JB_NODE_DEST
    sudo cp -r $JB_NODE_SRC $JB_DEST_HOME
fi

cd $BUILD_HOME

echo "================================ get-code.sh done ======================================"