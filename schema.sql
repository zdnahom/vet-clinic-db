CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg FLOAT NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE
    animals
ADD
    species VARCHAR(255);

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250) NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE
    animals DROP COLUMN species;

ALTER TABLE
    animals
ADD
    species_id;

ALTER TABLE
    animals
ADD
    CONSTRAINT fk_animals FOREIGN KEY(species_id) REFERENCES species(id) ON DELETE CASCADE;

ALTER TABLE
    animals
ADD
    owners_id INT;

ALTER TABLE
    animals
ADD
    CONSTRAINT fk_animals_owners FOREIGN KEY(owners_id) REFERENCES owners(id) ON DELETE CASCADE;

CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE specializations(
    species_id INT REFERENCES species(id) ON DELETE CASCADE,
    vets_id INT REFERENCES vets(id) ON DELETE CASCADE,
    PRIMARY KEY(species_id, vets_id)
);