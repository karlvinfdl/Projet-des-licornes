<?php
// config_mamp.php - For MAMP phpMyAdmin (port 8889)
$host = '127.0.0.1:8889';
$dbname = 'projet_cinema';
$username = 'root';
$password = 'root'; // MAMP default - change if different

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    echo "Connexion MAMP DB OK!";
} catch(PDOException $e) {
    die("Erreur DB MAMP: " . $e->getMessage());
}
?>

