-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE passengers
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  date_of_birth DATE,
  gender TEXT,
  nationality TEXT,
  passport_number TEXT,
  contact_info TEXT,
  emergency_contact TEXT,
  frequent_flyer_number TEXT,
  special_needs TEXT
);

CREATE TABLE airlines
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  iata_code TEXT,
  icao_code TEXT,
  country TEXT,
  founded INT,
  fleet_size INT,
  hub_airports TEXT,
  website TEXT,
  contact_info TEXT
);

CREATE TABLE cities
(
  id SERIAL PRIMARY KEY,
  city TEXT NOT NULL,
  country TEXT NOT NULL,
  airport_code TEXT,
  timezone TEXT,
  latitude FLOAT,
  longitude FLOAT,
  population BIGINT,
  region TEXT,
  airport_name TEXT
);

CREATE TABLE flights
(
  id SERIAL PRIMARY KEY,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  from_city_id INT REFERENCES cities(id),
  to_city_id INT REFERENCES cities(id),
  airline_id INT REFERENCES airlines(id),
  flight_number TEXT,
  aircraft_type TEXT,
  status TEXT,
  gate TEXT,
  terminal TEXT,
  estimated_departure TIMESTAMP,
  estimated_arrival TIMESTAMP,
  actual_departure TIMESTAMP,
  actual_arrival TIMESTAMP,
  duration INTERVAL
);

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  seat TEXT NOT NULL,
  passenger_id INT REFERENCES passengers(id),
  flight_id INT REFERENCES flights(id),
  price DECIMAL,
  class TEXT,
  booking_date DATE,
  status TEXT,
  baggage_allowance TEXT,
  seat_type TEXT,
  meal_preference TEXT,
  ticket_number TEXT
);

-- Insert into passengers
INSERT INTO passengers (first_name, last_name, date_of_birth, gender, nationality, passport_number, contact_info, emergency_contact, frequent_flyer_number, special_needs)
VALUES ('John', 'Doe', '1980-01-01', 'Male', 'USA', '123456789', 'johndoe@example.com', 'Jane Doe: janedoe@example.com', 'ABC123', NULL);

-- Insert into airlines
INSERT INTO airlines (name, iata_code, icao_code, country, founded, fleet_size, hub_airports, website, contact_info)
VALUES ('Airline Name', 'AN', 'AIN', 'USA', 1930, 200, 'JFK, LAX', 'www.airlinename.com', 'info@airlinename.com');

-- Insert into cities
INSERT INTO cities (city, country, airport_code, timezone, latitude, longitude, population, region, airport_name)
VALUES ('New York', 'USA', 'JFK', 'America/New_York', 40.7128, -74.0060, 8623000, 'New York', 'John F. Kennedy International Airport');

-- Insert into flights
INSERT INTO flights (departure, arrival, from_city_id, to_city_id, airline_id, flight_number, aircraft_type, status, gate, terminal, estimated_departure, estimated_arrival, actual_departure, actual_arrival, duration)
VALUES ('2022-01-01 10:00:00', '2022-01-01 14:00:00', 1, 1, 1, 'AN123', 'Boeing 777', 'Scheduled', 'A1', '1', '2022-01-01 10:00:00', '2022-01-01 14:00:00', NULL, NULL, '4 hours');

-- Insert into tickets
INSERT INTO tickets (seat, passenger_id, flight_id, price, class, booking_date, status, baggage_allowance, seat_type, meal_preference, ticket_number)
VALUES ('1A', 1, 1, 200.00, 'Economy', '2021-12-01', 'Booked', '23 kg', 'Window', 'Vegetarian', 'AN123-1A');
