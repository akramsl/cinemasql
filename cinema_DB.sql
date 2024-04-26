CREATE DATABASE IF NOT EXISTS cinema_DB;

USE cinema_DB;

CREATE TABLE IF NOT EXISTS MovieRooms(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR (250) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Cinemas (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(300) NOT NULL,
    movieRoom_id INT,
    FOREIGN KEY (movieRoom_id) REFERENCES MovieRooms(id)
);

CREATE TABLE IF NOT EXISTS Users (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
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
    movieRoom_id INT,
    FOREIGN KEY (session_id) REFERENCES Sessions(id),
    FOREIGN KEY (movieRoom_id) REFERENCES MovieRooms(id)
);

CREATE TABLE IF NOT EXISTS Prices(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    type ENUM('Plein tarif', 'Étudiant', 'Moins de 14 ans') NOT NULL,
    payement ENUM('En ligne', 'Sur place') NOT NULL
);


INSERT INTO MovieRooms (name, capacity) VALUES
('Rubis', 50),
('Saphir', 60),
('Emeraude', 40);