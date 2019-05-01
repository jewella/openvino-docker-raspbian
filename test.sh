#!/bin/bash

if ! [ -e test_install/images/face.jpg ]
then
	echo "FAILURE: Test face image not found"
	exit 1;
fi

echo "INFO: Running container"
docker run -t \
  -d \
  --net=host \
  --privileged \
  -v /dev:/dev \
  -v $(pwd)/test_install:/opt/test_install \
  --name ${1:-ncs2} \
  ${2:-ncs2} \
  /bin/bash

echo "INFO: Executing test"
docker exec ${1:-ncs2} /bin/bash -c -l '/opt/test_install/test.sh $INSTALLDIR'

echo "INFO: Stopping ${1:-ncs2} container"
docker container stop ${1:-ncs2}

echo "INFO: Removing ${1:-ncs2} container"
docker container rm ${1:-ncs2}

if [ -e test_install/images/out_0.bmp ]
then
	echo "SUCCESS: Output detection image found"
	rm -f test_install/images/out_0.bmp
	exit 0
else
	echo "FAILURE: Output detection image not found"
	exit 1
fi

