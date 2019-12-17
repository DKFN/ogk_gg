function ServerVersion(servername) {
    document.getElementById("serverAndVersion").innerHTML = '<b>' + servername + '</b>';
}

function RemovePlayers() {
    $('.player').remove();
}

function AddPlayer(name, weapon, kills, deaths) {
    $('#playertable').append('<tr class="player"><td>' + name + '</td><td>' + weapon + '/4</td><td>' + kills + '</td><td>' + deaths + '</td></tr>');
}

function PlayerWonGame(winner) {
    const container = document.getElementById("winContainer");
    const text = document.getElementById("winText");
    const splash = $("#ogkggsplash");

    text.innerHTML = "<b>" + winner + "</b>";

    container.style.opacity = 0;
    container.width = "toggle";
    text.style.fontSize = "92px";
    text.style.color = "black"
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
            height: "200px",
        }, 1000);
    }, 1800);

    setTimeout(() => {
        text.innerHTML = '';
        $("#winContainer").animate({
            width: "0px",
            height: "0px",
            opacity: 0
        }, 1000);
    }, 7000);
}
