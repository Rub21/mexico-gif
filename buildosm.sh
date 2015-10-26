#!/bin/bash
#url="http://planet.osm.org/replication/day/000/001/"
#url="http://planet.osm.org/redaction-period/day-replicate/000/000/"
##per hour
url="http://planet.openstreetmap.org/replication/hour/000/027/" 
for i in $(seq $1 $2)
do	       
    if (($i<10)); then
       curl ${url}00$i.osc.gz -o "$i.osc.gz"
    fi
    if (($i<100)) && (($i>=10)); then
       curl ${url}0$i.osc.gz -o "$i.osc.gz"
    fi
    if (($i>=100)); then
       curl $url$i.osc.gz -o "$i.osc.gz"
    fi 
    echo "Processing file $i"
    gzip -d $i.osc.gz
    osmconvert $i.osc -B=boundary/$3 -o=$i.osm 
    #node index.js --osmfile=$i.osm
    echo rm $i.osm
    rm $i.osc.gz
    rm $i.osc
    echo "Process completed $i"
done

osmconvert *.osm -o=mexico.osm
zip mexico.zip mexico.osm
rm *.osm

