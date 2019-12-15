function InitWarnNextLevel() {
    const warnerContainer = document.getElementById("warnContainer");
    warnerContainer.style.display = "none";
}

function Warn(message) {
        const warnerContainer = document.getElementById("warnContainer");
        warnerContainer.style.display = "block";
        warnerContainer.innerHTML = "<b>" + message + "</b>"
        setTimeout(() => {
            warnerContainer.style.display = "none";
        }, 3000);
}