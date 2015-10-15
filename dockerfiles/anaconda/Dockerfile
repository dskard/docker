# debian 7 container with Anaconda, Firefox, ...
#

FROM debian:7.4
MAINTAINER derrick kearney <telldsk@gmail.com>


# update the system
RUN apt-get -qqy update && apt-get -qqy install \
    aptitude \
    apt-utils

# install base debian packages
#
# package            needed to...
#
# iceweasel          provides a web browser
# wget               retrieve files from the internet
# bzip2              uncompress files
# ca-certificates

RUN aptitude -q -q -y install \
    iceweasel \
    wget \
    bzip2 \
    ca-certificates


# install anaconda which provides python, jupyter

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda-2.3.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda-2.3.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda-2.3.0-Linux-x86_64.sh


# update and install python packages through conda
#
# package            needed to...
#
# conda
# anaconda
# ipython
# ipython-notebook
# jupyter
# mathjax
# r-essentials       provides the R kernel and useful R packages for jupyter

RUN /opt/conda/bin/conda update conda
RUN /opt/conda/bin/conda update anaconda
RUN /opt/conda/bin/conda update ipython ipython-notebook ipython-qtconsole
RUN /opt/conda/bin/conda install jupyter
RUN /opt/conda/bin/conda install mathjax
RUN /opt/conda/bin/conda install pymc
RUN /opt/conda/bin/conda install seaborn

RUN /opt/conda/bin/conda install -c http://conda.anaconda.org/r r-essentials

RUN /opt/conda/bin/pip install Gpy
RUN /opt/conda/bin/pip install common
RUN /opt/conda/bin/pip install plotly



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


# include conda in PATH
ENV PATH /opt/conda/bin:$PATH

## start the sshd daemon
#CMD ["/usr/sbin/sshd", "-D"]

USER guest
ENV HOME /home/guest
WORKDIR /home/guest

CMD ["/opt/conda/bin/jupyter","notebook"]

