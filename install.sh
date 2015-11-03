#!/bin/bash
wget -O - http://m.m.i24.cc/osmfilter.c |cc -x c - -O3 -o osmfilter
sudo cp osmfilter /usr/bin/
wget -O - http://m.m.i24.cc/osmconvert.c | cc -x c - -lz -O3 -o osmconvert
sudo cp osmconvert /usr/bin/
