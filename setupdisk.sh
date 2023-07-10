#!/bin/bash

BUMIN_DISK="$1"

sudo fdisk "$BUMIN_DISK" << EOF
o
n
p
1

+200M
a
n
p
2


p
w
q
EOF

sudo mkfs -t ext4 -F "${BUMIN_DISK}1"
sudo mkfs -t ext4 -F "${BUMIN_DISK}2"