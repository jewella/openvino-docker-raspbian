#!/bin/bash

cd "$1/deployment_tools/inference_engine/samples"
if [ ! -d build ]; then
  mkdir build
fi
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-march=armv7-a"
make -j4 object_detection_sample_ssd
wget --no-check-certificate https://download.01.org/openvinotoolkit/2018_R4/open_model_zoo/face-detection-adas-0001/FP16/face-detection-adas-0001.bin
wget --no-check-certificate https://download.01.org/openvinotoolkit/2018_R4/open_model_zoo/face-detection-adas-0001/FP16/face-detection-adas-0001.xml
./armv7l/Release/object_detection_sample_ssd -m face-detection-adas-0001.xml -d MYRIAD -i /opt/test_install/images/face.jpg
mv -f ./out_0.bmp /opt/test_install/images
