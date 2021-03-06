#!/bin/sh
# Debian Package Builder, by Tomas Pollak

if [ `whoami` != 'root' ]; then
	echo 'Since we need to set up root permissions you need to run this as root. A simple "sudo" will do. :)'
	exit
fi

cwd=`pwd`

while [ ! -f prey.sh ]; do
	cd ..
done

basedir=`pwd`
cd $cwd

# Remove temporary directory and .DEBs
rm -rf ./build
rm *.deb 2> /dev/null

# Configure control folder and file
mkdir -p ./build/tmp/prey
cp -r DEBIAN ./build/tmp/prey/

# copying the base dir stuff
mkdir -p ./build/tmp/prey/usr/share/prey
cp $basedir/prey.sh ./build/tmp/prey/usr/share/prey/
cp $basedir/config ./build/tmp/prey/usr/share/prey/
cp $basedir/configure.py ./build/tmp/prey/usr/share/prey/
cp -r $basedir/lib ./build/tmp/prey/usr/share/prey/
cp -r $basedir/lang ./build/tmp/prey/usr/share/prey/
cp -r $basedir/platform ./build/tmp/prey/usr/share/prey/
cp -r $basedir/modules ./build/tmp/prey/usr/share/prey/
cp -r $basedir/pixmaps ./build/tmp/prey/usr/share/prey/

cp $basedir/CHANGELOG ./build/tmp/prey/usr/share/prey/
cp $basedir/LICENSE ./build/tmp/prey/usr/share/prey/
cp $basedir/README ./build/tmp/prey/usr/share/prey/

# lets copy the config shortcut
mkdir -p ./build/tmp/prey/usr/share/applications
cp prey-config.desktop ./build/tmp/prey/usr/share/applications

sudo chown root.root ./build/tmp/prey/usr/share/prey -R

# Make the deb package
dpkg-deb -b ./build/tmp/prey ./build

mv build/*.deb .
# Remove temporary directory
sudo rm -rf ./build

