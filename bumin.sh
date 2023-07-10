#!/bin/bash

export BUMIN=/mnt/bumin
export BUMIN_TGT=x86_64-bumin-linux-gnu
export BUMIN_DISK=/dev/sdc

if ! grep -q "$BUMIN" /proc/mounts; then
    . ./setupdisk.sh "$BUMIN_DISK"
    sudo mount "${BUMIN_DISK}2" "$BUMIN"
    sudo chown -v $USER "$BUMIN"
fi  

mkdir -pv $BUMIN/sources
mkdir -pv $BUMIN/tools

mkdir -pv $BUMIN/boot
mkdir -pv $BUMIN/etc
mkdir -pv $BUMIN/bin
mkdir -pv $BUMIN/lib
mkdir -pv $BUMIN/sbin
mkdir -pv $BUMIN/usr
mkdir -pv $BUMIN/var

case $(uname -m) in
    x86_64) mkdir -pv $BUMIN/lib64 ;;
esac


cp -rf *.sh packages.csv "$BUMIN/sources"
cd "$BUMIN/sources"
export PATH="$BUMIN/tools/bin:$PATH"

source download.sh

source pkginstall.sh binutils