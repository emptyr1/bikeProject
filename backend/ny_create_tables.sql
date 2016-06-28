
 -- CREATE schema ny_schema;
 -- set search_path to 'ny_schema';

CREATE TABLE ny_raw_trips ( 
	  trip_duration numeric,
	  start_time timestamp without time zone,
	  stop_time timestamp without time zone,
	  start_station_id integer,
	  start_station_name text,
	  start_station_latitude numeric,
	  start_station_longitude numeric,
	  end_station_id integer,
	  end_station_name text,
	  end_station_latitude numeric,
	  end_station_longitude numeric,
	  bike_id integer,
	  user_type text,
	  birth_year text,
	  gender text
);

CREATE TABLE ny_stations (
	id integer primary key,
	name text,
	
	latitude numeric,
	longitude numeric,
	nyct2010_gid integer,
	boroname text,
	ntacode text,
	ntaname text


);

CREATE TABLE ny_each_trip (
	id serial primary key,
	trip_duration numeric,
	start_time timestamp without time zone,
	stop_time timestamp without time zone,
	start_station_id integer,
	end_station_id integer,
	bike_id integer,
	user_type text,
	birth_year integer,
	gender integer
);


SELECT AddGeometryColumn('ny_stations', 'geom', 4326, 'POINT', 2);
CREATE INDEX idx_stations_on_geom ON ny_stations USING gist (geom);

CREATE VIEW trips_and_stations AS (
	SELECT 
	t.*,
	ss.name AS start_station_name,
	ss.latitude AS start_station_latitude,
	ss.longitude AS start_station_longitude,
	ss.nyct2010_gid AS start_nyct2010_gid,
	ss.boroname AS start_boroname,
	ss.ntacode AS start_ntacode,
	ss.ntaname AS start_ntaname,

	es.name AS end_station_name,
	es.latitude AS end_station_latitude,
	es.longitude AS end_station_longitude,
	es.nyct2010_gid AS end_nyct2010_gid,
	es.boroname AS end_boroname,
	es.ntacode AS end_ntacode,
	es.ntaname AS end_ntaname


	FROM ny_each_trip t inner join ny_stations ss on t.start_station_id = ss.id 
	inner join ny_stations es on t.end_station_id = es.id
);

CREATE TABLE ny_directions (
  start_station_id integer,
  end_station_id integer,
  directions jsonb
);

CREATE UNIQUE INDEX idx_directions_on_stations ON ny_directions (start_station_id, end_station_id);


------------------------------------------------------

CREATE TABLE raw_carbon_footprint(


);
------------------------------------------------------


