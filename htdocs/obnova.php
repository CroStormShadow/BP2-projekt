<img onclick="location.href='index.html'" src="slike/home.png" style ="height: 50px; width: 50px;">
<?php
	include 'db_connection.php';
	$conn = OpenCon();
	$id = NULL;
	if(!empty($_GET['id'])){
		$id = $_GET['id'];
	}
	if(isset($_GET["dolasci"])){
		$dolasci = 12;
	}
	else{
		$dolasci = 1000;
	}
	$datum_uclanivanja = date("Y-m-d");
	$datum_uclanivanja = date("\"Y-m-d\"", strtotime("+30 days"));
	
	if($id){
		$sql = "UPDATE clanarina SET uclanjen_do = ".$datum_uclanivanja.", broj_dolazaka = ".$dolasci." WHERE id_korisnika = ".$id."";
		$result = $conn -> query($sql) or die($conn->error);
		
		$result = mysqli_query($conn,$sql);

		if(mysqli_affected_rows($conn) == 0){
			$sql = "INSERT INTO clanarina(id_korisnika,uclanjen_do,broj_dolazaka) VALUES (".$id.",".$datum_uclanivanja.",".$dolasci.")";
			$result = $conn -> query($sql) or die($conn->error);
		}
	}
	
	
	CloseCon($conn);
?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Obnova članarine</title>
</head>
<body>
	<div id = "blok">
		<span style = "padding-left: 2em;" >Unesite broj kartice: </span> <br>
		<form style="padding-left: 2em; margin-top: 0.5em; float:left; width: 100%;" action="/obnova.php" method ="GET">
			<input autofocus type="text" id = "kartica_txtbox" name = "id"  placeholder="xxxxxxxxx">

			<input type = "checkbox" name="dolasci" style = "height: 1.5em; width: 1.5em; vertical-align: middle;" data-on = "12" data-off = "1000"> 12 Dolazaka <br>
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
		input[type=text]{
			width: 50%;
			height:0.8em;
			padding: 20px 20px;
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
