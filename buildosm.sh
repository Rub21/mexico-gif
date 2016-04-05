#!/bin/bash
wget http://planet.openstreetmap.org/planet/2015/planet-150928.osm.bz2
osmconvert planet-150928.osm.bz2 -B=boundary/mexico.poly -o=mexico.osm