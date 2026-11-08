<?php
// database connection
// MAMP uses port 8889 and password root, WAMP uses 3306 and no password

$conn = @mysqli_connect("127.0.0.1", "root", "root", "black_hole", 8889);

if (!$conn) {
    $conn = mysqli_connect("127.0.0.1", "root", "", "black_hole", 3306);
}

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
?>
