/* 
Database Anomalies
Database anomalies are undesirable conditions in a relational database that can lead to data inconsistency and manipulation issues.

Insertion Anomalies: Occur when you cannot insert valid data due to the structure of the table.
Deletion Anomalies: Occur when deleting a row also deletes unrelated data.
Update Anomalies: Occur when updating a value in one row requires changes in other rows to maintain consistency, potentially leading to errors.
Example of Update Anomaly
Here is a situation where the conservation status of the "Eastern Gray Squirrel" (SpeciesID: 1) needs to be updated from "Least Concern" to "Near Threatened". */
UPDATE Species
SET conservation_status = 'Near Threatened'
WHERE species_id = 1;
-- Example of Deletion Anomaly
DELETE FROM Habitats
WHERE habitat_id = 5;
-- Example of Insertion Anomaly
INSERT INTO Sightings (sighting_id, species_id, habitat_id, sighting_date)
VALUES (10005, 3, 106, '2023-05-15');
-- Creating a Primary Key
CREATE TABLE Species (
    species_id INT PRIMARY KEY,
    species_name VARCHAR(50) NOT NULL,
    conservation_status VARCHAR(30)
);
-- Creating a Foreign Key
CREATE TABLE Sightings (
    sighting_id INT PRIMARY KEY,
    species_id INT,
    habitat_id INT,
    sighting_date DATE,
    FOREIGN KEY (species_id) REFERENCES Species(species_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id)
);
-- Example of 1NF
/* 1NF : There are only single valued attributes (atomic values)
No repeating groups */
CREATE TABLE Habitats (
    habitat_id INT PRIMARY KEY,
    habitat_name VARCHAR(50) NOT NULL
);
-- Example of 2NF
/* 2NF : It is in 1NF
All non-key attributes depend on the entire primary key */
CREATE TABLE Sightings (
    sighting_id INT PRIMARY KEY,
    species_id INT,
    habitat_id INT,
    sighting_date DATE,
    FOREIGN KEY (species_id) REFERENCES Species(species_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id)
);
-- Example of 3NF 
/* It is in 2NF
There are no transitive dependencies */
CREATE TABLE Researchers (
    researcher_id INT PRIMARY KEY,
    researcher_name VARCHAR(50)
);

CREATE TABLE Sightings (
    sighting_id INT PRIMARY KEY,
    species_id INT,
    habitat_id INT,
    sighting_date DATE,
    researcher_id INT,
    FOREIGN KEY (species_id) REFERENCES Species(species_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id),
    FOREIGN KEY (researcher_id) REFERENCES Researchers(researcher_id)
);

-- Boyce-Codd Normal Form : BCNF is a higher level of normalization than 3NF.
CREATE TABLE Sightings (
    sighting_id INT PRIMARY KEY,
    sighting_date DATE
);

CREATE TABLE SightingDetails (
    sighting_id INT,
    species_id INT,
    habitat_id INT,
    PRIMARY KEY (sighting_id, species_id, habitat_id),
    FOREIGN KEY (sighting_id) REFERENCES Sightings(sighting_id),
    FOREIGN KEY (species_id) REFERENCES Species(species_id),
    FOREIGN KEY (habitat_id) REFERENCES Habitats(habitat_id)
);
 
-- information displaying 
SELECT species_id, species_name, conservation_status
FROM Species;

-- researchers
SELECT s.sighting_id, r.researcher_name, s.species_id
FROM Sightings s
INNER JOIN Researchers r ON s.researcher_id = r.researcher_id
WHERE s.researcher_id = 102;

-- BCNF : Ensures every non-trivial functional dependency has a superkey as its determinant.
