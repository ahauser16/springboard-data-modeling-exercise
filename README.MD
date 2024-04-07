# Project Title

## Description
A brief description of what this project does and who it's for.

## Installation
Provide step by step series of examples and explanations about how to get a development environment running.

```bash
git clone <repo>
cd <project>
```

## Usage
Provide instructions and examples for use.

## Contributing
Details on how to contribute to this project.

## License
Information about the license.

## Notes:

### Step One - prompt

Design a schema for a simple sports league. Your schema should keep track of (1) - All of the teams in the league, (2) - All of the goals scored by every player for each game, (3) - All of the players in the league and their corresponding teams, (4) - All of the referees who have been part of each game, (5) - All of the matches played between teams, (6) - All of the start and end dates for season that a league has and (7) - The standings/rankings of each team in the league (This doesn’t have to be its own table if the data can be captured somehow).

### Step One - review
review results of tables created.

e.g.
```
CREATE TABLE Teams (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE Players (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  team_id INT REFERENCES Teams(id)
);

CREATE TABLE Referees (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE Matches (
  id SERIAL PRIMARY KEY,
  team1_id INT REFERENCES Teams(id),
  team2_id INT REFERENCES Teams(id),
  referee_id INT REFERENCES Referees(id),
  date DATE NOT NULL
);

CREATE TABLE Goals (
  id SERIAL PRIMARY KEY,
  player_id INT REFERENCES Players(id),
  match_id INT REFERENCES Matches(id),
  minute INT NOT NULL
);

CREATE TABLE Seasons (
  id SERIAL PRIMARY KEY,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL
);
```

### Step Two - prompt
brainstorm additional categories of information that I may want to keep in my 'name_of_table_A' table. 

[updated CREATE TABLE syntax_v1]
e.g.
```
CREATE TABLE Teams (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);
```

### Step Two - review
review 2nd round results of tables created.

Here's the reasoning for the additional SQL syntax:

location, stadium, and coach: These fields can contain a large amount of text, so the TEXT data type is used. These fields are not marked as NOT NULL because they're optional; not all teams might have this information.

founded: This field represents the year the team was founded, which is a whole number, so the INT data type is used.

```
CREATE TABLE Teams (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  location TEXT, -- Location of the team
  founded INT, -- Year the team was founded
  stadium TEXT, -- Name of the team's home stadium
  coach TEXT -- Name of the team's current coach
);
```

### Step Three - prompt

For the Teams table add SQL syntax to each category based on the best practices used to handle that kind of data. Explain your reasoning for the additional SQL syntax. Keep in mind additional SQL syntax may contain: "Data Types", "Constraints", "Identifiers", "Operators", "Functions", "Keywords", "Expressions", "Clauses" and/or "Statements". Use database best practices and the context of this use case which is to [manage a simple sports league] to brainstorm the additional categories and SQL syntax.

[updated CREATE TABLE syntax_v2]
e.g.
```
CREATE TABLE Teams (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  location TEXT, -- Location of the team
  founded INT, -- Year the team was founded
  stadium TEXT, -- Name of the team's home stadium
  coach TEXT -- Name of the team's current coach
);
```

### Step Three - review

```
CREATE TABLE Teams (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  location TEXT, -- Location of the team
  founded INT, -- Year the team was founded
  stadium TEXT, -- Name of the team's home stadium
  coach TEXT, -- Name of the team's current coach
  league_id INT REFERENCES Leagues(id), -- ID of the league the team belongs to
  wins INT DEFAULT 0, -- Number of wins, default to 0
  losses INT DEFAULT 0, -- Number of losses, default to 0
  draws INT DEFAULT 0 -- Number of draws, default to 0
);
```

### Step Four - prompt

What additional constraints that could be added to this table?

### Step Four - review

```
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
```

### Step Five - prompt

now I want you to write sample SQL to insert data into these tables below. Make sure the SQL statements add data to each category and adhere to all constraints.