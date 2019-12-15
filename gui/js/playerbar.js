function InitWarnNextLevel() {
    const warnerContainer = document.getElementById("warnContainer");
    warnerContainer.style.display = "none";
}

function WarnNextLevel() {
    const warnerContainer = document.getElementById("warnContainer");
    warnerContainer.style.display = "block";
    setTimeout(() => {
        warnerContainer.style.display = "none";
    }, 3000);
}