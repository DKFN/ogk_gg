function WarnNextLevel() {
    const warnerContainer = document.getElementById("warnNextLevel");
    warnerContainer.style.display = "block";
    setTimeout(() => {
        warnerContainer.style.display = "none";
    }, 3000);
}