#! /bin/sh

# create a temp, hopefully unique, profile name
profilename=`mktemp -u XXXXXXXXXXX`
profiledir=/tmp/${profilename}

# create the firefox profile
firefox --no-remote -CreateProfile "${profilename} ${profiledir}"


# copy the browser preferences to the profile
cp user.js ${profiledir}/.
mkdir -p ${profiledir}/chrome
cp userChrome.css ${profiledir}/chrome


# launch the browser
firefox -no-remote -P "${profilename}" $1

# remove the profile
rm -rf ${profiledir}

