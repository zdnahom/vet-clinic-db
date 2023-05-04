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