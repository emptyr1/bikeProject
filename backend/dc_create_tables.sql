CREATE TABLE dc_raw_trips (
	trip_duration numeric,
	start_date timestamp without time zone,
	end_date timestamp without time zone,
	start_station_num numeric,
	start_station_name text,
	end_station_num numeric,
	end_station_name text,
	bike_id text,
	memeber_type text

);

CREATE TABLE dc_stations (
	id integer primary key,
	name text,
	nyct2010_gid integer,
	boroname text,
	ntacode text,
	ntaname text


);

