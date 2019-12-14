function Testing(servername) {
    document.getElementById("serverAndVersion").innerHTML = servername;
}

function RemovePlayers() {
    $('.player').remove();
}

function AddPlayer(name, weapon, kills, deaths) {
    $('#playertable').append('<tr class="player"><td>' + name + '</td><td>' + weapon + '/4</td><td>' + kills + '</td><td>' + deaths + '</td></tr>');
}