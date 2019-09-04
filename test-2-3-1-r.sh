#! /bin/bash
echo test-2-3-1-R
echo "enter the mount point (that should be /Volumes/<label>)."
echo -n "MSC_VOLUME_MOUNT_POINT="
read MSC_VOLUME_MOUNT_POINT

TEST_DATA_FILE="MscTestData256MB.bin"
START_TIME="$(date +%T)"

for i in 'seq 1'
do
echo "START[$START_TIME] >> NOW:[$(date +%T)]"

rsync -v --progress "$MSC_VOLUME_MOUNT_POINT/$TEST_DATA_FILE" test-2-3-1-R.bin
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] rsync Done"
else
  echo "[$(date +%T)] rsync Failed"
  break
fi

cmp -l test-2-3-1-R.bin $TEST_DATA_FILE
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] cmp Passed"
else
  echo "[$(date +%T)] cmp Failed"
  break
fi
done

echo "START[$START_TIME] >> END:[$(date +%T)]"
