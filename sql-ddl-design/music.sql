-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music


CREATE TABLE artists
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  genre TEXT,
  label TEXT,
  bio TEXT,
  active_years TEXT,
  website TEXT,
  country TEXT,
  date_signed DATE,
  albums_released INT
);

CREATE TABLE albums
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  release_date DATE NOT NULL,
  artist_id INT REFERENCES artists(id),
  genre TEXT,
  label TEXT,
  number_of_tracks INT,
  total_duration INT,
  cover_art TEXT,
  recording_studio TEXT,
  producer TEXT
);

CREATE TABLE producers
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  bio TEXT,
  active_years TEXT,
  genre TEXT,
  label TEXT,
  contact_info TEXT,
  number_of_albums_produced INT,
  awards TEXT
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  artist_id INT REFERENCES artists(id),
  album_id INT REFERENCES albums(id),
  genre TEXT,
  lyrics TEXT,
  release_date DATE,
  producer_id INT REFERENCES producers(id),
  track_number INT,
  recording_date DATE,
  awards TEXT
);

CREATE TABLE song_artists
(
  song_id INT REFERENCES songs(id),
  artist_id INT REFERENCES artists(id),
  role TEXT,
  contribution_date DATE,
  PRIMARY KEY (song_id, artist_id)
);

CREATE TABLE song_producers
(
  song_id INT REFERENCES songs(id),
  producer_id INT REFERENCES producers(id),
  role TEXT,
  contribution_date DATE,
  PRIMARY KEY (song_id, producer_id)
);

-- Insert into artists
INSERT INTO artists (name, genre, label, bio, active_years, website, country, date_signed, albums_released)
VALUES ('Artist Name', 'Rock', 'Label Name', 'Short bio', '2000-2022', 'www.artistwebsite.com', 'USA', '2000-01-01', 10);

-- Insert into producers
INSERT INTO producers (name, bio, active_years, genre, label, contact_info, number_of_albums_produced, awards)
VALUES ('Producer Name', 'Short bio', '1995-2022', 'Rock', 'Label Name', 'producer@labelname.com', 50, 'Grammy');

-- Insert into albums
INSERT INTO albums (name, release_date, artist_id, genre, label, number_of_tracks, total_duration, cover_art, recording_studio, producer)
VALUES ('Album Name', '2022-01-01', 1, 'Rock', 'Label Name', 10, 3600, 'www.albumcoverart.com', 'Studio Name', 'Producer Name');

-- Insert into songs
INSERT INTO songs (title, duration_in_seconds, artist_id, album_id, genre, lyrics, release_date, producer_id, track_number, recording_date, awards)
VALUES ('Song Title', 200, 1, 1, 'Rock', 'Song lyrics', '2022-01-01', 1, 1, '2021-12-01', 'Grammy');

-- Insert into song_artists
INSERT INTO song_artists (song_id, artist_id, role, contribution_date)
VALUES (1, 1, 'Lead', '2021-12-01');

-- Insert into song_producers
INSERT INTO song_producers (song_id, producer_id, role, contribution_date)
VALUES (1, 1, 'Executive Producer', '2021-12-01');