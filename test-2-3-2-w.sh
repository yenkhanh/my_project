#! /bin/bash
echo test-2-3-2-W
echo "enter the mount point (that should be /Volumes/<label>)."
echo -n "MSC_VOLUME_MOUNT_POINT="
read MSC_VOLUME_MOUNT_POINT

TEST_DATA_FILE="MscTestData256MB.bin"
START_TIME="$(date +%T)"

while :
do
echo "START[$START_TIME] >> NOW:[$(date +%T)]"

rm "$MSC_VOLUME_MOUNT_POINT/test-2-3-2-W.bin"
echo "[$(date +%T)] rm done"

rsync -v --progress $TEST_DATA_FILE "$MSC_VOLUME_MOUNT_POINT/test-2-3-2-W.bin"
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] done"
else
  echo "[$(date +%T)] failed"
  break
fi

rsync -v --progress "$MSC_VOLUME_MOUNT_POINT/test-2-3-2-W.bin" test-2-3-2-WR.bin
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] rsync Done"
else
  echo "[$(date +%T)] rsync Failed"
  break
fi

cmp -l test-2-3-2-WR.bin $TEST_DATA_FILE
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] cmp Passed"
else
  echo "[$(date +%T)] cmp Failed"
#  break
fi
done

echo "START[$START_TIME] >> END:[$(date +%T)]"
