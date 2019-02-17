FROM raspbian/stretch

ARG INSTALL_DIR="/opt/intel/inference_engine_vpu_arm"

RUN apt-get update && apt-get -y upgrade && apt-get autoremove

#Install needed dependences
RUN apt-get install -y --no-install-recommends \
        build-essential \
	cmake \
	libjpeg-dev \
	libtiff5-dev \
	libpng12-dev \
	libatlas-base-dev \
	gfortran \
        cpio \
        curl \
        git \
        lsb-release \
        pciutils \
        python3.5 \
        python3.5-dev \
        python3-pip \
        python3-setuptools \
	ffmpeg \
        sudo

RUN usermod -a -G users "$(whoami)"

COPY inference_engine_vpu_arm $INSTALL_DIR 

RUN sed -i "s|<INSTALLDIR>|$INSTALL_DIR|" $INSTALL_DIR/bin/setupvars.sh && \
    echo "source $INSTALL_DIR/bin/setupvars.sh" >> $HOME/.bashrc

RUN ["/bin/bash", "-c", "source $INSTALL_DIR/bin/setupvars.sh && /bin/bash $INSTALL_DIR/install_dependencies/install_NCS_udev_rules.sh"]

RUN pip3 install numpy

RUN apt autoremove -y && \
    rm -rf  /var/lib/apt/lists/*

CMD ["/bin/bash"]
