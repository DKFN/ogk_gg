function updatePlayerBar(level, rank) {

}

function warnNextLevel() {
    const warnerContainer = document.getElementById("warnNextLevel");
    warnerContainer.style.display = "block";
    setTimeout(() => {
        warnerContainer.style.display = "hidden";
    }, 3000);
}