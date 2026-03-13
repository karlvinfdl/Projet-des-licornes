-- AJOUT DONNÉES SUPPLÉMENTAIRES projet_cinema
-- Exécute dans phpMyAdmin → DB projet_cinema → SQL
USE `projet_cinema`;

-- +10 FILMS 2024 réalistes
INSERT IGNORE INTO `films` (`titre`, `duree_minutes`, `classification`, `synopsis`, `affiche_url`, `realisateur`) VALUES
('Furiosa: A Mad Max Saga', 158, '-12', 'Préquel Mad Max', 'furiosa.jpg', 'George Miller'),
('Kingdom of Planet of Apes', 145, 'TP', 'Singes évolution', 'planetapes.jpg', 'Wes Ball'),
('Bad Boys Ride or Die', 124, '-12', 'Cops action', 'badboys4.jpg', 'Adil El Arbi'),
('Twisters', 122, 'TP', 'Tempêtes tornades', 'twisters.jpg', 'Lee Isaac Chung'),
('It Ends With Us', 130, 'TP', 'Drame romance', 'itendswithus.jpg', 'Justin Baldoni'),
('Alien Romulus', 118, '-16', 'Horreur espace', 'alienromulus.jpg', 'Fede Alvarez'),
('Beetlejuice Beetlejuice', 105, 'TP', 'Comédie fantôme', 'beetlejuice2.jpg', 'Tim Burton'),
('Transformers One', 104, 'TP', 'Animation robots', 'transformers1.jpg', 'Julien Samani'),
('The Wild Robot', 102, 'TP', 'Robot île', 'wildrobot.jpg', 'Chris Sanders'),
('Smile 2', 132, '-16', 'Horreur sourire', 'smile2.jpg', 'Parker Finn');

-- +20 SÉANCES (janvier 2025)
INSERT IGNORE INTO `seances` (`film_id`, `salle_id`, `horaire_debut`, `prix_base`, `places_disponibles`) VALUES
(21,1,'2025-01-10 20:00:00',15.00,140),
(21,2,'2025-01-10 22:30:00',17.00,75),
(22,3,'2025-01-11 18:00:00',14.50,50),
(23,1,'2025-01-11 16:30:00',12.50,145),
(24,4,'2025-01-12 14:00:00',11.00,185),
(25,5,'2025-01-12 19:30:00',13.50,110),
(26,6,'2025-01-13 21:00:00',16.00,245),
(27,2,'2025-01-13 17:45:00',12.00,80),
(28,1,'2025-01-14 20:15:00',11.50,150),
(29,3,'2025-01-14 16:00:00',10.00,55),
(30,4,'2025-01-15 22:00:00',9.50,190),
(21,5,'2025-01-15 18:30:00',15.00,115),
(22,6,'2025-01-16 20:45:00',14.50,250),
(1,1,'2025-01-16 19:00:00',14.00,160),
(2,2,'2025-01-17 21:30:00',13.50,85),
(3,3,'2025-01-17 15:30:00',10.50,60),
(4,4,'2025-01-18 17:00:00',9.50,195),
(5,5,'2025-01-18 22:15:00',13.00,120),
(6,6,'2025-01-19 20:00:00',15.50,255),
(7,1,'2025-01-19 18:15:00',12.50,165);

-- +5 USERS
INSERT IGNORE INTO `utilisateurs` (`nom`, `prenom`, `email`, `telephone`, `mot_de_passe`, `role`) VALUES
('Roux', 'Louis', 'louis.roux@email.fr', '06 44 55 66 77', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'client'),
('Petit', 'Julie', 'julie.petit@email.fr', '06 33 22 11 00', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'client'),
('Simon', 'David', 'david.simon@email.fr', '06 99 88 77 66', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'client'),
('Bernard', 'Emma', 'emma.bernard@email.fr', '06 77 66 55 44', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('Dubois', 'Thomas', 'thomas.dubois@email.fr', '06 55 44 33 22', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'client');

-- +10 RÉSERVATIONS
INSERT IGNORE INTO `reservations` (`utilisateur_id`, `seance_id`, `nb_places`, `tarif_total`, `statut`, `code_reservation`) VALUES
(6,31,3,45.00,'confirmee','RES005'),
(7,32,2,29.00,'en_attente','RES006'),
(8,33,1,12.50,'confirmee','RES007'),
(9,34,4,50.00,'confirmee','RES008'),
(5,35,2,27.00,'annulee','RES009'),
(2,1,1,14.50,'confirmee','RES010'),
(3,10,3,42.00,'en_attente','RES011'),
(4,20,2,27.00,'confirmee','RES012');

-- VÉRIF
SELECT '✅ + DONNÉES (films/seances/users)!' AS status;
SELECT COUNT(*) as total_films FROM films;
SELECT COUNT(*) as total_seances FROM seances;
SELECT titre FROM films ORDER BY id DESC LIMIT 5;
SELECT f.titre, s.horaire_debut FROM seances s JOIN films f ON s.film_id=f.id LIMIT 5;

