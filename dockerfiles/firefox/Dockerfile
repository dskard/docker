# ubuntu container with firefox to test running a gui app in container
#
# see also:
# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

FROM ubuntu:14.04
MAINTAINER derrick kearney <telldsk@gmail.com>

RUN apt-get -qqy update && apt-get -qqy install \
    firefox

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/guest && \
    echo "guest:x:${uid}:${gid}:Developer,,,:/home/guest:/bin/bash" >> /etc/passwd && \
    echo "guest:x:${uid}:" >> /etc/group && \
    echo "guest ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/guest && \
    chmod 0440 /etc/sudoers.d/guest && \
    chown ${uid}:${gid} -R /home/guest

USER guest
ENV HOME /home/guest

# start up the firefox browser
CMD ["/usr/bin/firefox", "--new-instance"]
