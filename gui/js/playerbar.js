function blink(animIn, animOut) {
    animIn();
    setTimeout(animOut, 200);
    setTimeout(animIn, 400);
    setTimeout(animOut, 600);
    setTimeout(animIn, 800);
    setTimeout(animOut, 1000);
    setTimeout(animIn, 1200);
    setTimeout(animOut, 1400);
    setTimeout(animIn, 1600);
    setTimeout(animOut, 1800);
}

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

const zeroIsRed = (num) => num === 0 
    ? '<b style="color: red">' + num + "</b>"
    : "<b>" + num + "</b>";

function RefreshPlayerBar(health, ammo, weapon, weapon_next) {
    const healthContainer = document.getElementById("health");
    const ammoContainer = document.getElementById("ammo");
    const warnMagazine = document.getElementById("reload-prompt");
    const weaponName = document.getElementById("weaponsName");
    const weaponNext = document.getElementById("weaponsNext");

    if (ammo === 0) {
        warnMagazine.style.display = "block";
    } else {
        warnMagazine.style.display = "none";
    }

    weaponName.innerHTML = weapon;
    weaponNext.innerHTML = weapon_next;
    healthContainer.innerHTML = zeroIsRed(Math.round(health))
    ammoContainer.innerHTML = zeroIsRed(ammo)
}

function ChangePlayerLevel(newLevel) {
    const warnerContainer = document.getElementById("level");
    const progressBar = document.getElementById("levelProgress");

    const animIn = () => {
        warnerContainer.style.padding = "10px";
        warnerContainer.style.backgroundColor = "orange";
    }

    const animOut = () => {
        warnerContainer.style.backgroundColor = "transparent";
    };


    progressBar.value = newLevel;
    warnerContainer.innerHTML = zeroIsRed(newLevel)
    blink(animIn, animOut);
}
