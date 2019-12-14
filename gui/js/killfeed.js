/**
 * This is the killfeed script
 * 
 * Author: OGK (DKFN)
 */

 const killTemplate = (killRow) => `
    <div class="killfeed-row" id="kf_${killRow.timeOfEntry}">
        <div class="killfeed-instigator">
            ${killRow.instigator}
        </div>
        <div class="killfeed-weapon">
            [${killRow.weapon}]
        </div>
        <div class="killfeed-victim">
            ${killRow.victim}
        </div>
    </div>
 `;

const ROW_TIME_TO_LIVE = 4000;
const CLEANER_REFRESH_RATE = 150;

class KillFeed {
    constructor() {
         // {instigator: string, victim: string, weapon: string, timeOfEntry: number}
        this.killFeedEntries = [];
        this.cleanerTimer = setInterval(this.cleaner(this), CLEANER_REFRESH_RATE); // Contains the timer that cleans the killfeed periodically
        this.killFeedUI = document.getElementById("killfeed");
        this.cleaner = this.cleaner.bind(this); // Document with the killfeed ui
    }

    registerKill(playerName, victim, weapon) {
        const killrow = {
            instigator: playerName,
            victim: victim,
            weapon: weapon,
            timeOfEntry: Date.now()
        };

        this.killFeedEntries.push(killrow);

        const killHtml = killTemplate(killrow);
        this.killFeedUI.innerHTML = this.killFeedUI.innerHTML + killHtml;
    }

    cleaner(_this) {
        return () => {
            _this.killFeedEntries.forEach(kfe => {
                if (kfe.timeOfEntry + ROW_TIME_TO_LIVE < Date.now()) {
                    document.getElementById(`kf_${kfe.timeOfEntry}`).innerHTML = "";
                }
            });
        }
    }
 }

 const killFeedInstance = new KillFeed();

 /**
  * The code below is the code used to simulate the behavior of the gamemode
  */
 const fakeKills = [
    ["Deadly", "MP5", "Souidiere"],
    ["Katz", "AK-47", "Test"],
    ["Katz", "KNIFE", "Dogz"],
    ["Inteus", "HR", "Wizard"],
    ["KATSU", "ROCKET LAUNCHER", "GREEN HOUSE"]
];

 const fakeEvents = setInterval(() => {
     const e = fakeKills[Math.round(Math.random() * fakeKills.length - 1)];
     killFeedInstance.registerKill(e[0], e[2], e[1])
 }, 860)

 // Attaching public functions so Onset can call Them 

 window.killfeed = killFeedInstance;

