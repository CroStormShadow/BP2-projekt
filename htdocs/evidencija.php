<div>
	<img onclick="location.href='index.html'" src="slike/home.png" style ="height: 50px; width: 50px; margin-bottom: 5em;">
	<img onclick="location.href='http://localhost/ispis_svih.php'" src="slike/back.png" style ="height: 50px; width: 50px; margin-bottom: 5em;">

	
</div>
<?php 
include 'db_connection.php';
$conn = OpenCon();

$id = $_GET['id'];

$sql = "SELECT ime, prezime FROM korisnik WHERE korisnik_id = ".$id."";
$result = $conn->query($sql) or die($conn->error);
if($row = $result->fetch_assoc()){
	echo "<h2>".$row['ime']." ".$row['prezime']."";
}
$sql = "SELECT uclanjen_do FROM clanarina WHERE id_korisnika = ".$id."";
$result = $conn -> query($sql);
if (mysqli_num_rows($result)>0) {  
	$row = $result -> fetch_assoc();
	echo " učlanjen do: " . $row['uclanjen_do'] . "</h2>";	
}
else{
		echo ": korisnik trenutno nije učlanjen </h2><br>";
	}

$sql = "SELECT datum_mjerenja, visina, tezina FROM evidencija WHERE id_korisnika = ".$id."";
$result = $conn -> query($sql);

if ($result=mysqli_query($conn,$sql)){
	if (mysqli_num_rows($result)>0) {  
		echo "<table border='1' style='float:left; margin-right:2em;'>";
		?>
			<tr><th colspan = 3> Evidencija </th></tr>
			<tr>
				<th>Datum mjerenja</th>
				<th>Visina</th>
				<th>Tezina</th>
			</tr>
		<?php
		
		while($row = $result->fetch_assoc()) {
			echo "<tr>";
			foreach($row as $value){
				echo "<td>" . $value . "</td>";	
			}
			echo "</tr>";
		}
		echo "</table>";
	}
	
	else{
		echo "Ovaj korisnik nema evidentiranih podataka <br>";
	}
}
CloseCon($conn);
?>