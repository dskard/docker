# debian container with rust programming language installed

FROM debian:7
MAINTAINER derrick kearney <telldsk@gmail.com>

RUN apt-get -qqy update && apt-get -qqy install \
    openssh-client \
    openssh-server \
    xterm \
    vim

RUN mkdir /var/run/sshd

# create a guest user
RUN useradd --create-home --home-dir /home/guest --shell /bin/bash guest

# update user passwords
RUN echo 'root:root' | chpasswd
RUN echo 'guest:guest' | chpasswd

# open the container's port 22
EXPOSE 22

# install prereq packages
RUN apt-get -qqy install \
    python \
    make \
    git \
    g++ \
    curl \
    valgrind

# download and build rust
#RUN \
#    set -e; \
#    set -x; \
#    \
#    mkdir /opt/rust; \
#    mkdir /tmp/rust; \
#    cd /tmp/rust; \
#    git clone git://github.com/mozilla/rust.git; \
#    cd rust; \
#    ./configure --enable-rpath --prefix=/opt/rust; \
#    make; \
#    make check; \
#    make install;

RUN \
    set -e; \
    set -x; \
    \
    mkdir -p /tmp/rust; \
    cd /tmp/rust; \
    curl -f -L https://static.rust-lang.org/rustup.sh -O; \
    export SHELL=/bin/sh; \
    sh rustup.sh --disable-sudo --yes;

RUN \
    curl -f -L https://raw.githubusercontent.com/rust-lang/rust.vim/master/syntax/rust.vim -O; \
    VIMSYNDIR=`find /usr/share/vim/ -iname "*syntax"`; \
    mv rust.vim ${VIMSYNDIR}/rust.vim;

COPY vimrc /home/guest/.vimrc

# start the sshd daemon
CMD ["/usr/sbin/sshd", "-D"]

