#!/bin/sh
set -e
. ./build.sh
 
mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub
 
cp sysroot/boot/pineappleOs.kernel isodir/boot/pineappleOs.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "PineappleOS" {
	multiboot /boot/pineappleOs.kernel
}
EOF
grub-mkrescue -o pineappleOs.iso isodir
