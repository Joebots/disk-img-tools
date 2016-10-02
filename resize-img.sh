while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -i|--diskimg)
    DISKIMG="$2"
    shift # past argument
    ;;

    -s|--size) 
    INCREASE="$2"
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

usage(){ echo "resize-img.sh -i <disk img> -s <increased volume>"; }

if [[ !(-n $DISKIMG) ]]; then
	ERR=true
else
	echo "disk image:$DISKIMG"
fi

if [[ !(-n $INCREASE) ]]; then
        ERR=true
else
	echo "increase:$INCREASE"
fi

if [[ (-o ERR) ]]; then
	usage
	exit	
fi

sudo truncate -s +`echo $INCREASE`M $DISKIMG

LBDEV=`sudo losetup -f`

sudo losetup $LBDEV $DISKIMG
sudo partprobe $LBDEV
sudo gparted $LBDEV
sudo losetup -d  $LBDEV
