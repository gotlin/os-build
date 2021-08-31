#!/bin/bash
DAILYBUILD_PATH=/srv/dailybuild/TowerOS-21.09

buildtime=$(date "+%Y-%m-%d-%H-%M-%S")
echo "[default]" >dailybuild.tmp
echo "buildtime=$buildtime" >>dailybuild.tmp

if [ ! -d $DAILYBUILD_PATH/"$buildtime" ]; then
    mkdir -p $DAILYBUILD_PATH/"$buildtime"
fi
	cp -f ./dailybuild.tmp $DAILYBUILD_PATH

