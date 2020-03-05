FROM ghokun/nlopt:latest
LABEL maintainer="ghokun.github.io"

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -qq -y --no-install-recommends \
                build-essential \
                cmake \
                git \
                ca-certificates \
                pkg-config \
                openssh-client \
                libxtst-dev \
                libxext-dev \
                libxrender-dev \
                libfreetype6-dev \
                libfontconfig1 \
                libgtk-3-dev \
                qt5-default \
                libxslt1.1 \
                libxxf86vm1 \
                mesa-utils \
                mesa-utils-extra \
                libavcodec-dev \
                libavformat-dev \
                libswscale-dev \
                libv4l-dev \
                libxvidcore-dev \
                libx264-dev \
                libtbb2 \
                libtbb-dev \
                libjpeg-dev \
                libpng-dev \
                libtiff-dev \
                libdc1394-22-dev \
                libatlas-base-dev \
                gfortran \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*
 
WORKDIR /opt
RUN git clone https://github.com/opencv/opencv_contrib.git \
 && git clone https://github.com/opencv/opencv.git

WORKDIR /opt/opencv
RUN mkdir build \
 && cd build \
 && cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local/ \
          -D CPU_BASELINE=SSE4_2 \ 
          -D WITH_OPENCL=ON \
          -D WITH_IPP=ON \
          -D WITH_TBB=ON \
          -D WITH_V4L=ON \
          -D WITH_OPENGL=ON \
          -D WITH_QT=ON \
          -D BUILD_EXAMPLES=OFF \
          -D INSTALL_C_EXAMPLES=OFF \
          -D INSTALL_PYTHON_EXAMPLES=OFF \
          -D BUILD_TESTS=OFF \
          -D BUILD_PERF_TESTS=OFF \
          -D OPENCV_ENABLE_NONFREE=ON \
          -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules \
          .. \
 && make -j$(nproc) \
 && make install \
 && ldconfig \
 && rm -rf /opt/opencv \
 && rm -rf /opt/opencv_contrib

WORKDIR /opt
CMD ["/bin/bash"]
