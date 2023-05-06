/*Normal Queries*/
SELECT
    *
FROM
    animals
WHERE
    name LIKE '%mon';

SELECT
    name
FROM
    animals
WHERE
    date_of_birth BETWEEN '2016-01-01'
    AND '2019-12-30';

SELECT
    name
FROM
    animals
WHERE
    neutered = TRUE
    AND escape_attempts < 3;

SELECT
    date_of_birth
FROM
    animals
WHERE
    name IN ('Agumon', 'Pikachu');

SELECT
    name,
    escape_attempts
FROM
    animals
WHERE
    weight_kg > 10.5;

SELECT
    *
FROM
    animals
WHERE
    neutered = TRUE;

SELECT
    *
FROM
    animals
WHERE
    name != 'Gabumon';

SELECT
    *
FROM
    animals
WHERE
    weight_kg >= 10.4
    AND weight_kg <= 17.3;

/*Transaction Queries*/
BEGIN;

UPDATE
    animals
SET
    species = 'unspecified';

ROLLBACK;

BEGIN;

UPDATE
    animals
SET
    species = 'digimon'
WHERE
    name LIKE '%mon';

UPDATE
    animals
SET
    species = 'pokemon'
WHERE
    species IS NULL;

COMMIT;

BEGIN;

DELETE FROM
    animals;

ROLLBACK;

BEGIN;

DELETE FROM
    animals
WHERE
    date_of_birth > '2022-01-01';

SAVEPOINT sp1;

UPDATE
    animals
SET
    weight_kg = weight_kg * (-1);

ROLLBACK TO sp1;

UPDATE
    animals
SET
    weight_kg = weight_kg * (-1)
WHERE
    weight_kg < 0;

COMMIT;

/*Normal Queries*/
SELECT
    COUNT(*) AS animals_count
FROM
    animals;

SELECT
    COUNT(*) AS animals_count
FROM
    animals
WHERE
    escape_attempts = 0;

SELECT
    AVG(weight_kg) AS average_weight
FROM
    animals;

SELECT
    neutered,
    SUM(escape_attempts) AS total_escape
FROM
    animals
GROUP BY
    neutered;

SELECT
    species,
    MIN(weight_kg) AS MIN_weight,
    MAX(weight_kg) AS MAX_weight
FROM
    animals
GROUP BY
    species;

SELECT
    species,
    AVG(escape_attempts) AS average_attempt
FROM
    animals
WHERE
    date_of_birth BETWEEN '1990-01-01'
    AND '2000-12-30'
GROUP BY
    species;

/* Queries using JOIN */
SELECT
    animals.name,
    owners.full_name
FROM
    animals
    JOIN owners ON owners.id = animals.owners_id
WHERE
    owners.full_name = 'Melody Pond';

SELECT
    animals.name,
    species.name AS species
FROM
    animals
    JOIN species ON species.id = animals.species_id
WHERE
    species.name = 'Pokemon';

SELECT
    animals.name,
    owners.full_name
FROM
    animals
    RIGHT JOIN owners ON owners.id = animals.owners_id;

SELECT
    COUNT(animals.name),
    species.name
FROM
    animals
    JOIN species ON species.id = animals.species_id
GROUP BY
    species.name;

SELECT
    animals.name,
    species.name AS species,
    owners.full_name AS owned_by
FROM
    animals
    JOIN owners ON owners.id = animals.owners_id
    JOIN species ON species.id = animals.species_id
WHERE
    owners.full_name = 'Jennifer Orwell'
    AND species.name = 'Digimon';

SELECT
    animals.name,
    owners.full_name AS owned_by
FROM
    animals
    JOIN owners ON owners.id = animals.owners_id
WHERE
    owners.id = 5
    AND animals.escape_attempts = 0;

SELECT
    owners.full_name AS owned_by,
    COUNT(animals.name) AS total_animals
FROM
    animals
    RIGHT JOIN owners ON owners.id = animals.owners_id
GROUP BY
    owners.full_name
ORDER BY
    total_animals DESC;

/* JOIN tables queries */
SELECT
    animals.name AS animals_name,
    visits.visit_date
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
WHERE
    vets.name = 'William Tatcher'
ORDER BY
    visits.visit_date DESC
limit
    1;

SELECT
    COUNT(animals.name) AS Total_no_of_animals
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
WHERE
    vets.name = 'Stephanie Mendez';

SELECT
    vets.name,
    species.name AS specialization
FROM
    vets
    LEFT JOIN specializations ON specializations.vets_id = vets.id
    LEFT JOIN species ON species.id = specializations.species_id;

SELECT
    animals.name AS animals_name
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
WHERE
    vets.name = 'Stephanie Mendez'
    AND visits.visit_date BETWEEN '2020-04-01'
    AND '2020-08-30';

SELECT
    animals.name,
    COUNT(animals.name) AS total_visits
FROM
    visits
    LEFT JOIN animals ON animals.id = visits.animals_id
GROUP BY
    animals.name
ORDER BY
    total_visits DESC
LIMIT
    1;

SELECT
    animals.name AS animals_name,
    visits.visit_date
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
WHERE
    vets.name = 'Maisy Smith'
ORDER BY
    visits.visit_date ASC
limit
    1;

SELECT
    *
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
ORDER BY
    visits.visit_date DESC
limit
    1;

SELECT
    COUNT(*) AS total_visits
FROM
    visits
    LEFT JOIN animals ON animals.id = visits.animals_id
    LEFT JOIN vets ON vets.id = visits.vets_id
WHERE
    animals.species_id NOT IN (
        SELECT
            specializations.species_id
        FROM
            specializations
        WHERE
            specializations.vets_id = vets.id
    );

SELECT
    species.name AS species,
    COUNT(species.name) AS total_animals_visit
FROM
    animals
    JOIN visits ON visits.animals_id = animals.id
    JOIN vets ON vets.id = visits.vets_id
    JOIN species ON species.id = animals.species_id
WHERE
    vets.name = 'Maisy Smith'
GROUP BY
    species
ORDER BY
    total_animals_visit DESC
LIMIT
    1;
