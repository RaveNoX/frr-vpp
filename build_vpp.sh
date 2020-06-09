#!/bin/bash

set -e  # exit on the first command failure

apt-get install -y python-cffi python-pycparser devscripts debhelper dpkg-dev dkms

rm -r ./build || true
git clone -b v20.05 https://github.com/RaveNoX/vppsb.git ./build/vppsb
git clone -b v20.05 https://github.com/FDio/vpp.git ./build/vpp

ln -sf ../../../vppsb/netlink ./build/vpp/src/plugins/netlink
ln -sf ../../../vppsb/router ./build/vpp/src/plugins/router

#cp startup.conf vpp/src/vpp/conf/
#cp init.txt vpp/src/vpp/conf/

#sed -i '$ a install(FILES conf/init.txt DESTINATION etc/vpp COMPONENT vpp)' vpp/src/vpp/CMakeLists.txt

cd ./build/vpp

make install-ext-deps
make install-dep
make build-release
make pkg-deb

cd -
