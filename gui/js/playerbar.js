// Onset Gaming Kommunity -- Gungame
// Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz 

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

function RefreshPlayerBar(health, ammo, weapon, weapon_next, mapName, armor) {
    const healthContainer = document.getElementById("health");
    const ammoContainer = document.getElementById("ammo");
    const warnMagazine = document.getElementById("reload-prompt");
    const weaponName = document.getElementById("weaponsName");
    const weaponNext = document.getElementById("weaponsNext");

    const progressBar = document.getElementById("levelProgress");
    progressBar.value = armor;
    document.getElementById("mapName").innerHTML = mapName;
    
    weaponName.innerHTML = weapon;
    weaponNext.innerHTML = weapon_next;
    healthContainer.innerHTML = zeroIsRed(Math.round(health))
    ammoContainer.innerHTML = zeroIsRed(ammo)
}

function ChangePlayerLevel(newLevel) {
    const warnerContainer = document.getElementById("level");
    warnerContainer.innerHTML = zeroIsRed(newLevel);
    
    const animIn = function (){
        warnerContainer.style.padding = "10px";
        warnerContainer.style.backgroundColor = "orange";
    }

    const animOut = function(){
        warnerContainer.style.backgroundColor = "transparent";
    }

    blink(animIn, animOut);
}
