function DisplayHit(hitLocation) {
    $("#"+hitLocation+"-hit-marker").fadeIn(200);
    setTimeout(function() {
        $("#"+hitLocation+"-hit-marker").fadeOut(300);
    }, 1000);
}
