FROM ubuntu:xenial-20181005

MAINTAINER Erwin "m9207216@gmail.com"

# for kernel/scripts/mkkrnlimg 32bit
RUN dpkg --add-architecture i386

# https://github.com/sameersbn/docker-gitlab/blob/master/Dockerfile
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    wget ca-certificates apt-transport-https \
# RK3326_LINUX_SDK_BETA_20180426发布说明.pdf
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    repo git-core gitk git-gui gcc-arm-linux-gnueabihf u-boot-tools device-tree-compiler \
# gcc-aarch64-linux-gnu mtools parted libudev-dev libusb-1.0-0-dev lib32gcc-7-dev \
    gcc-aarch64-linux-gnu mtools parted libudev-dev libusb-1.0-0-dev \
# python-linaro-image-tools linaro-image-tools g++-7 libstdc++-7-dev autoconf autotools-dev \
    python-linaro-image-tools linaro-image-tools autoconf autotools-dev \
    libsigsegv2 m4 intltool libdrm-dev curl sed make binutils build-essential gcc g++ bash patch gzip \
    bzip2 perl tar cpio python unzip rsync file bc wget libncurses5 libqt4-dev libglib2.0-dev libgtk2.0-dev \
    libglade2-dev cvs git mercurial rsync openssh-client subversion asciidoc w3m dblatex \
    graphviz python-matplotlib \
#
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y locales libssl-dev libncurses-dev \
# kernel tools
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y liblz4-tool \
# for kernel/scripts/mkkrnlimg 32bit
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y libc6:i386 libncurses5:i386 libstdc++6:i386 \
 && locale-gen en_US.UTF-8 \
 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 -r aosp
RUN useradd -u 1000 --create-home -r -g aosp aosp
USER aosp
RUN git config --global user.email "aosp@example.com"
RUN git config --global user.name "aosp"
ENV LANG en_US.UTF-8
RUN [ "/bin/bash" ]
