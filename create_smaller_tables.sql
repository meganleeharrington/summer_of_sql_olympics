--atheletes table
DROP TABLE athletes;
CREATE TABLE athletes (
    athlete_id INT PRIMARY KEY,
    name VARCHAR(255),
    sex CHAR(1),
    height varchar(255),
    weight varchar(255)
);

INSERT INTO athletes (athlete_id, name, sex, height, weight) 
SELECT DISTINCT id
    ,name
    ,sex
    ,height
    ,weight
from staging;

select *
from athletes;



--events table
CREATE TABLE events (
    event_id INT PRIMARY KEY,
    event VARCHAR(255),
    sport VARCHAR(255)
);

INSERT INTO events (event_id, event, sport) 
SELECT ROW_NUMBER() OVER (ORDER BY event) AS event_id
    ,event
    ,sport
FROM 
    (SELECT DISTINCT event
        ,sport 
    FROM staging) AS unique_events;

select *
from events;



--teams table
CREATE TABLE teams(
    team_id INT PRIMARY KEY,
    team VARCHAR(255),
    NOC VARCHAR(255),
    NOC_region VARCHAR(255),
    NOC_notes VARCHAR(1000)
);

INSERT INTO teams (team_id, team, NOC, NOC_region, NOC_notes)
SELECT ROW_NUMBER() OVER (ORDER BY team) AS team_id
    ,team
    ,NOC
    ,NOC_region
    ,NOC_notes
FROM 
    (SELECT DISTINCT team
        ,NOC
        ,NOC_region
        ,NOC_notes 
    FROM staging) AS unique_teams;

SELECT *
from teams;



--games table
CREATE TABLE games (
    games_id INT PRIMARY KEY,
    year INT,
    games VARCHAR(255),
    season VARCHAR(255),
    city VARCHAR(255)
);

INSERT INTO games (games_id, year, games, season, city)
SELECT ROW_NUMBER() OVER (ORDER BY year, games) AS games_id
    ,year
    ,games
    ,season
    ,city
FROM 
    (SELECT DISTINCT year
        ,games
        ,season
        ,city 
    FROM staging) AS unique_games;

SELECT *
from games;



--results table
DROP TABLE results;

CREATE TABLE results (
    athlete_id INT,
    athlete_age VARCHAR(255),
    team_id INT,
    games_id INT,
    event_id INT,
    medal VARCHAR(255)
);

INSERT INTO results (athlete_id, athlete_age, team_id, games_id, event_id, medal)
select s.id as athlete_id
    ,s.age as athlete_age
    ,t.team_id 
    ,g.games_id
    ,e.event_id
    ,s.medal
from staging as s
left join teams as t on s.team = t.team and s.NOC = t.NOC
left join games as g on s.games = g.games and s.city = g.city
left join events as e on s.event = e.event
;

SELECT *
from results;



-- Add Foreign Keys
ALTER TABLE results ADD FOREIGN KEY (athlete_id) REFERENCES athletes(athlete_id);
ALTER TABLE results ADD FOREIGN KEY (team_id) REFERENCES teams(team_id);
ALTER TABLE results ADD FOREIGN KEY (games_id) REFERENCES games(games_id);
ALTER TABLE results ADD FOREIGN KEY (event_id) REFERENCES events(event_id);
