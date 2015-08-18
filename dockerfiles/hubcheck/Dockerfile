# debian 7 container with Rappture Toolkit
#

FROM debian:7
MAINTAINER derrick kearney <telldsk@gmail.com>


# install packages needed to build hubcheck
#
# package            needed to...
#
# python
# python-setuptools  install external packages, selenium and bmp bindings
# python-pip         install external packages, selenium and bmp bindings
# iceweasel          provides a web browser
# openjdk-7-jre      browsermob proxy is written in java
# x11vnc             needed to record xvfb sessions
# x264               needed to encode recording of xvfb sessions
# ffmpeg             needed to record xvfb sessions
# tcl                needed for tclunit
# libgmp-dev         math library for python-crypto
# libyaml-dev        yaml library for python-crypto or python-paramiko

RUN apt-get -qqy update && apt-get -qqy install \
    aptitude \
    apt-utils

RUN aptitude -q -q -y install \
    python \
    python-dev \
    python-setuptools \
    python-pip \
    iceweasel \
    openjdk-7-jre \
    x11vnc \
    x264 \
    xvfb \
    ffmpeg \
    tcl \
    libgmp-dev \
    libyaml-dev \
    \
    wget \
    tar \
    xterm \
    unzip \
    git

# install extra support packages, nice to have
#
# package            needed to...
#
# python-openssl
# python-pexpect     not needed right now, but may be used for bashshell.py
# python-xlib        not sure what uses this
# python-xlwt        needed for solarpv tool's excel spreadsheets
# cadaver            provides command line webdav client

#RUN apt-get -qqy install \
#    python-openssl \
#    python-pexpect \
#    python-xlib \
#    python-xlwt \
#    cadaver \


# include hubcheck's patches to software packages

COPY patches /tmp/patches


# install python webdav-lib package, which provides an interface to webdav

RUN \
    set -e; \
    set -x; \
    \
    export BUILDDIR=/tmp/webdavlib; \
    export PATCHDIR=/tmp/patches; \
    export WEBDAVLIBVER=0.4.2; \
    export PKGDIR=Python_WebDAV_Library-${WEBDAVLIBVER}; \
    export TARFNAME=${PKGDIR}.tar.gz; \
    mkdir -p ${BUILDDIR}; \
    cd ${BUILDDIR}; \
    wget https://launchpad.net/python-webdav-lib/trunk/${WEBDAVLIBVER}/+download/${TARFNAME}; \
    tar xvz -C . -f ${TARFNAME}; \
    cd ${PKGDIR}; \
    chmod -R o-w *; \
    patch -p1 < ${PATCHDIR}/python_webdav_lib.patch; \
    python setup.py build; \
    python setup.py install;


# install browsermob proxy, which provides a web proxy
# add browsermob-proxy to the PATH

RUN \
    set -e; \
    set -x; \
    \
    export BUILDDIR=/opt/browsermob-proxy; \
    export PATCHDIR=/tmp/patches; \
    export BMPVER=2.1.0-beta-1; \
    export PKGDIR=browsermob-proxy-${BMPVER}; \
    export TARFNAME=${PKGDIR}-bin.zip; \
    mkdir -p /opt; \
    cd /opt; \
    wget https://github.com/lightbody/browsermob-proxy/releases/download/${PKGDIR}/${TARFNAME}; \
    unzip ${TARFNAME}; \
    mv ${PKGDIR} ${BUILDDIR}; \
    chmod 755 ${BUILDDIR} ${BUILDDIR}/bin/browsermob-proxy; \
    chmod -R o-w ${BUILDDIR}/*; \
    echo "PATH=/opt/browsermob-proxy/bin:$PATH" >> /etc/environment; \
    echo ". /etc/environment" >> /etc/profile; \
    rm -f ${TARFNAME};


# install tclunit, a program to convert tclunit test results
# to junit style test results

RUN \
    set -e; \
    set -x; \
    \
    export BUILDDIR=/tmp/tclunit; \
    export PKGDIR=tclunit; \
    export INSTALLDIR=/opt/tclunit; \
    mkdir -p ${BUILDDIR}; \
    cd ${BUILDDIR}; \
    git clone git://github.com/makr/tclunit.git; \
    cd ${PKGDIR}; \
    chmod -R o-w *; \
    mkdir -p ${INSTALLDIR}; \
    install --mode 0644 -D tclunit/pkgIndex.tcl ${INSTALLDIR}; \
    install --mode 0644 -D tclunit/tclunit.tcl ${INSTALLDIR}; \
    install --mode 0755 -D tclunit_xml.tcl ${INSTALLDIR};



# install python packages through pip
#
# package            needed to...
#
# python-crypto      provides crypto algorithms for pyppp, paramiko
# python-paramiko    provides ssh interface, min version 1.15.1?
# python-requests    needed by browsermob_proxy python bindings
# python-pytest      needed for hctestrunner tool, min version 2.3.0, pref 2.6.4
#
# pyppp              provides semi-strong passwords using rijndael cypher
# easyprocess        can probably be replaced with subprocess
# pyvirtualdisplay   can probably be replaced with xvfbwrapper
# selenium           selenium bindings
# browsermob-proxy   browsermob-proxy bindings
#

RUN aptitude -q -q -y install \
    python-pip

RUN \
    set -e; \
    set -x; \
    \
    pip install crypto; \
    pip install paramiko; \
    pip install requests; \
    pip install pytest; \
    pip install EasyProcess; \
    pip install pyvirtualdisplay; \
    pip install selenium; \
    pip install browsermob-proxy;

RUN \
    set -e; \
    set -x; \
    \
    cd /tmp; \
    git clone git://github.com/kylef/pyppp.git; \
    cd pyppp; \
    python setup.py install; \
    cd /tmp; \
    rm -rf pyppp;


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


# copy over hub info
COPY testdata /tmp/testdata
RUN chmod -R 644 /tmp/testdata/*;


# copy hubcheck code into the container template
# build hubcheck
RUN \
    set -e; \
    set -x; \
    \
    git clone https://github.com/codedsk/hubcheck.git /tmp/hubcheck; \
    cd /tmp/hubcheck; \
    python setup.py install;



# start the sshd daemon
CMD ["/usr/sbin/sshd", "-D"]

