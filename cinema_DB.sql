CREATE DATABASE IF NOT EXISTS cinema_DB;

USE cinema_DB;

DROP TABLE IF EXISTS Prices, Places, Sessions, Movies, Users, MovieRooms, Cinemas;

CREATE TABLE IF NOT EXISTS Cinemas (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(300) NOT NULL
);

CREATE TABLE IF NOT EXISTS MovieRooms(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR (250) NOT NULL,
    capacity INT NOT NULL,
    cinema_id INT,
    FOREIGN KEY (cinema_id) REFERENCES Cinemas(id)
);

CREATE TABLE IF NOT EXISTS Users (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'User') NOT NULL,
    cinema_id INT,
    FOREIGN KEY (cinema_id) REFERENCES Cinemas(id)
);

CREATE TABLE IF NOT EXISTS Movies(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration TIME NOT NULL,
    realiseDate DATE NOT NULL,
    gender VARCHAR(255) NOT NULL,
    directedBy VARCHAR(255) NOT NULL,
    moviePoster VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Sessions(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    date DATETIME NOT NULL,
    movie_id INT,
    FOREIGN KEY (movie_id) REFERENCES Movies(id),
    movieRoom_id INT,
    FOREIGN KEY (movieRoom_id) REFERENCES MovieRooms(id)
);

CREATE TABLE IF NOT EXISTS Places(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    number INT NOT NULL,
    status ENUM('Occupé', 'Disponible' ) NOT NULL DEFAULT 'Disponible',
    session_id INT,
    FOREIGN KEY (session_id) REFERENCES Sessions(id)
);

CREATE TABLE IF NOT EXISTS Prices(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    type ENUM('Plein tarif', 'Étudiant', 'Moins de 14 ans') NOT NULL,
    payement ENUM('En ligne', 'Sur place') NOT NULL,
    place_id INT,
    FOREIGN KEY (place_id) REFERENCES Places(id)
);

--Ajout des cinémas
INSERT INTO Cinemas (name, address) VALUES 
    ('Pothé Limoge', '260 Rue Aristide Briand, 87100 Limoges'),
    ('Pothé Valence', '53 Av. de Romans, 26000 Valence');

--Ajout des salles de cinéma
INSERT INTO MovieRooms (name, capacity, cinema_id) VALUES 
    ('Rubis', 40, 1),
    ('Saphir', 60, 1),
    ('Emeraude', 50, 1),
    ('Rubis', 50, 2),
    ('Saphir', 70, 2),
    ('Emeraude', 50, 2);

--Ajout d'une colonne a la table Movies
ALTER TABLE Movies
ADD COLUMN description TEXT;

--Ajout des film disponible en salle
INSERT INTO Movies (title, duration, realiseDate, gender, directedBy, moviePoster, description) VALUES 
    ('Deadpool', '01:48', '2016-02-10', 'Action', 'Tim Miller', 'moviePoster/deadpool.jpg',
    'Deadpool, est l''anti-héros le plus atypique de l''univers Marvel. A l''origine, il 
    s''appelle Wade Wilson : un ancien militaire des Forces Spéciales devenu mercenaire. 
    Après avoir subi une expérimentation hors norme qui va accélérer ses pouvoirs de guérison, 
    il va devenir Deadpool. Armé de ses nouvelles capacités et d''un humour noir survolté, Deadpool 
    va traquer l''homme qui a bien failli anéantir sa vie.'),

    ('RRRrrrr !!!', '01:34', '2004-01-28', 'Humour', 'Alain Chabat', 'moviePoster/rrrrrrr.jpg', 
    'Il y a 37 000 ans, deux tribus voisines vivaient en paix... à un cheveu près. Pendant que la 
    tribu des Cheveux Propres coulait des jours paisibles en gardant pour elle seule le secret de la 
    formule du shampooing, la tribu des Cheveux Sales se lamentait. Son chef décida d''envoyer un 
    espion pour voler la recette. Mais un événement bien plus grave allait bouleverser la vie des 
    Cheveux Propres : pour la première fois dans l''histoire de l''humanité, un crime venait d''être commis'),

    ('Shining', '01:59', '1980-10-16', 'Horreur', 'Stanley Kubrick', 'moviePoster/shining.webp', 
    'Écrivain, Jack Torrance est engagé comme gardien, pendant tout l’hiver, d’un grand hôtel isolé 
    du Colorado, l’Overlook, où il espère surmonter enfin sa panne d’inspiration. Il s’y installe 
    avec sa femme Wendy et son fils Danny, doté d’un don de médium. Tandis que Jack n’avance pas 
    dans son livre et que son fils est de plus en plus hanté par des visions terrifiantes, il 
    découvre les terribles secrets de l’hôtel et bascule peu à peu dans une forme de folie meurtrière'),

    ('Django Unchained', '02:45', '2013-01-16', 'Western', 'Quentin Tarantino', 'moviePoster/django_unchained.jpg',
    'Un esclave noir est affranchi par un chasseur de primes. Le moment est venu de sauver son 
    épouse d''un riche propriétaire de plantation du Mississipi.'),

    ('Parasite', '02:12', '2019-06-05', 'Triller', 'Bong Joon-Ho', 'moviePoster/parasite.png', 
    'Toute la famille de Ki-taek est au chômage, et s’intéresse fortement au train de vie de la 
    richissime famille Park. Un jour, leur fils réussit à se faire recommander pour donner des cours 
    particuliers d’anglais chez les Park. C’est le début d’un engrenage incontrôlable, dont personne 
    ne sortira véritablement indemne…');

--Ajout des sessions
INSERT INTO Sessions (date, movie_id, movieRoom_id) VALUES
    ('2024-05-01 15:00:00', 1, 1),
    ('2024-05-01 17:30:00', 2, 2),
    ('2024-05-01 20:00:00', 3, 1),
    ('2024-05-01 15:15:00', 1, 4),
    ('2024-05-01 18:00:00', 5, 2),
    ('2024-05-01 20:30:00', 2, 3),
    ('2024-05-01 14:00:00', 1, 6),
    ('2024-05-01 17:00:00', 3, 3),
    ('2024-05-01 19:30:00', 4, 4),
    ('2024-05-01 14:00:00', 5, 3);

INSERT INTO Places (number, status, session_id) VALUES
-- Séance 1
    (11, 'Occupé', 1),
    (25, 'Occupé', 1),
    (3, 'Occupé', 1),
    (4, 'Occupé', 1),
    (8, 'Occupé', 1),

-- Séance 2
    (16, 'Occupé', 2),
    (17, 'Occupé', 2),
    (18, 'Occupé', 2),
    (9, 'Occupé', 2),
    (22, 'Occupé', 2),

-- Séance 3
    (11, 'Occupé', 3),
    (12, 'Occupé', 3),
    (32, 'Occupé', 3),
    (4, 'Occupé', 3),
    (5, 'Occupé', 3),

-- Séance 4
    (6, 'Occupé', 4),
    (17, 'Occupé', 4),
    (8, 'Occupé', 4),
    (29, 'Occupé', 4),
    (2, 'Occupé', 4),

-- Séance 5
    (21, 'Occupé', 5),
    (22, 'Occupé', 5),
    (23, 'Occupé', 5),
    (2, 'Occupé', 5),
    (5, 'Occupé', 5),

-- Séance 6
    (21, 'Occupé', 6),
    (22, 'Occupé', 6),
    (14, 'Occupé', 6),
    (16, 'Occupé', 6),
    (30, 'Occupé', 6),

-- Séance 7
    (1, 'Occupé', 7),
    (2, 'Occupé', 7),
    (33, 'Occupé', 7),
    (31, 'Occupé', 7),
    (28, 'Occupé', 7),

-- Séance 8
    (36, 'Occupé', 8),
    (37, 'Occupé', 8),
    (38, 'Occupé', 8),
    (39, 'Occupé', 8),
    (40, 'Occupé', 8),

-- Séance 9
    (11, 'Occupé', 9),
    (22, 'Occupé', 9),
    (33, 'Occupé', 9),
    (40, 'Occupé', 9),
    (35, 'Occupé', 9),

-- Séance 10
    (6, 'Occupé', 10),
    (17, 'Occupé', 10),
    (38, 'Occupé', 10),
    (9, 'Occupé', 10),
    (10, 'Occupé', 10);

INSERT INTO Prices (type, payement, place_id) VALUES
-- Séance 1
    ('Plein tarif', 'En ligne', 1),
    ('Étudiant', 'En ligne', 2),
    ('Moins de 14 ans', 'Sur place', 3),
    ('Plein tarif', 'En ligne', 4),
    ('Étudiant', 'Sur place', 5),

-- Séance 2
    ('Plein tarif', 'En ligne', 6),
    ('Étudiant', 'Sur place', 7),
    ('Moins de 14 ans', 'Sur place', 8),
    ('Plein tarif', 'En ligne', 9),
    ('Étudiant', 'Sur place', 10),

-- Séance 3
    ('Plein tarif', 'Sur place', 11),
    ('Étudiant', 'En ligne', 12),
    ('Moins de 14 ans', 'Sur place', 13),
    ('Plein tarif', 'Sur place', 14),
    ('Étudiant', 'En ligne', 15),

-- Séance 4
    ('Plein tarif', 'Sur place', 16),
    ('Étudiant', 'En ligne', 17),
    ('Moins de 14 ans', 'Sur place', 18),
    ('Plein tarif', 'Sur place', 19),
    ('Étudiant', 'Sur place', 20),

-- Séance 5
    ('Plein tarif', 'En ligne', 21),
    ('Étudiant', 'En ligne', 22),
    ('Moins de 14 ans', 'Sur place', 23),
    ('Plein tarif', 'En ligne', 24),
    ('Étudiant', 'Sur place', 25),

-- Séance 6
    ('Plein tarif', 'En ligne', 26),
    ('Étudiant', 'En ligne', 27),
    ('Moins de 14 ans', 'Sur place', 28),
    ('Plein tarif', 'Sur place', 29),
    ('Étudiant', 'En ligne', 30),

-- Séance 7
    ('Plein tarif', 'Sur place', 31),
    ('Étudiant', 'Sur place', 32),
    ('Moins de 14 ans', 'Sur place', 33),
    ('Plein tarif', 'Sur place', 34),
    ('Étudiant', 'En ligne', 35),

-- Séance 8
    ('Plein tarif', 'Sur place', 36),
    ('Étudiant', 'Sur place', 37),
    ('Moins de 14 ans', 'Sur place', 38),
    ('Plein tarif', 'Sur place', 39),
    ('Étudiant', 'Sur place', 40),

-- Séance 9
    ('Plein tarif', 'Sur place', 41),
    ('Étudiant', 'En ligne', 42),
    ('Moins de 14 ans', 'Sur place', 43),
    ('Plein tarif', 'Sur place', 44),
    ('Étudiant', 'En ligne', 45),

-- Séance 10
    ('Plein tarif', 'Sur place', 46),
    ('Étudiant', 'En ligne', 47),
    ('Moins de 14 ans', 'Sur place', 48),
    ('Plein tarif', 'Sur place', 49),
    ('Étudiant', 'Sur place', 50);

-- Insertion des utilisateur de role USER avec un mot de passe hashé de 256 caractères
INSERT INTO Users (firstName, lastName, email, password, role, cinema_id) VALUES
    ('Gaston', 'Bigman', 'gaston.big@gmail.com', SHA2('gaston', 256), 'User', 1),
    ('Jason', 'Bigman', 'jason.big@gmail.com', SHA2('jason', 256), 'User', 2),
    ('Admin', 'Smith', 'admin.smith@gmail.com', SHA2('admin', 256), 'Admin', NULL);
    