<meta charset="UTF-8">
<title>Termini</title>
<img onclick="location.href='index.html'" src="slike/home.png" style ="height: 50px; width: 50px;">
<?php
	include 'db_connection.php';
	$conn = OpenCon();

	$sql = "SELECT CONCAT(t1.ime, ' ', t1.prezime) AS 'id_korisnika', CONCAT(t2.ime, ' ', t2.prezime) AS 'id_trenera', t3.naziv AS 'id_teretane', vrijeme AS 'vrijeme', vrsta_termina AS 'vrsta_termina' FROM termin INNER JOIN korisnik as t1 INNER JOIN trener AS t2 INNER JOIN teretana AS t3 WHERE id_korisnika = t1.korisnik_id AND id_trenera = t2.trener_id AND id_teretane = t3.teretana_id";
	$result = $conn -> query($sql);


	echo "<br>";
	echo "<table id = 'tablica' border='1'>";
 ?>
	<tr>
		<th>Naziv Teretane</th>
		<th>Ime Korisnika</th>
		<th>Ime Trenera</th>
		<th>Vrijeme</th>
		<th>Vrsta termina</th>
	</tr>
<?php
while($row = $result->fetch_assoc()) {
	echo "<tr>";

		
		echo "<td style = 'padding: 0px 5px 0px'>" . $row['id_teretane'] . "</td>";	
		echo "<td style = 'padding: 0px 5px 0px'>" . $row['id_korisnika'] . "</td>";	
		echo "<td style = 'padding: 0px 5px 0px'>" . $row['id_trenera'] . "</td>";	
		echo "<td style = 'padding: 0px 5px 0px'>" . $row['vrijeme'] . "</td>";	
		echo "<td style = 'padding: 0px 5px 0px'>" . $row['vrsta_termina'] . "</td>";	

	echo "</tr>";
}
	echo "</table>";
	CloseCon($conn);
?>




