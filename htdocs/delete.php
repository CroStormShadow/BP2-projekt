<?php 
include 'db_connection.php';
$conn = OpenCon();

$id = $_GET['id'];

$stmt = $conn->prepare("DELETE FROM korisnik WHERE korisnik_id = ?");
$stmt->bind_param("s", $id);
$stmt->execute();

echo "<script type='text/javascript'>window.location.replace('http://localhost/ispis_svih.php'); </script>";

CloseCon($conn);
?>