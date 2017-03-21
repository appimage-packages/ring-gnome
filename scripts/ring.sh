#!/bin/bash
set -e
set -x
export LD_LIBRARY_PATH=/opt/usr/lib:/opt/usr/library:/opt/usr/lib/x86_64-linux-gnu:/usr/lib:/usr/lib64
export PKG_CONFIG="pkg-config --static"
export CPATH=/opt/usr/include:/opt/usr/include/gtk-3.0:/opt/usr/include/corvusoft:/opt/usr/include/boost/system:/opt/usr/include/boost:/usr/include
export LDFLAGS="-L/opt/usr/library -L/opt/usr/lib $LDFLAGS"

pkg-config --exists gtk+-3.0
echo $?

pkg-config --libs "gtk+-3.0 >= 3.10"
cd contrib

rm -rfv build
mkdir build
cd build
if ../bootstrap --prefix=/opt/usr --disable-restbed --disable-boost; then

make

# That's all !
else
	error_exit "$LINENO: An error has occurred.. Aborting."
fi


cd ../../
if ./autogen.sh; then
./configure --prefix=/opt/usr
make
make install

else
	error_exit "$LINENO: An error has occurred.. Aborting."
fi
cd ../../
LIBRINGLIENT=`pwd`/ring-lrc
RING=/app/src/ring
git clone https://gerrit-ring.savoirfairelinux.com/ring-lrc
cd $LIBRINGLIENT
mkdir build
cd build
if cmake .. -DCMAKE_INSTALL_PREFIX=/opt/usr; then
make -j8
make install
else
	error_exit "$LINENO: An error has occurred.. Aborting."
fi

git clone https://gerrit-ring.savoirfairelinux.com/ring-client-gnome
cd ring-client-gnome
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/opt/usr
make
sudo make install

function error_exit
{
	echo "$1" 1>&2
	exit 1
}
