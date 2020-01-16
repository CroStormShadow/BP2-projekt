<script src = "toggle.js"></script>
<img onclick="location.href='index.html'" src="slike/home.png" style ="height: 50px; width: 50px; margin-bottom: 5em;">

<div id="kartica_unos">
	<input id = "unos" style = "width: 25.7%;" name = "id" autofocus type="text" onkeyup ="search()" placeholder="Pretražite po imenu ili prezimenu">
</div>

<?php
include 'db_connection.php';
$conn = OpenCon();
	
$sql = "SELECT * FROM korisnik";
$result = $conn -> query($sql);


echo "<br>";
echo "<table id = 'tablica' border='1'>";
 ?>
	<tr>
		<th>ID Korisnika</th>
		<th>Ime</th>
		<th>Prezime</th>
		<th>Dob</th>
		<th>Datum učlanivanja</th>
	</tr>
<?php
while($row = $result->fetch_assoc()) {
	echo "<tr>";
	foreach($row as $value){
		echo "<td class = 'kljuc'>" . $value . "</td>";	
	}
	echo "<td><a href='http://localhost/evidencija.php?id={$row['korisnik_id']}'><img src = 'slike/info.png' style = 'height: 20px; width: 20px; padding: 2px;'></a></td>";
	echo "<td><a href = 'http://localhost/delete.php?id={$row['korisnik_id']}'><img src = 'slike/delete.png' style = 'height: 20px; width: 20px; padding: 2px;'></a></td>";
	echo "</tr>";
}
echo "</table>";

CloseCon($conn);
?>