# debian 7 container with Rappture Toolkit
#

FROM debian:7
MAINTAINER derrick kearney <telldsk@gmail.com>


# install packages needed to build core rappture libraries
RUN apt-get -qqy update && apt-get -qqy install \
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

# install packages that would have been provided by runtime.
# no packages for the following:
#   htmlwidget
#   shape
#   vtk
RUN apt-get -qqy install \
    cmake \
    libexpat1-dev \
    expect \
    expect-dev \
    itcl3-dev \
    itk3-dev \
    libjpeg8-dev \
    libpng12-dev \
    libssl-dev \
    libsqlite3-tcl \
    tcl-dev \
    tcllib \
    tdom-dev \
    libtiff5-dev \
    tk-dev \
    libgnutls-dev \
    zlib1g-dev \
    libtk-img-dev



# setup a guest user
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/guest && \
    echo "guest:x:${uid}:${gid}:Guest,,,:/home/guest:/bin/bash" >> /etc/passwd && \
    echo "guest:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/guest


# build rappture
RUN \
    set -e; \
    set -x; \
    \
    repo_base="https://nanohub.org/infrastructure"; \
    rappture_branch="branches/r9"; \
    rappture_build_dir="/opt/rappture"; \
    repo_dir="repos"; \
    \
    rappture_url="${repo_base}/rappture/svn/${rappture_branch}"; \
    \
    mkdir -p ${rappture_build_dir}/${repo_dir}; \
    cd ${rappture_build_dir}/${repo_dir}; \
    \
    svn -q checkout ${rappture_url} rappture; \
    mkdir -p runtime; \
    cd rappture; \
    \
    ./configure \
        --exec_prefix=${rappture_build_dir} \
        --prefix=${rappture_build_dir} \
        --with-vtk; \
    make; \
    make install; \
    \
    rm -rf ${rappture_build_dir}/${repo_dir};

# start the rappture tool
USER guest
VOLUME /home/guest
WORKDIR /home/guest
ENTRYPOINT ["/opt/rappture/bin/rappture"]
