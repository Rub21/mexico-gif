#!/bin/bash
url="https://s3.amazonaws.com/osm-changesets/day/000/001/"
#url="http://planet.osm.org/redaction-period/day-replicate/000/000/"
##per hour
#url="https://s3.amazonaws.com/osm-changesets/hour/000/027/" 
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
    osmconvert $i.osc.gz -B=boundary/$3 --complete-ways -o=$i.osm 
    echo rm $i.osm
    rm $i.osc.gz
    echo "Process completed $i"
done
osmconvert *.osm -o=osm.osm
bzip2 osm.osm
rm *.osm