<?php
include "db.php";

$result = mysqli_query($conn, "SELECT * FROM planets ORDER BY scroll_order");
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Black Hole</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="navbar">
    <a href="index.php" class="logo">Black Hole</a>
    <a href="index.php">Home</a>
    <a href="#">Shop</a>
    <a href="#">Cart</a>
</div>

<h1>Black Hole</h1>
<p class="subtitle">Souvenirs from the Solar System</p>

<!-- TODO: planets should spin when scrolling -->
<h2>Planets</h2>

<?php while ($planet = mysqli_fetch_assoc($result)) { ?>
    <div class="planet">
        <h3><?php echo $planet['name']; ?></h3>
        <p><?php echo $planet['description']; ?></p>
        <p>Moons: <?php echo $planet['moons_count']; ?></p>
        <a href="#">Shop now</a>
    </div>
<?php } ?>

<p class="footer">Black Hole 2026 - site in progress</p>

</body>
</html>
