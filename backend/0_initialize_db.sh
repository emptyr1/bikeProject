#!/bin/bash

#Assuming you are in the main 'bike_project' folder 

source credens_pg.sh

# NEW YORK #########################################

#create tables and search_path to 'ny_schema'
psql --host=$myhost -d $mydb --username=$myusername --password -f backend/ny_create_db.sql

#convert shp file to table named 'nyct2010'
shp2pgsql -s 2263:4326 -I data/shp_files/nyct2010_16a/nyct2010.shp ny_nyct2010 | psql --host=$myhost -d $mydb -U $myusername -W


psql --host=$myhost -d $mydb --username=$myusername --password -c "CREATE INDEX index_nyct_on_geom ON ny_nyct2010 USING gist (geom);"
psql --host=$myhost -d $mydb --username=$myusername --password -c "VACUUM ANALYZE ny_nyct2010;"

#clean up '\N' chars and copy into tables
for filename in data/NY/20*.csv;do
	echo "beginning loading for: ${filename}"
	sed $'s/\\\N//' "${filename}" | psql --host=$myhost -d $mydb --username=$myusername --password -c "COPY ny_raw_trips from STDIN CSV HEADER;"

	psql --host=$myhost -d $mydb --username=$myusername --password -f ny_populate_trips_from_raw.sql
	echo "populating tables from filename "
done;

psql --host=$myhost -d $mydb --username=$myusername --password -f create_indexes.sql



# SAN FRANCISCO #########################################

psql --host=$myhost -d $mydb --username=$myusername --password -f backend/sf_create_db.sql




# WASHINGTON DC #########################################



# WEATHER/CARBON FOOTPRINT DATA #########################

cat data/central_park_weather.csv | psql nyc-citibike-data -c "COPY central_park_weather_observations_raw FROM stdin WITH CSV HEADER;"
