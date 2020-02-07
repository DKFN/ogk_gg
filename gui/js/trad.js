const GAMEMODE_LANG = "FR"
let TRAD = {}

function makeTraductions() {
    TRAD["FR"] = {
        // HUD
        health: "VIE",
        ammo: "MUN.",
        level: "NIVEAU",
        armor: "Armure",
        curr_wpn: "Arme",
        nxt_wpn: "Prochaine",

        // MOTD
        motd_title: "Bienvenue sur GunGame 0.4",
        motd_how2play: "Comment Jouer ?",
        motd_content_line_1: "Tuer un joueur pour avoir une meilleure arme",
        motd_content_line_2: "Soyez le premier a tuer un joueur avec la derniere arme pour gagner",
        motd_content_line_3: "Recuperez des boosts sur la carte pour recuperer de la vie ou de l'armure",
        motd_hfgl: "Have fun and good luck",
        motd_join: "JOIN GAME",

        // SCOREBOARD
        scoreboard: "SCORE BOARD",
        scoreboard_won: "WON THE GAME",
        scoreboard_login: "NAME",
        scoreboard_level: "LEVEL",
        scoreboard_kills: "KILLS",
        scoreboard_death: "DEATHS",
        scoreboard_victories: "VICTORY",

        scoreboard_submit: "Submit your",
        scoreboard_report: "Please report any",
        scoreboard_say: "Come say",
        scoreboard_suggestions: "suggestions",
        scoreboard_maps: "maps",
        scoreboard_bugs: "bugs",
        scoreboard_cheaters: "cheaters",
        scoreboard_hello: "hello",
        scoreboard_in_discord: "In the Discord server",
        scoreboard_hfgl: "Have fun and good luck",

        scoreboard_discord: "Join Our Discord",
        scoreboard_discord_link: "https://discord.gg/TjmEANe",

        scoreboard_external_constributors: "External contributions",

        // VOTEMAP
        votemap: "Votemap",
        votemap_available: "Available maps",
        votemap_unavailable: "Available maps",
        
        // UI LEADER BOARD
        leaderboard_level: "Level"
    }

    const EN = "EN"
    // HUD
    TRAD[EN] = {
        // HUD
        health: "HEALTH",
        ammo: "ammo",
        level: "LEVEL",
        armor: "Armor",
        curr_wpn: "Curent weapon",
        nxt_wpn: "Next weapon",

        // MOTD
        motd_title: "Bienvenue sur GunGame 0.4",
        motd_how2play: "Comment Jouer ?",
        motd_content_line_1: "Kill a player to get a better weapon",
        motd_content_line_2: "Be the first to kill a player with the last weapon to win",
        motd_content_line_3: "Pick up boosts on the map to increase your survival time",
        motd_hlgf: "Have fun and good luck",
        motd_join: "JOIN GAME",

        // SCOREBOARD
        scoreboard_won: "WON THE GAME",
        scoreboard_login: "NAME",
        scoreboard_level: "LEVEL",
        scoreboard_kills: "KILLS",
        scoreboard_death: "DEATHS",
        scoreboard_victories: "VICTORY",

        scoreboard_submit: "Submit your",
        scoreboard_report: "Please report any",
        scoreboard_say: "Come say",
        scoreboard_suggestions: "suggestions",
        scoreboard_maps: "maps",
        scoreboard_bugs: "bugs",
        scoreboard_cheaters: "cheaters",
        scoreboard_hello: "hello",
        scoreboard_in_discord: "In the Discord server",
        scoreboard_hfgl: "Have fun and good luck",

        scoreboard_discord: "Join Our Discord",
        scoreboard_discord_link: "https://discord.gg/TjmEANe",

        scoreboard_external_constributors: "External contributions",

        // VOTEMAP
        votemap: "Votemap",
        votemap_available: "Available maps",
        votemap_unavailable: "Available maps",
    }
    
}

function tradKey(key) {
    return TRAD[GAMEMODE_LANG][key] || TRAD["EN"][key] || key;
}

document.addEventListener('DOMContentLoaded', () => {
    const allTraductionNodes = document.querySelectorAll('[data-trad]');
    allTraductionNodes.forEach((element) => {
        const jqElement = $(element);
        jqElement.text(tradKey(jqElement.data("trad")));
    })
}, false);

makeTraductions();
