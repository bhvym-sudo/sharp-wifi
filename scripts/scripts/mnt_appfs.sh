#!/bin/sh
# @Last Change: Bohannon
# @Revision:    1.01

# Mount /var/app based mtd partitin name "app"
# $1: arguments for mount command (file system type and etc) 
# $2: mtd name
# $3: directory to be mounted onto

# Parameters validation
if [ $# != 3 ]; then
    echo "Argument is $#, but it should be 3"
    echo "Usage: $0 <arguments for mount command> <mtd_name> <directory>"
    echo "<arguments for mount command> e.g., \"-t jffs2\", or \"-t  yaffs2 -o tags-ecc-off\""
    echo "<mtd_name> e.g., \"config\""
    echo "<directory> e.g., \"/var/config\""
    exit 1
fi

mount_param="$1"
mtd_name="$2"
mount_dir="$3"

# Check existence of destination direcotry 
if [ ! -d "${mount_dir}" ]; then
    # Try to create it if it doesn't exist
    mkdir -p ${mount_dir}
    if [ $? != 0 ]; then
        echo "Error: directory ${mount_dir} doesn't exist and cannot be created"
        # exit if fails
	exit 2
    fi
fi


# Find out mtd ID by name
appfs_mtd=`cat /proc/mtd | grep "${mtd_name}" | sed 's/^mtd\(.*\):.*$/\1/g'`
echo "Mounting /dev/mtdblock"$appfs_mtd" onto ${mount_dir} as the configuration data storage"

mtd_valid=`ls "/dev/mtdblock""$appfs_mtd"`
if [ "$mtd_valid" == "" ]; then
    echo "Warning: cannot find the corresponding MTD to mount."
    exit 2
fi

# Try mounting 
mount ${mount_param} "/dev/mtdblock""$appfs_mtd" ${mount_dir}
