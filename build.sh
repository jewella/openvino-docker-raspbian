#!/bin/bash

if [ ! -d "inference_engine_vpu_arm" ]; then
    bash ./get_toolkit
fi

docker build . -t ncs2
