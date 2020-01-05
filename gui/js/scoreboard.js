// Onset Gaming Kommunity -- Gungame
// Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz 

function ServerVersion(servername) {
    document.getElementById("serverAndVersion").innerHTML = '<b>' + servername + '</b>';
}

function RemovePlayers() {
    $('.player').remove();
}



function AddPlayer(name, weapon, kills, deaths, victory) {
    $('#playertable').append('<tr class="player"><td>' + name + '</td><td>' + weapon + '/12</td><td>' + kills + '</td><td>' + deaths + '</td><td>' + victory + '</td></tr>');
}

function PlayerWonGame(winner) {
    const container = document.getElementById("winContainer");
    const text = document.getElementById("winText");
    const splash = $("#ogkggsplash");

    document.getElementById('scoreboardContents').style.display = "none";

    text.innerHTML = "<b><h4 class='is-4'>" + winner + "<h4></b>";

    container.style.opacity = 0;
    container.width = "toggle";
    text.style.fontSize = "64px";
    text.style.fontWeight = "bolder"

    // OGK GG SPLASH DISAPEAR
    setTimeout(() => {
        splash.animate({
            opacity: 0.2
        }, 200);

        setTimeout(() => splash.animate({
            opacity: 0.0
        }, 200), 200)

        setTimeout(() => splash.animate({
            opacity: 0.4
        }, 200), 400)

        setTimeout(() => splash.animate({
            opacity: 0.0
        }, 200), 600)

        setTimeout(() => splash.animate({
            opacity: 0.8
        }, 200), 800)

        setTimeout(() => splash.animate({
            opacity: 0.0
        }, 200), 1000)

        setTimeout(() => splash.animate({
            opacity: 1
        }, 200), 1200)
    }, 100);
    
    

    // Winner Appear
    setTimeout(() => {
        $("#winContainer").animate({
            opacity: 1,
            width: "1000px",
            height: "250px",
        }, 1000);
    }, 1800);

    setTimeout(() => {
        text.innerHTML = '';
        document.getElementById('scoreboardContents').style.display = "block";
        $("#winContainer").animate({
            width: "0px",
            height: "0px",
            opacity: 0
        }, 1000);
    }, 7000);
}
