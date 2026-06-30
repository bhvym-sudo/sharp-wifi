#!/bin/sh

# luna firmware upgrade preparation script
#$1 image to be updated (0 or 1) 
#$2 image tar ball file name

case "$2" in
	/*)
		img="$2"
		;;
	*)
		img="`pwd`/$2"
		;;
esac
sentinel="fwu.sh"
md5_cmp="md5.txt"
md5_cmd="/bin/md5sum"
md5_tmp="md5_tmp" 
md5_rt_result="md5_rt_result.txt"
lock_ver="fwu_ver"
prihwver="/tmp/prihwver"
weblock_ver="/tmp/weblock_ver"
ponlock_ver="/tmp/ponlock_ver"
# Stop this script upon any error
set -e

# Parameter validation
if [ $# != 2 ]; then
    echo "Error: Incorrect arguments."
    echo "Usage: $0 <image ID to be updated> <image file>"
    echo "<image ID to be updated>: 0 | 1 "
    echo "<image file>: e.g., img.tar"
    exit 1
fi

if [ $1 != 0  ] && [ $1 != 1 ]; then
    echo "Error: <image ID to be updated>: 0 | 1 "
    echo "Usage: $0 <image ID to be updated> <image file>"
    exit 1
fi

if [ ! -f $2 ]; then
    echo "Error: $2 doesn't exist."
    echo "Usage: $0 <image ID to be updated> <image file>"
    exit 1
fi

tmp_dir="/tmp/fwu"
if [ -d $tmp_dir ]; then
    rm -rf $tmp_dir
fi
mkdir -p $tmp_dir

cd $tmp_dir 
tar -xf $img $sentinel $md5_cmp 
if [ $? != 0 ]; then 
    echo "Failed to extract $img, aborted image updating !"
    exit 1
fi

grep $sentinel $md5_cmp > $md5_tmp
$md5_cmd $sentinel > $md5_rt_result
diff $md5_rt_result $md5_tmp

if [ $? != 0 ]; then 
    echo "$sentinel md5_sum inconsistent, aborted image updating !"
    exit 1
fi

# Add by peichao.li for bug#0003553
echo "tar -xf $img $lock_ver"
tar -xf $img $lock_ver
echo "cat $prihwver"
if [ -e $prihwver ]; then
up_hwver=`cat $prihwver`
if cat $lock_ver | grep $up_hwver; then
	echo "HWVER CHECK PASS"
elif cat $prihwver | grep "=-"; then
	echo "HWVER CHECK NONE"
else
	echo "HWVER CHECK FAILD"
	reboot -f
	exit 1
fi
fi
# End of bug#0003553

# Add by peichao.li for bug#0003758
tar -xf $img $lock_ver
if [ -e $ponlock_ver ]; then
	pon_lock_str=`cat $ponlock_ver`
else
	pon_lock_str="PONUNLOCK"
fi

if [ $pon_lock_str = "PONUNLOCK" ]; then
	echo "pon unlock"
else
	if cat $lock_ver | grep $pon_lock_str; then
		echo "pon locking"
	else
		echo "pon locked cant't to unlock"
		reboot -f
		exit 1
	fi
fi
# End of bug#0003470 bug#0003758

# Add by peichao.li for bug#0003563
if [ -e $weblock_ver ]; then
web_logo_str=`cat $weblock_ver`
else
web_logo_str="weblogounknow"
fi
if [ $web_logo_str = "weblogounknow" ]; then
	echo "weblogo unknow"
else
	if cat $lock_ver | grep $web_logo_str; then
		echo "weblogo locking"
	else
		echo "weblogo cant't change to unknow"
		reboot -f
		exit 1
	fi
fi
# End of bug#0003563

# Run firmware upgrade script extracted from image tar ball
sh $sentinel $1 $img 
if [ $? != 0 ]; then
    echo "Incorrect image, aborted image updating !"
    exit 1
fi

