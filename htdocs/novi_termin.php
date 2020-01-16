<img onclick="location.href='index.html'" src="slike/home.png" style ="height: 50px; width: 50px;">
<html>
	<title>Novi termin</title>
<body>
<?php

include 'db_connection.php';
$conn = OpenCon();

$id = NULL;
	$teretana_id = NULL;
	if(isset($_GET['teretana_id'])){
		$teretana_id = $_GET['teretana_id'];
		$korisnik_id = $_GET['korisnik_id'];
		$trener_id = $_GET['trener_id'];
		$vrijeme = strtr ($_GET['vrijeme'] , "T" , " " );
		$vrsta_termina = $_GET['vrsta_termina'];
	}
	if(!is_null($teretana_id)){
		$stmt = $conn->prepare("INSERT INTO termin VALUES(DEFAULT,?,?,?,?,?)");
		$stmt->bind_param("sssss", $teretana_id, $korisnik_id, $trener_id, $vrijeme, $vrsta_termina);
		$stmt->execute();
		$stmt->close();	
	}
?>
<div id = "blok">
		<span style = "padding-left: 2em;" >Odaberite teretanu: </span>
		<form style="padding-left: 2em; float:left; width: 100%;" action="/novi_termin.php" method ="GET">
		
			
			<?php
				$sql = "SELECT teretana_id, naziv FROM teretana";
				$result = $conn->query($sql);
				echo "<select name='teretana_id' style = 'margin: 0.6em 0 1em;'>";
				while($row = $result->fetch_assoc()){
					$id = $row['teretana_id'];
					$name = $row['naziv']; 
					echo "<option value='".$id."'>".$name."</option>";
                }
				echo "</select> <br>";
			?>
			Odaberite trenera:<br> 
			<?php
				$sql = "SELECT trener_id, CONCAT(ime, ' ', prezime) AS ime FROM trener";
				$result = $conn->query($sql);
				echo "<select name='trener_id' style = 'margin: 0.6em 0 1em;'>";
				while($row = $result->fetch_assoc()){
					$id = $row['trener_id'];
					$name = $row['ime']; 
					echo "<option value='".$id."'>".$name."</option>";
                }
				echo "</select> <br>";
			?>
			Odaberite korisnika:<br> 
			<?php
				$sql = "SELECT korisnik_id, CONCAT(ime, ' ', prezime) AS ime FROM korisnik";
				$result = $conn->query($sql);
				echo "<select name='korisnik_id' style = 'margin: 0.6em 0 1em;'>";
				while($row = $result->fetch_assoc()){
					$id = $row['korisnik_id'];
					$name = $row['ime']; 
					echo "<option value='".$id."'>".$name."</option>";
                }
				echo "</select> <br>";
			?>
			Odaberite vrijeme termina: <br>
			<input type = "datetime-local" name = "vrijeme" style = 'margin: 0.6em 0 1em;'><br>
			Upišite vrstu treninga: <br>
			<input type = "textbox" name = "vrsta_termina" style = 'margin: 0.6em 0 1em;'>
			<input type = "submit" id = "submit">
		</form>
	</div>
	
	<style>
		#blok{
			background-color: #cccccc;
			height: 40em;
			padding-top: 2em;
			margin-top: 2.9em;
			margin-left: 5em;
			margin-right: 60%;
		}
		select, input[type=datetime-local],input[type=textbox]{
			width: 50%;
			height:2em;
			display: inline-block;
			box-sizing: border-box;

			font-size: 16px;
			outline: none;
			border: none;
			border-bottom: 1px solid darkgrey;
		}
		#submit {
			background-color: #4CAF50;
			color: white;
			padding: 1.5em 20px;
			margin: 3em 0;
			border: none;
			cursor: pointer;
			width: 80%;	
		}
	</style>
</body>
</html>
<?php
	CloseCon($conn);
?>