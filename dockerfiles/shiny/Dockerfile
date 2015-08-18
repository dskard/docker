# debian 7 container for R Shiny
#

FROM debian:7
MAINTAINER derrick kearney <telldsk@gmail.com>


RUN apt-get -qqy update && apt-get -qqy install \
    aptitude \
    apt-utils


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
RUN echo 'root:root' | chpasswd
RUN echo 'guest:guest' | chpasswd

# open the container's port 22
EXPOSE 22
#####################################################



# install packages needed to build shiny
#
# package            needed to...
#
# r-base             install R
# wget               grab packages from the internet
# libjpeg62          install Rstudio
# firefox            visualize Shiny applications

RUN set -x; \
    set -e; \
    apt-key adv --keyserver keyserver.ubuntu.net --recv-key 381BA480; \
    echo "deb http://cran.r-project.org/bin/linux/debian wheezy-cran3/" > /etc/apt/sources.list.d/cran.list; \
    aptitude -q -q -y update && aptitude -q -q -y install \
        r-base \
        wget \
        libjpeg62 \
        iceweasel


# install R's shiny module

RUN set -x; \
    set -e; \
    mkdir -p /tmp/rstudio; \
    cd /tmp/rstudio; \
    wget http://download1.rstudio.org/rstudio-0.98.1062-amd64.deb; \
    dpkg -i *.deb; \
    rm *.deb; \
    R -e "install.packages('shiny', repos='http://cran.rstudio.com/')";


# install some custom profile stuff for firefox
# removes navigation bar
# hide tabs

COPY launch_ff.sh /home/guest/launch_ff.sh
COPY user.js /home/guest/user.js
COPY userChrome.css /home/guest/userChrome.css

RUN \
    chmod 755 /home/guest/launch_ff.sh; \
    chown guest:guest /home/guest/launch_ff.sh; \
    chmod 644 /home/guest/user.js; \
    chmod 644 /home/guest/userChrome.css;


# start the sshd daemon
CMD ["/usr/sbin/sshd", "-D"]

