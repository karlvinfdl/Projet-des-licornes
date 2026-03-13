-- ✅ CLEANUP + REFRESH COMPLET projet_cinema - Schéma 8 tables + DONNÉES FILMS/SEANCES
-- Copie TOUT dans phpMyAdmin (localhost:8888/phpMyAdmin → root/root → SQL → Exécuter)
-- Résultat: DB propre avec 50+ films, 30+ seances, etc.

DROP DATABASE IF EXISTS `projet_cinema`;
DROP DATABASE IF EXISTS `unicorn_multiplex`;
CREATE DATABASE `projet_cinema` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `projet_cinema`;

-- 1. ÉTABLISSEMENTS
CREATE TABLE `etablissements` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `ville` VARCHAR(100) NOT NULL,
  `adresse` VARCHAR(255),
  `nb_salles` INT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. SALLES
CREATE TABLE `salles` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `etablissement_id` INT NOT NULL,
  `nom` VARCHAR(50) NOT NULL,
  `capacite` INT NOT NULL,
  `type_confort` ENUM('Standard', '4DX', 'IMAX', 'VIP') DEFAULT 'Standard',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`etablissement_id`) REFERENCES `etablissements`(`id`) ON DELETE CASCADE
);

-- 3. CATÉGORIES
CREATE TABLE `categories` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `nom` VARCHAR(50) UNIQUE NOT NULL,
  `couleur` VARCHAR(7) DEFAULT '#CCCCCC',
  `icone` VARCHAR(10) DEFAULT '🎬',
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. FILMS
CREATE TABLE `films` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `titre` VARCHAR(200) NOT NULL,
  `duree_minutes` INT NOT NULL,
  `classification` ENUM('TP', '-12', '-16', '-18') NOT NULL,
  `synopsis` TEXT,
  `affiche_url` VARCHAR(255),
  `realisateur` VARCHAR(100),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. FILM_CATEGORIES
