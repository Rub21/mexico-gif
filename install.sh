#!/bin/bash
npm install
#psql -U postgres -c "DROP database dbosm"
psql -U postgres -c "create database dbosm";
psql -U postgres -d dbosm -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
psql -U postgres -d dbosm -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
sudo apt-get install cmake cmake-curses-gui make libexpat1-dev zlib1g-dev libbz2-dev
sudo apt-get install libsparsehash-dev libboost-dev libboost-program-options-dev libgdal-dev libgeos++-dev libproj-dev doxygen graphviz
sudo add-apt-repository ppa:ubuntugis/ppa
sudo apt-get update
sudo apt-get install gdal-bin
sudo apt-get install zip

git clone https://github.com/osmcode/libosmium.git
cd libosmium
mkdir build
cd build
cmake ..
make

wget -O - http://m.m.i24.cc/osmfilter.c |cc -x c - -O3 -o osmfilter
sudo cp osmfilter /usr/bin/
wget -O - http://m.m.i24.cc/osmconvert.c | cc -x c - -lz -O3 -o osmconvert
sudo cp osmconvert /usr/bin/
