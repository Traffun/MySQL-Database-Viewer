<?php
    $dsn = 'mysql:host=localhost;dbname=mu_db';
    $username = 'root';
    $password = '';
	$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

    try {
        $db = new PDO($dsn, $username, $password,$options);
    } catch (PDOException $e) {
			$error_message = $e->getMessage();
		echo $error_message;
        //include('database_error.php');
        exit();
    }
?>