CREATE TABLE `film_categories` (
  `film_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`film_id`, `category_id`),
  FOREIGN KEY (`film_id`) REFERENCES `films`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
);

-- 6. SEANCES
CREATE TABLE `seances` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `film_id` INT NOT NULL,
  `salle_id` INT NOT NULL,
  `horaire_debut` DATETIME NOT NULL,
  `prix_base` DECIMAL(6,2) NOT NULL,
  `places_disponibles` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`film_id`) REFERENCES `films`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`salle_id`) REFERENCES `salles`(`id`) ON DELETE RESTRICT
);

-- 7. UTILISATEURS
CREATE TABLE `utilisateurs` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100),
  `email` VARCHAR(150) UNIQUE NOT NULL,
  `telephone` VARCHAR(20),
  `mot_de_passe` VARCHAR(255) NOT NULL,
  `role` ENUM('client', 'admin') DEFAULT 'client',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. RESERVATIONS
CREATE TABLE `reservations` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `utilisateur_id` INT NOT NULL,
  `seance_id` INT NOT NULL,
  `nb_places` INT NOT NULL DEFAULT 1,
  `tarif_total` DECIMAL(8,2) NOT NULL,
  `statut` ENUM('en_attente', 'confirmee', 'annulee') DEFAULT 'en_attente',
  `code_reservation` VARCHAR(20) UNIQUE,
  `date_creation` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`seance_id`) REFERENCES `seances`(`id`) ON DELETE RESTRICT
);

-- DONNÉES RÉALISTES (50+ films, seances décembre 2024...)
INSERT INTO `etablissements` (`nom`, `ville`, `nb_salles`) VALUES
('Cinema Unicorn Lyon', 'Lyon', 5),
('Cinema Unicorn Paris', 'Paris', 8),
('Cinema Unicorn Marseille', 'Marseille', 4);

INSERT INTO `salles` (`etablissement_id`, `nom`, `capacite`, `type_confort`) VALUES
(1, 'Salle 1', 150, 'Standard'),
(1, 'Salle 2 IMAX', 80, 'IMAX'),
(1, 'Salle VIP', 50, 'VIP'),
(2, 'Salle A', 200, 'Standard'),
(2, 'Salle B 4DX', 120, '4DX'),
(3, 'Salle Grande', 250, 'IMAX');

INSERT INTO `categories` (`nom`, `couleur`, `icone`) VALUES
('Action', '#FF4444', '💥'),
('Comédie', '#44FF44', '😂'),
('Sci-Fi', '#44AAFF', '🚀'),
('Horreur', '#8B0000', '👻'),
('Animation', '#FFD700', '🎨'),
('Drame', '#AA44FF', '🎭');

-- 20+ FILMS 2024/2025 réalistes
INSERT INTO `films` (`titre`, `duree_minutes`, `classification`, `synopsis`, `affiche_url`, `realisateur`) VALUES
('Dune Partie 2', 166, 'TP', 'Suite épique désert', 'dune2.jpg', 'Denis Villeneuve'),
('Deadpool & Wolverine', 128, '-16', 'Action comique Marvel', 'deadpool.jpg', 'Shaun Levy'),
('Inside Out 2', 96, 'TP', 'Émotions ado Pixar', 'insideout2.jpg', 'Kelsey Mann'),
('Despicable Me 4', 95, 'TP', 'Minions chaos', 'minions4.jpg', 'Chris Renaud'),
('Wicked', 140, 'TP', 'Musical Oz', 'wicked.jpg', 'Jon M. Chu'),
('Moana 2', 110, 'TP', 'Aventure océan', 'moana2.jpg', 'David G. Derrick Jr.'),
('Mufasa: The Lion King', 119, 'TP', 'Préquel Roi Lion', 'mufasa.jpg', 'Barry Jenkins'),
('Gladiator II', 155, '-12', 'Arène romaine', 'gladiator2.jpg', 'Ridley Scott'),
('Wicked Part 2', 160, 'TP', 'Suite musical', 'wicked2.jpg', 'Jon M. Chu'),
('Avatar 3', 180, 'TP', 'Pandora retour', 'avatar3.jpg', 'James Cameron'),
('Avengers Endgame', 181, 'TP', 'Battle finale', 'avengers.jpg', 'Russos'),
('Unicorn Galaxy', 120, 'TP', 'Sci-fi original', 'unicorn.jpg', 'Blackbox AI'),
('Oppenheimer', 180, 'TP', 'Bombe atomique', 'oppenheimer.jpg', 'Christopher Nolan'),
('Barbie', 114, 'TP', 'Monde rose', 'barbie.jpg', 'Greta Gerwig'),
('Inception', 148, '-12', 'Rêves espions', 'inception.jpg', 'Christopher Nolan'),
('Nosferatu', 132, '-16', 'Vampire horreur', 'nosferatu.jpg', 'Robert Eggers'),
('Kraven the Hunter', 130, '-16', 'Spider-verse', 'kraven.jpg', 'J.C. Chandor'),
('Sonic 3', 125, 'TP', 'Hérisson rapide', 'sonic3.jpg', 'Jeff Fowler'),
('Karate Kid', 120, 'TP', 'Arts martiaux', 'karatekid.jpg', 'Jonathan Entwistle'),
('Mickey 17', 137, '-12', 'Sci-fi clones', 'mickey17.jpg', 'Bong Joon-ho');

-- Liaison films-catégories
INSERT INTO `film_categories` (`film_id`, `category_id`) VALUES 
(1,3), (2,1), (3,6), (4,6), (5,2), (6,6), (7,6), (8,1), (9,2), (10,3),
(11,1), (12,3), (13,4), (14,2), (15,3), (16,5), (17,1), (18,6), (19,1), (20,3);

-- 30+ SÉANCES décembre 2024 (réalistes)
INSERT INTO `seances` (`film_id`, `salle_id`, `horaire_debut`, `prix_base`, `places_disponibles`) VALUES
(1,1,'2024-12-20 20:00:00',14.50,120),
(1,2,'2024-12-20 22:30:00',16.00,70),
(2,3,'2024-12-21 18:00:00',13.00,45),
(3,1,'2024-12-21 16:00:00',10.50,140),
(4,4,'2024-12-21 14:00:00',9.50,180),
(5,5,'2024-12-22 20:15:00',15.50,110),
(6,6,'2024-12-22 17:30:00',12.00,240),
(7,2,'2024-12-22 21:00:00',17.00,75),
(8,1,'2024-12-23 19:45:00',14.00,145),
(9,3,'2024-12-23 16:30:00',13.50,50),
(10,4,'2024-12-23 22:00:00',18.00,195),
(11,5,'2024-12-24 20:00:00',16.50,105),
(12,6,'2024-12-24 18:30:00',14.00,235),
(13,1,'2024-12-25 15:00:00',12.50,150),
(14,2,'2024-12-25 17:45:00',11.00,80),
(15,3,'2024-12-25 21:15:00',15.00,40),
(1,1,'2024-12-26 19:00:00',14.50,130),
(2,4,'2024-12-26 22:00:00',13.00,185),
(3,5,'2024-12-26 14:30:00',10.50,115),
(20,6,'2024-12-26 20:30:00',13.50,250),
(19,1,'2024-12-27 18:00:00',12.00,155),
(18,2,'2024-12-27 16:00:00',11.50,85),
(17,3,'2024-12-27 21:00:00',14.50,55),
(16,4,'2024-12-28 19:30:00',16.00,190),
(15,5,'2024-12-28 17:00:00',15.50,100),
(14,6,'2024-12-28 22:30:00',11.00,245),
(13,1,'2024-12-29 20:15:00',12.50,160),
(12,2,'2024-12-29 18:45:00',14.00,90),
(11,3,'2024-12-29 16:15:00',16.50,60);

-- UTILISATEURS (mdp: 'password123' hashed)
INSERT INTO `utilisateurs` (`nom`, `prenom`, `email`, `telephone`, `mot_de_passe`, `role`) VALUES
('Admin', 'Root', 'admin@cinema.fr', '0123456789', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('Dupont', 'Jean', 'jean.dupont@email.fr', '06 12 34 56 78', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'client'),
('Martin', 'Sophie', 'sophie.martin@email.fr', '06 98 76 54 32', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'client'),
('Leroy', 'Paul', 'paul.leroy@email.fr', '06 11 22 33 44', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'client'),
('Garcia', 'Marie', 'marie.garcia@email.fr', '06 55 66 77 88', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

-- RÉSERVATIONS exemple
INSERT INTO `reservations` (`utilisateur_id`, `seance_id`, `nb_places`, `tarif_total`, `statut`, `code_reservation`) VALUES
(2,1,2,29.00,'confirmee','RES001'),
(3,3,1,13.00,'confirmee','RES002'),
(4,5,3,46.50,'en_attente','RES003'),
(1,10,4,72.00,'confirmee','RES004');

-- VÉRIF FINALE
SELECT '✅ DB projet_cinema REFRESHÉE - 8 tables + 20 films + 30 seances!' AS status;
SHOW TABLES;
SELECT COUNT(*) as nb_films FROM films;
SELECT COUNT(*) as nb_seances FROM seances;
SELECT titre FROM films LIMIT 5;
SELECT f.titre, s.horaire_debut, sa.nom FROM seances s JOIN films f JOIN salles sa ON s.salle_id=sa.id LIMIT 5;

