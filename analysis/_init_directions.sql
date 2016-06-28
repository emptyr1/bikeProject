CREATE TABLE station_to_station_counts AS
SELECT start_station_id, end_station_id, COUNT(*) AS count
FROM ny_each_trip
WHERE date(start_time) >= '2015-09-01'
GROUP BY start_station_id, end_station_id;

CREATE index idx_station_to_station ON station_to_station_counts (start_station_id, end_station_id);

CREATE TABLE directions_legs (
  id integer primary key,
  station_direction_id integer,
  start_station_id integer,
  end_station_id integer,
  number integer,
  start_latitude numeric(9, 6),
  start_longitude numeric(9, 6),
  end_latitude numeric(9, 6),
  end_longitude numeric(9, 6),
  duration numeric(9, 6)
);

## loook at the python file to create the legs file
COPY directions_legs FROM 'data/individual_legs.csv' CSV HEADER;

CREATE UNIQUE INDEX idx_directions_legs ON directions_legs (start_station_id, end_station_id, number);