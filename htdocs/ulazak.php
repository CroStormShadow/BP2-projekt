<script src='toggle.js'></script>
<?php
include 'db_connection.php';
$conn = OpenCon();

$id = $_POST['id'];
$stmt = $conn->prepare("SELECT uclanjen_do, broj_dolazaka FROM clanarina WHERE id_korisnika = ?");
$stmt->bind_param("s", $id);


if($stmt->execute() == TRUE){
	$result = $stmt->get_result();
	if($row = $result->fetch_assoc()){
		$uclanjen_do = $row['uclanjen_do'];
		$broj_dolazaka = $row['broj_dolazaka'];
		echo " Članarina vrijedi do: ". $uclanjen_do . ", ostalo je još: ". $broj_dolazaka . " dolazaka <br>";
		
		if($uclanjen_do > date("Y-m-d") && $broj_dolazaka > 0){
			$broj_dolazaka--;
			$stmt = $conn->prepare("UPDATE clanarina SET broj_dolazaka = ? WHERE id_korisnika = ?" );
			$stmt->bind_param("ss", $broj_dolazaka, $id);
			$stmt->execute();
			echo "<script>	confirmed();	</script>";
		}
		else{
			echo "<script>	denied();	</script>";
		}
	}
	
	else{
		echo "<script>	nepostoji(); </script>";
	}
}
else{
	echo "Error: " . $sql . "<br>" . $conn->error;
}
$stmt->close();
CloseCon($conn);
?>