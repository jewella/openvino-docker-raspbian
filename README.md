Download the openvino toolkit before building the image.
```bash
$ bash ./get_toolkit.sh
```

alternatively, you can use the build script which will download the toolkit if necessary, and build the image with a default tag of 'ncs2'.


To start the container in interactive mode and test that the toolkit is installed correctly, place a test image in test_install/images/face.jpg and pass the path to the openvino-sdk installation directory
```bash
$ bash ./run.sh my-image my-container
root@host:/# bash /opt/test_install/test.sh $INSTALLDIR
```
the output image with bounding box will be in test_install/images/out_0.bmp (or something similar)
