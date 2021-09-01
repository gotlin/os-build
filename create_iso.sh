#!/bin/bash
set -e

TYPE='standard'
PRODUCT="TowerOS"
VERSION="21.09"
DAILYBUILD_PATH=/srv/dailybuild/TowerOS-21.09

if [ -z "$REPO_URL" ]; then
    REPO_URL="
http://119.3.219.20:82/openEuler:/21.03/standard_x86_64/
http://119.3.219.20:82/openEuler:/21.03:/Epol/standard_x86_64/
"
fi

REPO_URL=$(echo "$REPO_URL" | xargs echo)

dailybuild_flag=$DAILYBUILD_PATH/dailybuild.tmp

if [ -f $dailybuild_flag ]; then
    DATE=$(grep "buildtime" $dailybuild_flag | awk -F"=" '{print $2}')
    TARGET=${DAILYBUILD_PATH}/$DATE
else
    exit 1
fi

## make sure in docker container, loop0 can be used by lorax
for i in $(seq 0 9); do
    if mknod /dev/loop"$i" b 7 "$i"; then
        echo "mknod /dev/loop$i successful."
    else
        echo "mknod /dev/loop$i failed."
    fi
done

cmd="dnf -y install oemaker && dnf clean all"
echo "running: $cmd"
eval "$cmd"

cmd="bash oemaker -t ${TYPE} -p ${PRODUCT} -v ${VERSION} -r '' -s ${REPO_URL}"
echo "running: $cmd"
eval "$cmd"

cp /results/*.iso "$TARGET"/
