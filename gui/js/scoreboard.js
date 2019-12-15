function ServerVersion(servername) {
    document.getElementById("serverAndVersion").innerHTML = '<b>' + servername + '</b>';
}

function RemovePlayers() {
    $('.player').remove();
}

function AddPlayer(name, weapon, kills, deaths) {
    $('#playertable').append('<tr class="player"><td>' + name + '</td><td>' + weapon + '/4</td><td>' + kills + '</td><td>' + deaths + '</td></tr>');
}