# debian 7 container with rstudio desktop / server 1.0.143
#

FROM debian:7
MAINTAINER derrick kearney <telldsk@gmail.com>


# install packages needed to build
#
# package            needed to...
#

RUN apt-get -qqy update && apt-get -qqy install \
    aptitude \
    apt-utils

RUN aptitude -q -q -y install \
    git \
    bzip2

RUN aptitude -q -q -y install \
    libpango1.0-dev \
    libbz2-dev \
    liblzma-dev

RUN aptitude -q -q -y install \
    tcl-dev \
    tk-dev

RUN aptitude -q -q -y install \
    openjdk-7-jre

#RUN aptitude -q -q -y install \
#    qt5core-dev

# add wheezy backports mirror
RUN \
    set -ex; \
    \
    echo "deb http://ftp.debian.org/debian wheezy-backports main" > /etc/apt/sources.list.d/backports.list; \
    aptitude update;


RUN aptitude -q -q -y install \
    libnetcdf-dev \
    libv8-3.14-dev \
    libproj-dev \
    libudunits2-dev \
    libgdal-dev

# clone the git repository
RUN \
    set -ex; \
    \
    git clone https://github.com/codedsk/qs.git /tmp/qs;

# install OpenSSL 1.0.2l
RUN \
    set -ex; \
    \
    cd /tmp/qs/installs; \
    git pull; \
    ./openssl-1.0.2l_install.sh;

# packages needed by R-3.4.0
RUN aptitude -q -q -y install \
    wget \
    curl \
    tar \
    autoconf \
    make \
    coreutils \
    patch \
    gfortran \
    libreadline-dev \
    xorg-dev

# packages needed by R-3.4.0
RUN aptitude -q -q -y update

RUN aptitude -q -q -y install \
    texlive-latex-base \
    vim

RUN aptitude -q -q -y install \
    openjdk-7-jdk

# install R-3.4.0
RUN \
    set -ex; \
    \
    cd /tmp/qs/installs; \
    git pull; \
    ./r-3.4.0_install.sh;

# install R-3.4.0 packages
RUN \
    set -ex; \
    \
    cd /tmp/qs/installs; \
    git pull; \
    ./r-3.4.0-packages_install.sh;

# install RStudio Server 1.0.147
RUN \
    set -ex; \
    \
    cd /tmp/qs/installs; \
    git pull; \
    ./r-3.4.0-packages_install.sh;


# include hubcheck's patches to software packages
#
#COPY patches /tmp/patches


#####################################################
# setup ssh login

RUN apt-get -qqy update && apt-get -qqy install \
    openssh-client \
    openssh-server \
    xterm \
    vim

RUN mkdir /var/run/sshd

# create a guest user
RUN useradd --create-home --home-dir /home/guest --shell /bin/bash guest

# update user passwords
RUN echo 'guest:guest' | chpasswd

# open the container's port 22
EXPOSE 22
#####################################################




# start the sshd daemon
CMD ["/usr/sbin/sshd", "-D"]

