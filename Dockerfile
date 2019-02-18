FROM raspbian/stretch

ARG INSTALL_DIR="/opt/intel/inference_engine_vpu_arm"

RUN apt-get update && apt-get -y upgrade && apt-get autoremove && \
    apt-get install -y --no-install-recommends \
        build-essential \
	cmake \
        cpio \
        lsb-release \
        pciutils \
        python3.5 \
        python3.5-dev \
        python3-pip \
        python3-setuptools \
	ffmpeg \
	libjpeg-dev \
        libtiff5-dev \
        libjasper-dev \
        libpng12-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libxvidcore-dev \
        libx264-dev \
        libgtk2.0-dev \
        libgtk-3-dev \
        libatlas-base-dev \
        gfortran \
        libgstreamer1.0-0 \
        libgstreamer-plugins-base1.0-0

RUN usermod -a -G users "$(whoami)"

COPY inference_engine_vpu_arm $INSTALL_DIR 

RUN sed -i "s|<INSTALLDIR>|$INSTALL_DIR|" $INSTALL_DIR/bin/setupvars.sh && \
    echo "source $INSTALL_DIR/bin/setupvars.sh" >> $HOME/.bashrc

RUN ["/bin/bash", "-c", "source $INSTALL_DIR/bin/setupvars.sh && /bin/bash $INSTALL_DIR/install_dependencies/install_NCS_udev_rules.sh"]

RUN pip3 install numpy

RUN apt autoremove -y && \
    rm -rf  /var/lib/apt/lists/*

CMD ["/bin/bash"]
