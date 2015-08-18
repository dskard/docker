# debian 7 container with Rappture Toolkit
#

FROM debian:7
MAINTAINER derrick kearney <telldsk@gmail.com>


# install packages needed to build core rappture libraries
RUN apt-get -qqy update && apt-get -qqy install \
    curl \
    gcc \
    g++ \
    libssl-dev \
    make \
    patch \
    subversion \
    libx11-dev \
    libxt-dev \
    libxext-dev \
    libfreetype6-dev \
    libxft-dev \
    libgl1-mesa-dev \
    libxrandr-dev \
    libpng12-dev \
    libjpeg8-dev \
    libtiff4-dev \
    libxpm-dev \
    libncurses5-dev \
    libavcodec-dev \
    libavformat-dev

# install packages needed to build language bindings for
# fortran, octave, perl, python, ruby, R, java
RUN apt-get -qqy install \
    gfortran \
    octave \
    liboctave-dev \
    perl \
    libperl-dev \
    python \
    python-dev \
    ruby \
    ruby-dev \
    r-base \
    openjdk-7-jdk \
    openjdk-7-jre

# install extra support packages
RUN apt-get -qqy install \
    gdb \
    libavutil-dev


# setup a guest user
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/guest && \
    echo "guest:x:${uid}:${gid}:Guest,,,:/home/guest:/bin/bash" >> /etc/passwd && \
    echo "guest:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/guest


# build rappture
# RUN ./build_rappture.sh
RUN \
    set -e; \
    set -x; \
    \
    mkdir -p /tmp/rappture; \
    cd /tmp/rappture; \
    curl https://nanohub.org/infrastructure/rappture-bat/svn/branches/1.3/buildscripts/checkout_repos.sh > checkout_repos.sh; \
    chmod 744 checkout_repos.sh; \
    ./checkout_repos.sh -s hcgrid.sh -c current;

# start the rappture tool
USER guest
VOLUME /home/guest
WORKDIR /home/guest
ENTRYPOINT ["/tmp/rappture/repo/builds/current/bin/rappture"]
