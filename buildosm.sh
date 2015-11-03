#!/bin/bash
url="https://s3.amazonaws.com/osm-changesets/day/000/001/"
#url="http://planet.osm.org/redaction-period/day-replicate/000/000/"
##per hour
#url="https://s3.amazonaws.com/osm-changesets/hour/000/027/"
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

    # if(($i == $1)); then
    #   osmconvert $i.osm --complete-ways -o=main.osm
    # else
    #   updateosm $i.osm main.osm
    # fi
    echo "Process completed $i"
done
# Merge file
osmconvert *osc.gz -o=temp.osm
rm $i.osc.gz

#boundary
if [ -n "$3" ]; then
  echo "==================== Clip for $3 ===================="
    osmconvert temp.osm -B=$3 --complete-ways -o=b-temp.osm
    mv b-temp.osm temp.osm
fi

#users
if [ -n "$4" ]; then
  echo "==================== Proces by users ===================="
  users=("$(cat u)")
  IFS="," read -ra STR_ARRAY <<< "$users"
  for j in "${STR_ARRAY[@]}"
    do
      osmfilter temp.osm --keep=@user=$j -o=$j-users.osm
  done
  osmconvert *-users.osm -o=osm.osm
  rm *-users.osm
else
  mv temp.osm osm.osm
fi

bzip2 osm.osm
rm u
rm temp.osm
rm temp