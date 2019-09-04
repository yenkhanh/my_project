#! /bin/bash
echo test-1-2-1
echo "enter an [of] parameter (that should be /dev/sdx)."
echo -n "of="
read DEVICE
echo $DEVICE

sudo dd if=MscTestData.bin of=$DEVICE bs=512 count=1 oflag=direct

TRANSPORT=512
while [ $TRANSPORT -le $((1024*1024*1024)) ]
do
sudo dd if=MscTestData.bin of=$DEVICE bs=$TRANSPORT seek=1 skip=1 count=1 oflag=direct
TRANSPORT=$((TRANSPORT+TRANSPORT))
done
