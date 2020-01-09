// Onset Gaming Kommunity -- Gungame
// Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz 

/**
 * This is the killfeed script
 * 
 * Author: OGK (DKFN)
 */
// https://wiki.garrysmod.com/page/CS:S_Kill_Icons
const weaponCharTable = {
    // TODO: Complete
    '0': 'C',
    undefined: 'C',
    'nil': 'C'

};

 const killTemplate = (killRow) => `
    <div class="killfeed-row" id="kf_${killRow.timeOfEntry}">
        <div class="killfeed-instigator">
            ${killRow.instigator}
        </div>
        <div class="killfeed-weapon">
            ${killRow.weapon}
        </div>
        <div class="killfeed-victim">
            ${killRow.victim}
        </div>
    </div>
 `;

const ROW_TIME_TO_LIVE = 4000;
const CLEANER_REFRESH_RATE = 500;

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
            weapon: weaponCharTable[weapon] || 'D',
            timeOfEntry: Date.now()
        };

        this.killFeedEntries.push(killrow);

        const killHtml = killTemplate(killrow);
        this.killFeedUI.innerHTML = this.killFeedUI.innerHTML + killHtml;
    }

    cleaner(_this) {
        return () => {
            _this.killFeedEntries.forEach((kfe, i) => {
                const expired = kfe.timeOfEntry + ROW_TIME_TO_LIVE < Date.now();
                if (expired) {
                    document.getElementById(`kf_${kfe.timeOfEntry}`).outerHTML = "";
                    delete _this.killFeedEntries[i];
                }
            });
        }
    }
 }

 const killFeedInstance = new KillFeed();

 // Attaching public functions so Onset can call Them 
 window.killfeed = killFeedInstance;

