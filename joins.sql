-- Creating database
CREATE DATABASE squirrels_db;

-- Using database
USE squirrels_db;

-- Creating table species
CREATE TABLE species (
    species_id INT PRIMARY KEY,
    species_name VARCHAR(50) NOT NULL,
    avg_lifespan INT,
    conservation_status VARCHAR(30)
);

-- Creating table habitats
CREATE TABLE habitats (
    habitat_id INT PRIMARY KEY,
    habitat_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- Creating table sightings
CREATE TABLE sightings (
    sighting_id INT PRIMARY KEY,
    species_id INT,
    habitat_id INT,
    sighting_date DATE,
    observer_name VARCHAR(50),
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (habitat_id) REFERENCES habitats(habitat_id)
);

-- Creating table conservation_projects
CREATE TABLE conservation_projects (
    project_id INT PRIMARY KEY,
    species_id INT,
    project_name VARCHAR(100),
    status VARCHAR(30),
    FOREIGN KEY (species_id) REFERENCES species(species_id)
);

-- Creating table researchers
CREATE TABLE researchers (
    researcher_id INT PRIMARY KEY,
    researcher_name VARCHAR(50) NOT NULL,
    species_id INT,
    phone_no VARCHAR(15),
    department VARCHAR(50),
    supervisor_id INT,
    FOREIGN KEY (species_id) REFERENCES species(species_id)
);
-- Inserting data into species table
INSERT INTO species VALUES (1, 'Eastern Gray Squirrel', 6, 'Least Concern');
INSERT INTO species VALUES (2, 'Red Squirrel', 5, 'Near Threatened');
INSERT INTO species VALUES (3, 'Fox Squirrel', 8, 'Least Concern');

-- Inserting data into habitats table
INSERT INTO habitats VALUES (1, 'Pine Forest', 'Northern Region');
INSERT INTO habitats VALUES (2, 'Mixed Woodlands', 'Central Region');
INSERT INTO habitats VALUES (3, 'Urban Parks', 'Southern Region');

-- Inserting data into sightings table
INSERT INTO sightings VALUES (1001, 1, 1, '2023-01-15', 'Alice');
INSERT INTO sightings VALUES (1002, 2, 2, '2023-02-20', 'Bob');
INSERT INTO sightings VALUES (1003, 3, 3, '2023-03-18', 'Carol');
INSERT INTO sightings VALUES (1004, 1, 2, '2023-04-22', 'Dave');

-- Inserting data into conservation_projects table
INSERT INTO conservation_projects VALUES (1, 2, 'Habitat Restoration', 'Ongoing');
INSERT INTO conservation_projects VALUES (2, 1, 'Urban Adaptation', 'Completed');
INSERT INTO conservation_projects VALUES (3, 3, 'Population Study', 'Ongoing');

-- Inserting data into researchers table
INSERT INTO researchers VALUES (401, 'Dr. Smith', 1, '1234567890', 'Biology', 404);
INSERT INTO researchers VALUES (402, 'Dr. Johnson', 2, '0987654321', 'Ecology', 405);
INSERT INTO researchers VALUES (403, 'Dr. Williams', 3, '5555555555', 'Zoology', 401);
INSERT INTO researchers VALUES (404, 'Dr. Brown', 1, '4444444444', 'Biology', NULL);
INSERT INTO researchers VALUES (405, 'Dr. Jones', 2, '3333333333', 'Ecology', NULL);
-- Displaying details of species table
SELECT * FROM species;

-- Displaying details of habitats table
SELECT * FROM habitats;

-- Displaying details of sightings table
SELECT * FROM sightings;

-- Displaying details of conservation_projects table
SELECT * FROM conservation_projects;

-- Displaying details of researchers table
SELECT * FROM researchers;
-- INNER JOIN 
-- Getting the name of species and their habitats
SELECT species.species_name, habitats.habitat_name
FROM sightings
INNER JOIN species ON sightings.species_id = species.species_id
INNER JOIN habitats ON sightings.habitat_id = habitats.habitat_id;
-- LEFT OUTER JOIN 
-- Getting all species and their sightings, including those without sightings
SELECT species.species_name, sightings.sighting_date, sightings.observer_name
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id;
-- RIGHT OUTER JOIN
-- Getting all sightings and their species, including those without species info
SELECT sightings.sighting_id, species.species_name, sightings.sighting_date
FROM sightings
RIGHT JOIN species ON sightings.species_id = species.species_id;
-- FULL OUTER JOIN 
-- Displaying all species and sightings
SELECT species.species_name, sightings.sighting_date, sightings.observer_name
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
UNION
SELECT species.species_name, sightings.sighting_date, sightings.observer_name
FROM species
RIGHT JOIN sightings ON species.species_id = sightings.species_id;
-- SELF JOIN 
-- Displaying researchers with their supervisors
SELECT r1.researcher_name AS Researcher, r2.researcher_name AS Supervisor
FROM researchers r1
INNER JOIN researchers r2 ON r1.supervisor_id = r2.researcher_id;
-- CROSS JOIN 
-- Displaying all combinations of species and habitats
SELECT species.species_name, habitats.habitat_name
FROM species
CROSS JOIN habitats;
-- details of all sightings in "Pine Forest"
SELECT * FROM sightings
LEFT JOIN habitats ON sightings.habitat_id = habitats.habitat_id
WHERE habitat_name = 'Pine Forest';
-- details of all sightings of "Red Squirrel"
SELECT * FROM sightings
RIGHT JOIN species ON sightings.species_id = species.species_id
WHERE species_name = 'Red Squirrel';
-- sighting_id, species_name, observer_name, and sighting_date for sightings observed by "Alice"
SELECT sightings.sighting_id, species.species_name, sightings.observer_name, sightings.sighting_date
FROM sightings
INNER JOIN species ON sightings.species_id = species.species_id
WHERE observer_name = 'Alice';
-- sighting_id, species_name, observer_name, and sighting_date for sightings observed by "Alice" in "Pine Forest"
SELECT sightings.sighting_id, species.species_name, sightings.observer_name, sightings.sighting_date
FROM sightings
INNER JOIN species ON sightings.species_id = species.species_id
INNER JOIN habitats ON sightings.habitat_id = habitats.habitat_id
WHERE observer_name = 'Alice' AND habitat_name = 'Pine Forest';
-- sighting_id, species_name, observer_name, habitat_name, and sighting_date for sightings that are ongoing or in a specific status
SELECT sightings.sighting_id, species.species_name, sightings.observer_name, habitats.habitat_name, sightings.sighting_date
FROM sightings
CROSS JOIN species ON sightings.species_id = species.species_id
CROSS JOIN habitats ON sightings.habitat_id = habitats.habitat_id
WHERE sightings.sighting_date IS NOT NULL;
-- Display sighting details including species and observer details
SELECT sightings.sighting_id, species.species_name, sightings.observer_name, habitats.habitat_name, sightings.sighting_date
FROM sightings
INNER JOIN species ON sightings.species_id = species.species_id
INNER JOIN habitats ON sightings.habitat_id = habitats.habitat_id;