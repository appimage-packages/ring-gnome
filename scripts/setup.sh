#!/bin/bash
#
# Copyright (C) 2016 Scarlett Clark <sgclark@kde.org>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) version 3, or any
# later version accepted by the membership of KDE e.V. (or its
# successor approved by the membership of KDE e.V.), which shall
# act as a proxy defined in Section 6 of version 3 of the license.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License fo-r more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.  If not, see <http://www.gnu.org/licenses/>.
export PATH=/opt/usr/bin:/home/jenkins/.rbenv/bin:/home/jenkins/.rbenv/shims:$PATH
export WORKSPACE=`pwd`
export CFLAGS=-fPIC
echo $WORKSPACE
add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && apt-get -y install gcc-4.9 g++-4.9
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
add-apt-repository -y ppa:jonathonf/gtk3.16
apt-get update
apt-get build-dep gtk-3-dev
cd /in/ && rspec appimage-template/spec/recipe_rspec.rb --fail-fast
