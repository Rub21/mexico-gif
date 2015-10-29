#!/bin/bash
#url="https://s3.amazonaws.com/osm-changesets/day/000/001/"
#url="http://planet.osm.org/redaction-period/day-replicate/000/000/"
##per hour
url="https://s3.amazonaws.com/osm-changesets/hour/000/027/"
sed 's/@//g' $4 > temp
sed 's/,/,/g' temp > u
for i in $(seq $1 $2)
do	
    echo ${url}$i.osc.gz       
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
    #boundary
    if [ -n "$3" ]; then
      osmconvert $i.osc.gz -B=boundary/$3 --complete-ways -o=$i.osm 
    else
      osmconvert $i.osc.gz --complete-ways -o=$i.osm 
    fi
    #users
    if [ -n "$4" ]; then
      users=("$(cat u)")
      IFS="," read -ra STR_ARRAY <<< "$users"
      for j in "${STR_ARRAY[@]}"
      do
          osmfilter $i.osm --keep=\"@user=$j\" -o=$i-$j.osm
      done
      rm $i.osm
      osmconvert $i-*.osm -o=$i.osm
      rm $i-*.osm
    fi
    rm $i.osc.gz

    if(($i == $1)); then
      osmconvert $i.osm --complete-ways -o=main.osm
    else
      updateosm $i.osm main.osm
    fi
    echo "Process completed $i"
done
# osmconvert *.osm -o=osm.osm
# bzip2 osm.osm
# rm *.osm
# rm u
