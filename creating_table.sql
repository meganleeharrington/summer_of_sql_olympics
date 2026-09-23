select current_database();
use olympics;
CREATE TABLE staging (
	id varchar(1000),
    name varchar(1000),
	sex varchar(1000),
	age varchar(1000),
	height varchar(1000),
	weight varchar(1000),
	team varchar(1000),
	noc varchar(1000),
	games varchar(1000),
	year varchar(1000),
	season varchar(1000),
	city varchar(1000),
	sport varchar(1000),
	event varchar(1000),
	medal varchar(1000),
	noc_region varchar(1000),
	noc_notes varchar(1000)
);
select * from staging;