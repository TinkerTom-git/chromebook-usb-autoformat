#!/bin/sh

# this script uses awk, cgpt, expr, grep, mkfs.ext4, parted
# we're assuming /dev/sd*, don't know how well this works for /dev/mmcblk*
# and we're formatting 

if [ -z $1 ]
  then 
    echo "no target! try something like autoformat.sh /dev/sda (no trailing /)"
    exit 1
fi

TARGET=$1
PART2="${TARGET}2"
PART2SIZE=$(expr $(cgpt show $TARGET | grep "Sec GPT table" | awk '{ print $1 }') - 40960)

echo " targeting $1, 16MiB kernel partition, using the rest for RootFS"

parted $TARGET mklabel gpt

cgpt create $TARGET
cgpt add -i 1 -b 8192 -s 32768 -t kernel -l Kernel -P 10 -T 5 -S 1 $TARGET
cgpt add -i 2 -b 40960 -s $PART2SIZE -t data -l Root $TARGET
sync
partprobe
mkfs.ext4 "${PART2}"
