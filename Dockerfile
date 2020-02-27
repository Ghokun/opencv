FROM ubuntu:18.04
LABEL maintainer="ghokun.github.io"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ yakkety universe" | sudo tee -a /etc/apt/sources.list \
 && DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -qq -y --no-install-recommends \
                build-essential \
                cmake \
                git \
                ca-certificates \
                libgtk2.0-dev \
                pkg-config \
                libavcodec-dev \
                libavformat-dev \
                libswscale-dev \
                libtbb2 \
                libtbb-dev \
                libjpeg-dev \
                libpng-dev \
                libtiff-dev \
                libjasper-dev \
                libdc1394-22-dev \
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
 	        -D BUILD_opencv_legacy=OFF \
 	        -D BUILD_TIFF=ON \
 	        -D ENABLE_AVX=ON \
 	        -D WITH_OPENCL=ON \
 	        -D WITH_IPP=ON \
 	        -D WITH_TBB=ON \
 	        -D WITH_V4L=ON \
 	        -D WITH_OPENGL=ON \
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

CMD ["/bin/bash"]
