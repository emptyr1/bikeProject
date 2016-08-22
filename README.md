# BikeProject
----


Analyzing bikes in NY, DC, and SF using postgres+ postGIS, RedShift, python, R, cartodb and Tableau
Includes weather from cool climate and shape files. Supporting presentation can be found [here](https://docs.google.com/presentation/d/1wFfcXu5ya0qzA2rpQ7__vqnH_OgwNdGqUXoyuPJzeTQ/edit?usp=sharing)

To run the project, to `backend`-> `0_initialize_db.sh` that will create a local postgres db/tables and populate those tables with data downloaded from the respective websites. 

### Bonus visualization

![NY Citi Bikes](https://github.com/modqhx/bikeProject/blob/master/frontend/NY_Bike-Viz.gif) 

(This visualization is one day in November 2015 in NY. Each of those moving blue dot represent one `citi` bike going from one station to another. You can find the data sources and other notes here: https://github.com/modqhx/bikeProject/blob/master/data/notes.txt ) 
