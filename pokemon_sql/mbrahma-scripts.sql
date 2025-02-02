# What are all the types of pokemon that a pokemon can have?
# Normal
# Water
# Grass
# Rock
# Fire
# Ground
# Poison
# Bug
# Electric
# Dragon
# Steel
# Dark
# Fighting
# Psychic
# Ghost
# Fairy
# Ice
# Flying
SELECT name
FROM pokemon.types;

# What is the name of the pokemon with id 45?
#Eevee
SELECT name
FROM pokemon.pokemons
WHERE id = 45;

# How many pokemon are there?
#656
SELECT count(*) as 'COUNT'
FROM pokemon.pokemons;

# How many types are there?
#18
SELECT count(*)
FROM pokemon.types;

# How many pokemon have a secondary type?
# 316
SELECT count(*)
FROM pokemon.pokemons
WHERE secondary_type IS NOT NULL;

# What is each pokemon's primary type?
#
SELECT p.name, types.name
FROM pokemon.pokemons p
JOIN pokemon.types types
ON p.primary_type = types.id;

# What is Rufflet's secondary type?
# Flying
SELECT types.name
FROM pokemon.pokemons p
JOIN pokemon.types types
ON p.secondary_type = types.id
WHERE p.name = "Rufflet";

# What are the names of the pokemon that belong to the trainer with trainerID 303?
# Wailord	303
# Vileplume	303

SELECT p.name, pt.trainerID
FROM pokemon.trainers t
       JOIN pokemon.pokemon_trainer pt
            ON pt.trainerID = t.trainerID
       JOIN pokemon.pokemons p
            ON p.id = pt.pokemon_id
WHERE t.trainerID = 303;

# How many pokemon have a secondary type Poison
# 31
SELECT count(*)
FROM pokemon.pokemons
WHERE secondary_type = 7;

# What are all the primary types and how many pokemon have that type?
# Normal	90
# Water	95
# Grass	59
# Rock	38
# Fire	38
# Ground	29
# Poison	27
# Bug	61
# Electric	35
# Dragon	22
# Steel	19
# Dark	24
# Fighting	25
# Psychic	38
# Ghost	19
# Fairy	14
# Ice	22
# Flying	1

SELECT types.name as "Name", count(*) as "Count"
FROM pokemon.pokemons p
       JOIN pokemon.types types
            ON types.id = p.primary_type
GROUP BY p.primary_type;

# How many pokemon at level 100 does each trainer with at least one level 100 pokemon have? (Hint: your query should not display a trainer
SELECT pt.trainerID as "Trainer ID", count(*)
FROM pokemon.pokemon_trainer pt
WHERE pt.pokelevel >= 100
GROUP BY pt.trainerID;

# How many pokemon only belong to one trainer and no other?
# Clawitzer	1
# Barbaracle	1
# Tynamo	1
# Rufflet	1
# Lugia	1
# Binacle	1
# Malamar	1
# Zekrom	1
# Reshiram	1
# Happiny	1
# Zweilous	1
# Swirlix	1
# Spewpa	1

SELECT p.name as "NAME", count(trainerID) as "COUNT"
FROM pokemon.pokemon_trainer pt
       JOIN pokemon.pokemons p
            ON p.id = pt.pokemon_id
GROUP BY p.name
HAVING count(*) = 1;

# Directions: Write a query that returns the following collumns:
# Pokemon Name	  |Trainer Name	  |Level	        |Primary Type	      |Secondary Type
# Pokemon's name	|Trainer's name	|Current Level	|Primary Type Name	|Secondary Type Name

# Sort the data by finding out which trainer has the strongest pokemon so that this will
# act as a ranking of strongest to weakest trainer. You may interpret strongest in whatever way you want,
# but you will have to explain your decision.

#I chose to sort by level with it descending the higher the number the higher the power
#In my opinion Fire type is the highest with the secondary type as Flying.
#The combination of the two go well in increasing the effectiveness of their powers
#against other pokemon.


SELECT p.name        as 'Pokemon Name',
       t.trainername as 'Trainer Name',
       pt.pokelevel  as 'Level',
       types.name    as 'Primary Type',
       types2.name   as 'Secondary Type'
FROM pokemon.pokemon_trainer AS pt
       LEFT OUTER JOIN pokemon.trainers AS t ON t.trainerID = pt.trainerID
       LEFT OUTER JOIN pokemon.pokemons AS p ON pt.pokemon_id = p.id
       LEFT OUTER JOIN pokemon.types AS types ON types.id = primary_type
       LEFT OUTER JOIN pokemon.types AS types2 ON types2.id = secondary_type
ORDER BY pt.pokelevel DESC,
         CASE
           WHEN types.id = 5 THEN 1
           WHEN types.id = 10 THEN 2
           WHEN types.id = 17 THEN 3
           ELSE 4
           END ASC,
         CASE
           WHEN types2.id = 18 THEN 1
           ELSE 2
           END ASC;
