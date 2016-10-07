#!/bin/bash
for var in "$@"
do
    if [[ "$var" == "--fetch-code" ]]; then
        FETCH_CODE=true
        echo "FETCHING CODE."
    fi;
    
    if [[ "$var" == "--clone-code" ]]; then
        CLONE_CODE=true
        echo "CLONING CODE."
    fi;
    
    if [[ "$var" == "--clean-code" ]]; then
        CLEAN_CODE=true
        echo "CLEANING CODE."
    fi;
    
    if [[ "$var" == "--copy-code" ]]; then
        COPY_CODE=true
        echo "COPYING LOCAL CODE."
    fi;
    
    if [[ "$var" == "--copy-node" ]]; then
        COPY_NODE=true
        echo "COPYING LOCAL NODEJS INSTALL."
    fi;
    
    if [[ "$var" == "--install-node" ]]; then
        INSTALL_NODE=true
        echo "INSTALLING NODEJS LOCALLY FOR DEPLOYMENT ON DISK IMAGES."
    fi;
done

# Use -gt 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use -gt 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --default example).
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -i|--diskimg)
    DISKIMG="$2"
    OS=`basename $DISKIMG | sed 's/\.img//g'`
    OS_ENV=$BUILD_HOME/arch-env/$OS.img.sh    
    shift # past argument
    ;;

    -a|--qemu-arch)
    QARCH="$2"
    shift # past argument
    ;;

    -e|--execute)
    STG2EXEC="$2"
    shift # past argument
    ;;

    --clean)
    CLEAN=true
    shift # past argument
    ;;

    --fetch)
    FETCH=true
    ;;
    
    --clone)
    CLONE=true
    ;;
    
    --node)
    INSTALL_NODE=true
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

usage(){ echo "run.sh -i <disk img> -a <qemu arch> -e <stg 2 command>"; }

if [[ !(-n $DISKIMG) ]]; then
    echo "No disk image specified"
    ERR=true
else
    echo "disk image:${DISKIMG}"
fi

if [[ !(-n $QARCH) ]]; then
    echo "No qemu architecture specified"
    ERR=true
else
    echo "using qemu executable: qemu-${QARCH}"
fi

if [[ !(-n $OS_ENV.sh) ]]; then
    echo "No qemu architecture environment file exists"
    ERR=true
fi


if [[ (-n $ERR) ]]; then
    usage
    exit
fi

if [[ !(-n $STG2EXEC) ]]; then
    echo "No command specified, defaulting to /bin/bash"
else
    echo "Executing script '${STG2EXEC}' in chroot"
fi

