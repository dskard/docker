# ubuntu container
# allows user to ssh in
#
# see also:
# https://docs.docker.com/examples/running_ssh_service

FROM ubuntu:14.04
MAINTAINER derrick kearney <telldsk@gmail.com>

RUN apt-get -qqy update && apt-get -qqy install \
    openssh-client \
    openssh-server \
    xterm

RUN mkdir /var/run/sshd

# create a guest user
RUN useradd --create-home --home-dir /home/guest --shell /bin/bash guest

# update user passwords
RUN echo 'root:root' | chpasswd
RUN echo 'guest:guest' | chpasswd

# open the container's port 22
EXPOSE 22

# start the sshd daemon
CMD ["/usr/sbin/sshd", "-D"]
