PWD := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
BUILD_FLAGS = --no-cache=true



# TEMPLATES

presentation_template:
	sudo docker build -t="$@" dockerfiles/presentation_template

anaconda_template:
	sudo docker build -t="$@" ../github/anaconda-notebook

notebook_template:
	sudo docker build -t="$@" dockerfiles/anaconda

sshd_template:
	sudo docker build -t="$@" dockerfiles/sshd

firefox_template:
	sudo docker build -t="$@" dockerfiles/firefox

rappture_template:
	sudo docker build -t="$@" dockerfiles/rappture

rappture-r9_template:
	sudo docker build ${BUILD_FLAGS} -t="$@" dockerfiles/rappture-r9

hubcheck_template:
	sudo docker build -t="$@" dockerfiles/hubcheck

hubcheck-dev_template:
	sudo docker build -t="$@" dockerfiles/hubcheck-dev

rust_template:
	sudo docker build -t="$@" dockerfiles/rust

shiny_template:
	sudo docker build -t="$@" dockerfiles/shiny



# CONTAINERS

presentation1:
	sudo docker run -d \
	  -p 8000:8000 \
	  -v ${PWD}examples/presentation1/index.html:/opt/presentation/index.html \
	  -v ${PWD}examples/presentation1/images:/opt/presentation/images \
	  -v ${PWD}examples/presentation1/slides:/opt/presentation/slides \
	  --name $@ \
	  presentation_template

anaconda:
	sudo docker run -i -t -d \
	  -p 8888:8888 \
	  -v ${PWD}../github/anaconda_notebook/src/notebooks:/home/condauser/notebooks \
	  --name $@
	  anaconda-notebook \
	  /home/condauser/anaconda3/bin/ipython notebook

notebook:
	sudo docker stop $@ || true
	sudo docker rm $@ || true
	ssh-keygen -f "${HOME}/.ssh/known_hosts" -R [localhost]:4026
	sudo docker run -i -t -d \
	  -p 4026:22 \
	  -e DISPLAY=${DISPLAY} \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  -v ${PWD}/data/notebooks:/home/guest/notebooks \
	  --name $@ \
	  $@_template \
	  sh -c "/opt/conda/bin/jupyter notebook --ip=*"

sshd:
	sudo docker stop $@ || true
	sudo docker rm $@ || true
	sudo docker run -i -t -d \
	  -p 4022:22 \
	  --name $@ \
	  $@_template

firefox:
	sudo docker run -i -t --rm \
	  -e DISPLAY=${DISPLAY} \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  $@_template

rappture:
	sudo docker stop $@ || true
	sudo docker rm $@ || true
	sudo docker run -i -t -d \
	  -e DISPLAY=${DISPLAY} \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  -v ${PWD}/data/rappture:/home/guest \
	  --name $@ \
	  $@_template \
	  -tool tool.xml

rappture-r9:
	sudo docker stop $@ || true
	sudo docker rm $@ || true
	sudo docker run -i -t -d \
	  -e DISPLAY=${DISPLAY} \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  -v ${PWD}/data/rappture:/home/guest \
	  --name $@ \
	  $@_template \
	  -tool tool.xml

hubcheck:
	sudo docker stop $@ || true
	sudo docker rm $@ || true
	ssh-keygen -f "${HOME}/.ssh/known_hosts" -R [localhost]:4024
	sudo docker run -i -t -d \
	  -p 4024:22 \
	  --name $@ \
	  $@_template

hubcheck-dev:
	sudo docker stop $@ || true
	sudo docker rm $@ || true
	ssh-keygen -f "${HOME}/.ssh/known_hosts" -R [localhost]:4027
	sudo docker run -i -t -d \
	  -v ${PWD}data/hubcheck:/home/guest/hubcheck \
	  -v ${PWD}data/hubcheck-hubzero-locators:/home/guest/hubcheck-hubzero-locators \
	  -v ${PWD}data/hubcheck-hubzero-tests:/home/guest/hubcheck-hubzero-tests \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  -p 4027:22 \
	  --name $@ \
	  $@_template

rust:
	sudo docker stop $@ || true
	sudo docker rm $@ || true
	ssh-keygen -f "${HOME}/.ssh/known_hosts" -R [localhost]:4023
	sudo docker run -i -t -d \
	  -v ${PWD}/data/rust:/home/guest/rust \
	  -p 4023:22 \
	  --name $@ \
	  $@_template

shiny:
	sudo docker stop $@ || true
	sudo docker rm $@ || true
	ssh-keygen -f "${HOME}/.ssh/known_hosts" -R [localhost]:4025
	sudo docker run -i -t -d \
	  -v ${PWD}/data/shiny:/home/guest/shiny \
	  -p 4025:22 \
	  --name $@ \
	  $@_template

