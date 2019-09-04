#! /bin/bash
echo test-2-2-1
echo "enter an [of] parameter (that should be /dev/rdiskN)."
echo -n "of="
read DEVICE
echo $DEVICE

sudo dd if=MscTestData.bin of=$DEVICE bs=512 count=1

TRANSPORT=512
while [ $TRANSPORT -le $((1024*1024*1024)) ]
do
sudo dd if=MscTestData.bin of=$DEVICE bs=$TRANSPORT seek=1 skip=1 count=1
TRANSPORT=$((TRANSPORT+TRANSPORT))
done
