#!/bin/bash

docker run -it \
  --net=host \
  --privileged \
  -v /dev:/dev \
  -v $(pwd)/test_install:/opt/test_install \
  --name ${1:-ncs2} \
  ${2:-ncs2} \
  /bin/bash
