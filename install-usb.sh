#!/bin/sh
set -e
. ./iso.sh

sudo su -c "cat pineappleOs.iso > /dev/sda"