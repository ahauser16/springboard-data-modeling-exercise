-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxies
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  type TEXT,
  size_ly FLOAT, -- size in light years
  mass_solar_masses FLOAT, -- mass in solar masses
  distance_from_earth_ly FLOAT, -- distance from earth in light years
  number_of_stars BIGINT,
  discovery_date DATE,
  discovered_by TEXT,
  description TEXT
);

CREATE TABLE stars
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  galaxy_id INT REFERENCES galaxies(id),
  type TEXT,
  mass_solar_masses FLOAT, -- mass in solar masses
  radius_solar_radii FLOAT, -- radius in solar radii
  temperature_k FLOAT, -- temperature in Kelvin
  luminosity_solar_luminosity FLOAT, -- luminosity in solar luminosity
  distance_from_galactic_center_ly FLOAT, -- distance from galactic center in light years
  discovery_date DATE,
  discovered_by TEXT,
  number_of_planets INT
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT,
  star_id INT REFERENCES stars(id),
  type TEXT,
  mass_earth_masses FLOAT, -- mass in earth masses
  radius_earth_radii FLOAT, -- radius in earth radii
  distance_from_star_au FLOAT, -- distance from star in astronomical units
  rotation_period_hours FLOAT, -- rotation period in hours
  orbital_eccentricity FLOAT,
  discovery_date DATE,
  discovered_by TEXT,
  number_of_moons INT,
  atmospheric_composition TEXT
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  planet_id INT REFERENCES planets(id),
  type TEXT,
  mass_earth_masses FLOAT, -- mass in earth masses
  radius_km FLOAT, -- radius in kilometers
  orbital_period_days FLOAT, -- orbital period in days
  distance_from_planet_km FLOAT, -- distance from planet in kilometers
  discovery_date DATE,
  discovered_by TEXT,
  surface_composition TEXT,
  atmospheric_composition TEXT
);

-- Insert into galaxies
INSERT INTO galaxies (name, type, size, mass, distance_from_earth, number_of_stars, discovery_date, discovered_by, description)
VALUES ('Milky Way', 'Spiral', 100000, 1.5E12, 0, 250000000000, '1610-01-01', 'Galileo Galilei', 'Our home galaxy');

-- Insert into stars
INSERT INTO stars (name, galaxy_id, type, mass, radius, temperature, luminosity, distance_from_galactic_center, discovery_date, discovered_by, number_of_planets)
VALUES ('Sun', 1, 'G-type main-sequence star', 1, 1, 5778, 1, 27000, 'BEFORE RECORD', 'Ancient civilizations', 8);

-- Insert into planets
INSERT INTO planets (name, orbital_period_in_years, star_id, type, mass, radius, distance_from_star, rotation_period, orbital_eccentricity, discovery_date, discovered_by, number_of_moons, atmospheric_composition)
VALUES ('Earth', 1, 1, 'Terrestrial', 1, 1, 1, 24, 0.0167, 'BEFORE RECORD', 'Ancient civilizations', 1, '78% Nitrogen, 21% Oxygen');

-- Insert into moons
INSERT INTO moons (name, planet_id, type, mass, radius, orbital_period, distance_from_planet, discovery_date, discovered_by, surface_composition, atmospheric_composition)
VALUES ('Moon', 1, 'Regular', 0.0123, 1737.1, 27.3, 384400, 'BEFORE RECORD', 'Ancient civilizations', '70% Silicate minerals, 14% Alumina', 'Trace amounts of gases');