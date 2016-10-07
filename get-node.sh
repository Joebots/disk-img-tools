if [[ -n $INSTALL_NODE ]]; then

    # load nodejs env
    . $BUILD_HOME/arch-env/${OS}.img.sh

    if [[ !(-d $ROOTFS/opt/joebotics/$NODEJS_ID) ]]; then
        rm -fr $ROOTFS/opt/joebotics/$NODEJS_ID
    fi
    
    echo saving nodejs download in $JOEBOTICS_HOME/${OS}
    mkdir -p $JOEBOTICS_HOME/${OS}
    cd $JOEBOTICS_HOME/${OS}

    wget https://nodejs.org/dist/$NODEJS_VER/$NODEJS_FILE
    unxz $NODEJS_FILE
    tar -xf $NODEJS_ID.tar
    
    COPY_NODE=true
fi

if [[ -n $COPY_NODE ]]; then

    # load nodejs env
    . $BUILD_HOME/arch-env/${OS}.img.sh

    cd $JOEBOTICS_HOME/${OS}

    echo sudo chown -R root:root $NODEJS_ID
    sudo chown -R root:root $NODEJS_ID
    
    echo sudo mkdir -p $ROOTFS/opt/joebotics/$NODEJS_ID
    sudo mkdir -p $ROOTFS/opt/joebotics/$NODEJS_ID
    
    echo sudo cp -r $JOEBOTICS_HOME/${OS}/$NODEJS_ID $ROOTFS/opt/joebotics
    sudo cp -r $JOEBOTICS_HOME/${OS}/$NODEJS_ID $ROOTFS/opt/joebotics
fi

cd $BUILD_HOME
