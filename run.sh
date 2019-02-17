docker run -it \
  --net=host \
  --privileged \
  -v /dev:/dev \
  -v $(pwd)/test_app:/opt/test_app \
  --name ncs2 \
  ncs2 \
  /bin/bash
