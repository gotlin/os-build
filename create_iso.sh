#!/bin/bash
set -xe

TYPE='standard'
PRODUCT="TowerOS"
VERSION="21.09"
DAILYBUILD_PATH=/srv/dailybuild/TowerOS-21.09

if [ -z "$REPO_URL" ]; then
    REPO_URL="-s http://119.3.219.20:82/openEuler:/21.03/standard_x86_64/ -s http://119.3.219.20:82/openEuler:/21.03:/Epol/standard_x86_64/"
fi

dailybuild_flag=$DAILYBUILD_PATH/dailybuild.tmp

if [ -f $dailybuild_flag ]; then
    DATE=$(grep "buildtime" $dailybuild_flag | awk -F"=" '{print $2}')
    TARGET=${DAILYBUILD_PATH}/$DATE
else
    exit 1
fi

## make sure in docker container, loop0 can be used by lorax
seq 0 9 | xargs -I {} mknod /dev/loop{} b 7 {}

dnf -y install oemaker && dnf clean all
bash oemaker -t ${TYPE} -p ${PRODUCT} -v ${VERSION} -r "" "${REPO_URL}"

cp /results/*.iso "$TARGET"/
