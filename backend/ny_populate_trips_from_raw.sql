

INSERT into ny_stations (id, name, latitude, longitude)
SELECT DISTINCT ON (start_station_id) start_station_id, start_station_name, start_station_latitude, start_station_longitude
FROM ny_raw_trips
WHERE start_station_id NOT IN (SELECT id FROM ny_stations)
ORDER BY start_station_id;


INSERT into ny_stations (id, name, latitude, longitude)
SELECT DISTINCT ON (end_station_id) end_station_id, end_station_name, end_station_latitude, end_station_longitude
FROM ny_raw_trips
WHERE end_station_id NOT IN ( SELECT id FROM ny_stations)
ORDER BY end_station_id;



UPDATE ny_stations
SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)
WHERE geom IS NULL;


UPDATE ny_stations
SET nyct2010_gid = x.gid,
	boroname = x.boroname,
	ntacode = x.ntacode,
	ntaname = x.ntaname
FROM ny_nyct2010 x
WHERE ny_stations.nyct2010_gid is NULL and st_within(ny_stations.geom, x.geom);

-- INSERT into nTRIP

INSERT INTO ny_each_trip (trip_duration, start_time, stop_time, start_station_id, end_station_id, 
				bike_id, user_type, birth_year, gender)
SELECT trip_duration, start_time, stop_time, start_station_id, end_station_id, bike_id, user_type, 
			NULLIF(birth_year, '')::int, NULLIF(gender, '')::int
			FROM ny_raw_trips;


-------- CREATING INDEXES

CREATE INDEX idx_trips_on_start_station ON ny_each_trip (start_station_id);
CREATE INDEX idx_trips_on_end_station ON ny_each_trip (end_station_id);
CREATE INDEX idx_trips_on_dow ON ny_each_trip (EXTRACT(DOW FROM start_time));
CREATE INDEX idx_trips_on_hour ON ny_each_trip (EXTRACT(HOUR FROM start_time));
CREATE INDEX idx_trips_on_date ON ny_each_trip (date(start_time));

---------



