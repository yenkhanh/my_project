#! /bin/bash
echo test-1-3-1-W
echo "enter the mount point (that should be /media/<label>/<uuid>)."
echo -n "MSC_VOLUME_MOUNT_POINT="
read MSC_VOLUME_MOUNT_POINT

TEST_DATA_FILE="MscTestData256MB.bin"
START_TIME="$(date +%T)"

for i in 'seq 1'
do
echo "START[$START_TIME] >> NOW:[$(date +%T)]"

rm "$MSC_VOLUME_MOUNT_POINT/test-1-3-1-W.bin"
echo "[$(date +%T)] rm Done"

echo "[$(date +%T)] '$TEST_DATA_FILE' -> '$MSC_VOLUME_MOUNT_POINT/test-1-3-1-W.bin'"
rsync -v --progress $TEST_DATA_FILE "$MSC_VOLUME_MOUNT_POINT/test-1-3-1-W.bin"
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] rsync Done"
else
  echo "[$(date +%T)] rsync Failed"
  break
fi

# Invalidate disk cache. Or no access to USB is carried out.
sync && echo 1 > /proc/sys/vm/drop_caches
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] disk cache sync && drop_caches Done"
else
  echo "[$(date +%T)] disk cache sync && drop_caches Failed"
  break
fi

echo "[$(date +%T)] '$MSC_VOLUME_MOUNT_POINT/test-1-3-1-W.bin' -> 'test-1-3-1-WR.bin'"
rsync -v --progress "$MSC_VOLUME_MOUNT_POINT/test-1-3-1-W.bin" test-1-3-1-WR.bin
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] rsync Done"
else
  echo "[$(date +%T)] rsync Failed"
  break
fi

cmp -l test-1-3-1-WR.bin $TEST_DATA_FILE
if [ $? -eq 0 ] ; then
  echo "[$(date +%T)] cmp Passed"
else
  echo "[$(date +%T)] cmp Failed"
  break
fi
done

echo "START[$START_TIME] >> END:[$(date +%T)]"
