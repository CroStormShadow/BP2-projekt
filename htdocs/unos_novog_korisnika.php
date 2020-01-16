<img onclick="location.href='index.html'" src="slike/home.png" style ="height: 50px; width: 50px; margin-bottom: 5em;">
<?php
include 'db_connection.php';
$conn = OpenCon();

$ime = $_POST['ime'];
$prezime = $_POST['prezime'];
$dob = $_POST['dob'];
$datum_uclanivanja = $_POST['datum_uclanivanja'];
if(isset($_POST["dolasci"])){
	$dolasci = 12;
}
else{
	$dolasci = 1000;
}

$stmt = $conn->prepare("INSERT INTO korisnik (ime,prezime,dob,datum_uclanivanja) VALUES(?,?,?,?)");
$stmt->bind_param("ssss", $ime , $prezime, $dob, $datum_uclanivanja);

if($stmt->execute() == TRUE){
	echo " ". $ime . " dodan u bazu <br>";
}
else{
	echo "Error: " . $sql . "<br>" . $conn->error;
}

$sql = "SELECT MAX(korisnik_id) AS korisnik_id FROM korisnik";
$result = $conn->query($sql);
$row = $result->fetch_assoc();

$id = $row['korisnik_id'];
$datum_uclanivanja = date("Y-m-d", strtotime("+30 days"));

$stmt = $conn->prepare("INSERT INTO clanarina (id_korisnika,uclanjen_do,broj_dolazaka) VALUES(?,?,?)");
$stmt->bind_param("sss", $id , $datum_uclanivanja, $dolasci);
$stmt -> execute();
$stmt->close();
CloseCon($conn);
?>