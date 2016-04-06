#!/bin/bash
wget -O - http://m.m.i24.cc/osmfilter.c |cc -x c - -O3 -o osmfilter
sudo cp osmfilter /usr/bin/
wget -O - http://m.m.i24.cc/osmconvert.c | cc -x c - -lz -O3 -o osmconvert
sudo cp osmconvert /usr/bin/


sudo apt-get install cmake cmake-curses-gui make libexpat1-dev zlib1g-dev libbz2-dev
sudo apt-get install libsparsehash-dev libboost-dev libboost-program-options-dev libgdal-dev libgeos++-dev libproj-dev doxygen graphviz
git clone https://github.com/osmcode/libosmium.git
cd libosmium/
mkdir build
cd build
cmake ..
make
cd /

git clone https://github.com/mapbox/minjur.git
cd minjur/
mkdir build
cd build
cmake ..
make


git clone https://github.com/osmcode/osmium-tool.git
cd osmium-tool/
mkdir build
cd build
cmake ..
make

