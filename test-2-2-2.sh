#! /bin/bash
echo test-2-2-2
echo "enter an [if] parameter (that should be /dev/rdiskN)."
echo -n "if="
read DEVICE
echo $DEVICE

sudo dd if=$DEVICE of=test-2-2-2.bin bs=512 count=1
TRANSPORT=512
while [ $TRANSPORT -le $((1024*1024*1024)) ]
do
sudo dd if=$DEVICE of=test-2-2-2.bin bs=$TRANSPORT seek=1 skip=1 count=1
TRANSPORT=$((TRANSPORT+TRANSPORT))
done
