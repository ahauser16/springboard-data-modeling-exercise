-- STEPS TO RUN FROM THE TERMINAL:
----STEP ONE--start the PostgreSQL service using the command 'sudo service postgresql start'
----STEP TWO--cd into the directory with the sql file you want to run and run the command 'psql -U username -f medical_center.sql'.
--STEP THREE-- you can now connect to the psql interface and medical_center database by running the command 'psql -U username -d medical_center' and then you can list all tables to verify that they were created by running the command '\dt'.

--NOTES
--homework prompt - Part Two: Craigslist
-- Design a schema for Craigslist! Your schema should keep track of the following
---- The region of the craigslist post (San Francisco, Atlanta, Seattle, etc)
---- Users and preferred region
---- Posts: contains title, text, the user who has posted, the location of the posting, the region of the posting
---- Categories that each post belongs to

-- Design methodology: Based on the requirements, we can create the following tables:

DROP DATABASE IF EXISTS gregslist;

CREATE DATABASE gregslist;

\c gregslist;

CREATE TABLE regions (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL, -- Hashed password for security
  username VARCHAR(255) UNIQUE, -- Unique username for login
  phone_number VARCHAR(15), -- Phone numbers are usually not longer than 15 characters
  address TEXT, -- Address can be long, so TEXT is appropriate
  join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set to the current date and time when the user is created
  last_login TIMESTAMP, -- Updated each time the user logs in
  profile_picture TEXT, -- URL of the profile picture
  bio TEXT, -- User's biography or description
  is_admin BOOLEAN DEFAULT FALSE, -- By default, a user is not an admin
  is_active BOOLEAN DEFAULT TRUE, -- By default, a user's account is active
  preferred_region_id INT REFERENCES Regions(id)
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  text TEXT NOT NULL,
  user_id INT REFERENCES Users(id),
  location TEXT NOT NULL,
  region_id INT REFERENCES Regions(id),
  post_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set to the current date and time when the post is created
  last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set to the current date and time when the post is created, updated each time the post is modified
  is_active BOOLEAN DEFAULT TRUE, -- By default, a post is active
  price DECIMAL(10, 2), -- Price with two decimal places for cents
  image_url TEXT, -- URL of the image
  contact_info TEXT -- Contact information for the poster
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT, -- Description of the category
  parent_id INT REFERENCES categories(id) -- Self-referencing foreign key for parent category
);

--parent_id: This field is a foreign key that references the id of another row in the same table. This is known as a self-referencing foreign key. The INT data type is used because it matches the data type of the id field. This field is used to create a hierarchy of categories and subcategories. For a top-level category, parent_id would be NULL.

CREATE TABLE post_categories (
  post_id INT REFERENCES Posts(id),
  category_id INT REFERENCES Categories(id),
  assigned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set to the current date and time when the row is created
  PRIMARY KEY(post_id, category_id)
);

--SQL syntax notes: 
-- Identifiers: These are the names of tables, columns, databases, etc. In your example, doctors, id, name, and specialty are identifiers.

-- Operators: These are used to perform operations on data. Examples include arithmetic operators like +, -, *, /, comparison operators like =, <>, <, >, <=, >=, and logical operators like AND, OR, NOT.

-- Functions: SQL provides a wide range of functions to manipulate and process the data. These include aggregate functions like SUM, AVG, MAX, MIN, COUNT, string functions like SUBSTRING, TRIM, LOWER, UPPER, date and time functions like NOW, DATE, TIME, etc.

-- Keywords: These are reserved words that have a special meaning in SQL. Examples include CREATE, TABLE, PRIMARY, KEY, NOT, NULL, etc.

-- Expressions: These are combinations of identifiers, literals, operators, and functions that SQL evaluates to a value.

-- Clauses: These are components of statements and queries. Examples include WHERE, FROM, ORDER BY, GROUP BY, HAVING, etc.

-- Statements: These are the queries or commands that tell the database what to do. Examples include SELECT, INSERT, UPDATE, DELETE, CREATE TABLE, DROP TABLE, etc.

-- Comments: These are notes added to the code for explanation or documentation. In SQL, comments can be added by using -- for single line comments or /* ... */ for multi-line comments.