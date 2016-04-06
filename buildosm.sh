#!/bin/bash
wget http://planet.openstreetmap.org/planet/2015/planet-150928.osm.bz2
bzip2 -d planet-150928.osm.bz2 

osmconvert planet-150928.osm -B=boundary/mexico.poly -o=mexico.osm


wget http://download.geofabrik.de/north-america/mexico-latest.osm.bz2
bzip2 -d mexico-latest.osm.bz2 

./osmfilter mexico-latest.osm --keep=  --keep-relations="boundary=administrative and admin_level=6" -o=mexico-bounduary.osm
osmfilter mexico-bounduary.osm --keep=@user=mexico_boundaries_import -o=mexico_boundaries_import.osm

osmconvert mexico_boundaries_import.osm -o=mexico_boundaries_import.osm.pbf
osmium cat --object-type=relation --output=mexico_boundaries_import.osm.opl mexico_boundaries_import.osm.pbf


osmium getid --add-referenced --id-file=mexico_boundaries_import.osm.opl --output=boundaries_import.osm.pbf mexico_boundaries_import.osm.pbf
minjur boundaries_import.osm.pbf > boundaries_import.geojson

