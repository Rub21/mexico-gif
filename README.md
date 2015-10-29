### Install

`./install.sh`

### Get OSM Data

 - URL
https://s3.amazonaws.com/osm-changesets/

##### Build osm for whole world 

`./buildosm.sh 137 148`

##### Build osm file for a specific area

You can find all the poly in `boundary` folder

`./buildosm.sh 137 148 af.poly`

output: **osm.osm.bz2**

#####  Build osm file for specific and specifics users 

Add the  users in  on file `users` and execute

`./buildosm.sh 137 148 af.poly users`


The numbers mean came from http://planet.osm.org/replication/day/000/001/

- [137](http://planet.osm.org/replication/day/000/001/137.osc.gz) Date : 2015-10-29 00:06 
- [142](http://planet.osm.org/replication/day/000/001/142.osc.gz) Date : 2015-10-24 00:06 