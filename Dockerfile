#FROM ubuntu:14.04.1
FROM eclipse/ubuntu_jdk8
USER root
# This prevents us from get errors during apt-get installs as it notifies the
# environment that it is a non-interactive one.
ENV DEBIAN_FRONTEND noninteractive

# TRUSTY-BACKPORTS
# We all the trusty-backports source as this will give us access to a povray
# package.  Not having to build this package from source great decreases the
# final size of the container.
#RUN \
#  sudo echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

# POVRAY
RUN \
  apt-get update && \
  apt-get -y install  && \
  rm -rf /var/lib/apt/lists/*

# FFMPEG
# We install ffmpeg using a respected PPA by Jon Severinsson.  This PPA is
# well maintained and recommended by the official ffmpeg website.  It builds
# ffmpeg in a shared library mode with all it's dependencies included.
RUN \
  apt-get update && \
  apt-get -y install \
    software-properties-common && \
  sudo add-apt-repository ppa:jonathonf/ffmpeg-4 && \
  apt-get update && \
  apt-get -y install \
    --force-yes ffmpeg && \
  rm -rf /var/lib/apt/lists/*

# IMAGEMAGICK
# Install all the recommended and suggested packages for ImageMagick
RUN \
  apt-get update && \
  apt-get -y install \
    ghostscript \
    libglu1-mesa \
    libwebkitgtk-1.0-0 \
#    libmagickcore5-extra \
    netpbm \
    autotrace \
    cups-bsd \
    curl \
    enscript \
    gimp \
    grads \
    groff-base \
    hp2xx \
    html2ps \
    libwmf-bin \
    mplayer \
    radiance \
    sane-utils \
    texlive-binaries \
    transfig \
    ufraw-batch \
    xdg-utils && \
  apt-get -y install \
    gnuplot \
    imagemagick-doc \
    imagemagick && \
  rm -rf /var/lib/apt/lists/*

# Clean the cache created by package installations
RUN \
  apt-get clean

# install java 8 配置ppa源
#RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list && \
#  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list && \
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
#RUN \
#  add-apt-repository ppa:webupd8team/java && \
#  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
#  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
#  apt-get update && \
#  apt-get install -y oracle-java8-installer

# 添加file-server-api服务文件
ADD fileServer /fileServer

