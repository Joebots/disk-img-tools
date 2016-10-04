#!/bin/bash
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

    --default)
    DEFAULT=YES
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
    OS=`basename $DISKIMG | sed 's/\..*//g'`
    echo "disk image:${DISKIMG}"
fi

if [[ !(-n $QARCH) ]]; then
    echo "No qemu architecture specified"
    ERR=true
else
    echo "using qemu executable: qemu-${QARCH}"
fi

if [[ !(-n $BUILD_HOME/$QARCH.sh) ]]; then
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

