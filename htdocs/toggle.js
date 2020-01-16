function toggleUnos(){
	if(document.getElementById('kartica_unos').style.display == "none"){
		document.getElementById('kartica_unos').style.display = "block";		
		document.getElementById('kartica_txtbox').focus();		

	}
	else{
		document.getElementById('kartica_unos').style.display = "none";
	}	
}

var confirmedSound = new Audio("/sounds/confirmed.wav");
var deniedSound = new Audio("/sounds/denied.mp3");

function confirmed(){
	confirmedSound.play();
	confirmedSound.onended = function(){
		window.location.replace('index.html');
	}
}
function denied(){
	deniedSound.play();
	deniedSound.onended = function(){
		window.location.replace('index.html');
		alert("Obnoviti članarinu!");
	}
}
function nepostoji(){
	window.location.replace('index.html');
	alert("Taj korisnik ne postoji!");
}

function search(){
	var input, filter, table, tr, td, i, txtValue, txtValue2;
	unos = document.getElementById("unos");
	filter = unos.value.toUpperCase();
	table = document.getElementById("tablica");
	tr = table.getElementsByTagName("tr");
	
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td")[1];
		td2 = tr[i].getElementsByTagName("td")[2];

		if (td) {
			txtValue = td.textContent || td.innerText;
			txtValue2 = td2.textContent || td2.innerText;

			if (txtValue.toUpperCase().indexOf(filter) > -1 || txtValue2.toUpperCase().indexOf(filter) > -1) {
				tr[i].style.display = "";
			} else {
				tr[i].style.display = "none";
			}
		}
		
	}
}
function truncate(){
	var sigurno = prompt("Sigurno želite obrisati sve iz tablice?");
	if(sigurno != null){
		return 1;
	}
	else{
		return 0;
	}
}