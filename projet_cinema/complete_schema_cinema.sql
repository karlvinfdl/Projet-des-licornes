-- SCHÉMA COMPLET PROJET CINÉMA - Toutes les entités/tables (phpMyAdmin MAMP)
-- Crée DB + TOUTES tables: Films, Salles, Séances, Réservations, Utilisateurs, Catégories
-- Exécuter dans phpMyAdmin: localhost:8888 → root/root → SQL

DROP DATABASE IF EXISTS `projet_cinema`;
CREATE DATABASE `projet_cinema` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `projet_cinema`;

-- 1. ÉTABLISSEMENTS (Cinémas)
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

-- 3. CATÉGORIES (Genres)
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

-- 5. Liaison FILMS-CATÉGORIES
CREATE TABLE `film_categories` (
  `film_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`film_id`, `category_id`),
  FOREIGN KEY (`film_id`) REFERENCES `films`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
);

-- 6. SÉANCES
CREATE TABLE `seances` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `film_id` INT NOT NULL,
  `salle_id` INT NOT NULL,
  `horaire_debut` DATETIME NOT NULL,
  `prix_base` DECIMAL(6,2) NOT NULL,
  `places_disponibles` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`film_id`) REFERENCES `films`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`salle_id`) REFERENCES `salles`(`id`) ON DELETE RESTRICT,
  INDEX `idx_horaire` (`horaire_debut`)
);

-- 7. UTILISATEURS (Clients/Admins)
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

-- 8. RÉSERVATIONS
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
  FOREIGN KEY (`seance_id`) REFERENCES `seances`(`id`) ON DELETE RESTRICT,
  UNIQUE KEY `unique_user_seance` (`utilisateur_id`, `seance_id`)
);

-- DONNÉES D'EXEMPLE
INSERT INTO `etablissements` (`nom`, `ville`, `nb_salles`) VALUES
('Cinema Unicorn Lyon', 'Lyon', 5),
('Cinema Unicorn Paris', 'Paris', 8);

INSERT INTO `salles` (`etablissement_id`, `nom`, `capacite`, `type_confort`) VALUES
(1, 'Salle 1', 150, 'Standard'),
(1, 'Salle 2', 80, 'IMAX'),
(2, 'Salle A', 200, 'VIP');

INSERT INTO `categories` (`nom`, `couleur`, `icone`) VALUES
('Action', '#FF4444', '💥'),
('Comédie', '#44FF44', '😂'),
('Sci-Fi', '#44AAFF', '🚀');

INSERT INTO `films` (`titre`, `duree_minutes`, `classification`, `affiche_url`, `realisateur`) VALUES
('Avengers Endgame', 181, 'TP', 'avengers.jpg', 'Russos'),
('Unicorn Galaxy', 120, 'TP', 'unicorn.jpg', 'Blackbox');

INSERT INTO `film_categories` (`film_id`, `category_id`) VALUES (1,1), (2,3);

INSERT INTO `seances` (`film_id`, `salle_id`, `horaire_debut`, `prix_base`, `places_disponibles`) VALUES
(1, 1, '2024-12-25 20:00:00', 12.50, 120);

INSERT INTO `utilisateurs` (`nom`, `prenom`, `email`, `mot_de_passe`, `role`) VALUES
('Admin', 'Root', 'admin@cinema.fr', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('Dupont', 'Jean', 'jean@ex.fr', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'client');

INSERT INTO `reservations` (`utilisateur_id`, `seance_id`, `nb_places`, `tarif_total`, `code_reservation`) VALUES
(2, 1, 2, 25.00, 'RES-001');

-- VÉRIFICATION FINALE
SELECT '✅ SCHÉMA COMPLET CRÉÉ! 8 tables + données' AS status;
SHOW TABLES;
SELECT COUNT(*) as nb_tables FROM (SHOW TABLES) as t;

