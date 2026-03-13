<?php
// config.php - Projet Cinema MAMP/phpMyAdmin
$host = '127.0.0.1';
$port = '8889'; // MAMP MySQL default
$dbname = 'projet_cinema';
$username = 'root';
$password = 'root'; // MAMP default - change si différent

try {
    $pdo = new PDO("mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    echo "Connexion DB OK!"; // Retirer en prod
} catch(PDOException $e) {
    die("Erreur DB: " . $e->getMessage() . " (Vérifiez MAMP MySQL root/root)");
}
?>

