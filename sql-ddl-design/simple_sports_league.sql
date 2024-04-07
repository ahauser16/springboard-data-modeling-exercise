-- STEPS TO RUN FROM THE TERMINAL:
----STEP ONE--start the PostgreSQL service using the command 'sudo service postgresql start'
----STEP TWO--cd into the directory with the sql file you want to run and run the command 'psql -U username -f medical_center.sql'.
--STEP THREE-- you can now connect to the psql interface and medical_center database by running the command 'psql -U username -d medical_center' and then you can list all tables to verify that they were created by running the command '\dt'.

DROP DATABASE IF EXISTS simple_sports_league;

CREATE DATABASE simple_sports_league;

\c simple_sports_league;

--DDL for creating tables:

--to store information about different teams.
CREATE TABLE Teams (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE, -- No two teams can have the same name
  location TEXT,
  founded INT CHECK (founded > 0), -- The year founded must be a positive integer
  stadium TEXT,
  coach TEXT,
  league_id INT REFERENCES Leagues(id),
  wins INT DEFAULT 0 CHECK (wins >= 0), -- The number of wins must be non-negative
  losses INT DEFAULT 0 CHECK (losses >= 0), -- The number of losses must be non-negative
  draws INT DEFAULT 0 CHECK (draws >= 0) -- The number of draws must be non-negative
);

--to store information about players, including their team.
CREATE TABLE players (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  team_id INT REFERENCES Teams(id),
  position TEXT,
  date_of_birth DATE,
  nationality TEXT,
  goals_scored INT DEFAULT 0 CHECK (goals_scored >= 0), -- The number of goals scored must be non-negative
  height DECIMAL(3, 2) CHECK (height >= 0), -- The height must be non-negative
  weight DECIMAL(4, 1) CHECK (weight >= 0), -- The weight must be non-negative
  is_active BOOLEAN DEFAULT TRUE,
  UNIQUE (team_id, number) -- Added a composite UNIQUE constraint here
);

--to store information about referees.
CREATE TABLE referees (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE, -- No two referees can have the same name
  nationality TEXT,
  date_of_birth DATE,
  experience_level TEXT,
  matches_officiated INT DEFAULT 0 CHECK (matches_officiated >= 0), -- The number of matches officiated must be non-negative
  certification TEXT,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE languages (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE referee_languages (
  referee_id INT REFERENCES referees(id),
  language_id INT REFERENCES languages(id),
  PRIMARY KEY (referee_id, language_id) -- Each combination of referee and language is unique
);

CREATE TABLE player_languages (
  player_id INT REFERENCES players(id),
  language_id INT REFERENCES languages(id),
  PRIMARY KEY (player_id, language_id) -- Each combination of player and language is unique
);

--to store information about each match, including the teams that played and the referee.
CREATE TABLE matches (
  id SERIAL PRIMARY KEY,
  team1_id INT REFERENCES Teams(id),
  team2_id INT REFERENCES Teams(id),
  referee_id INT REFERENCES Referees(id),
  date DATE NOT NULL,
  location TEXT,
  stadium_name TEXT,
  team1_score INT CHECK (team1_score >= 0), -- The score of team1 must be non-negative
  team2_score INT CHECK (team2_score >= 0), -- The score of team2 must be non-negative
  winner_id INT REFERENCES Teams(id),
  draw BOOLEAN,
  attendance INT CHECK (attendance >= 0) -- The attendance must be non-negative
);

-- to store information about each goal, including the player who scored and the match in which it was scored.
CREATE TABLE goals (
  id SERIAL PRIMARY KEY,
  player_id INT REFERENCES Players(id),
  match_id INT REFERENCES Matches(id),
  minute INT NOT NULL CHECK (minute >= 0 AND minute <= 120), -- The minute must be between 0 and 120
  team_id INT REFERENCES Teams(id),
  assist_player_id INT REFERENCES Players(id),
  is_penalty BOOLEAN DEFAULT FALSE,
  is_own_goal BOOLEAN DEFAULT FALSE
);

-- to store information about each season, including the start and end dates.
CREATE TABLE seasons (
  id SERIAL PRIMARY KEY,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL CHECK (end_date > start_date), -- The end_date must be later than the start_date
  name TEXT UNIQUE, -- No two seasons can have the same name
  description TEXT,
  is_current_season BOOLEAN DEFAULT FALSE
);



-- Inserting data into the Teams table
INSERT INTO Teams (name, location, founded, stadium, coach, wins, losses, draws)
VALUES ('Team A', 'Location A', 2000, 'Stadium A', 'Coach A', 10, 5, 2);

-- Inserting data into the players table
INSERT INTO players (name, team_id, position, date_of_birth, nationality, goals_scored, height, weight, is_active)
VALUES ('Player A', 1, 'Forward', '1990-01-01', 'Country A', 5, 1.80, 75.0, TRUE);

-- Inserting data into the referees table
INSERT INTO referees (name, nationality, date_of_birth, experience_level, matches_officiated, certification, is_active)
VALUES ('Referee A', 'Country A', '1980-01-01', 'Level A', 100, 'Certification A', TRUE);

-- Inserting data into the languages table
INSERT INTO languages (name)
VALUES ('English'), ('Spanish'), ('French'), ('German'), ('Italian'), ('Portuguese'), 
       ('Russian'), ('Chinese'), ('Japanese'), ('Korean'), ('Arabic'), ('Dutch');

-- Inserting data into the referee_languages table
INSERT INTO referee_languages (referee_id, language_id)
VALUES (1, 1);

-- Inserting data into the player_languages table
INSERT INTO player_languages (player_id, language_id)
VALUES (1, 1);

-- Inserting data into the matches table
INSERT INTO matches (team1_id, team2_id, referee_id, date, location, stadium_name, team1_score, team2_score, winner_id, draw, attendance)
VALUES (1, 1, 1, '2022-01-01', 'Location A', 'Stadium A', 2, 1, 1, FALSE, 10000);

-- Inserting data into the goals table
INSERT INTO goals (player_id, match_id, minute, team_id, assist_player_id, is_penalty, is_own_goal)
VALUES (1, 1, 45, 1, 1, FALSE, FALSE);

-- Inserting data into the seasons table
INSERT INTO seasons (start_date, end_date, name, description, is_current_season)
VALUES ('2022-01-01', '2022-12-31', 'Season 2022', 'Description for Season 2022', TRUE);