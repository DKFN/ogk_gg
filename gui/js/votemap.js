// Onset Gaming Kommunity -- Gungame
// Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz 
let maps = [];
let votes = [];

const buildMap = (map, container) => {
    const mapImage = "http://asset/ogk_gg/gui/images/maps/"+map.name+".jpg";
    const locked = map.available ? '' : 'locked';

    const callBack = map.available ? () => {
        $(`#map-${map.name}`).addClass('active')
        ue.game.callevent("VoteForMap", '["' + map.name + '"]');
    } : () => {};

    container.append(`
        <div class="map-item ${locked}" id="map-${map.name}">
            <div class="map-image" style="background-image: url('${mapImage}');">
                <span id="map-${map.name}-votes">0</span>
            </div>
            <div class="map-name">
                ${map.name.toUpperCase()}
            </div>
            <div class="map-author">
                By ${map.author.toUpperCase()}
            </div>
        </div>
    `);

    $(`#map-${map.name}`).click(callBack);
};

function ReceiveVotemapData(data) {
    maps = JSON.parse(data);
    $(document).ready(() => {
        const mapContainer = $("#availableMaps");
        const illegalMapsContainer = $("#illegalMaps");
        mapContainer.empty();
        illegalMapsContainer.empty();

        const legalMaps = maps.filter(map => map.available);
        const illegalMaps = maps.filter(map => !map.available);

        legalMaps.forEach(mapData => {
            buildMap(mapData, mapContainer);
        });

        illegalMaps.forEach(mapData => {
            buildMap(mapData, illegalMapsContainer);
        });
    });
}

function ReceiveVotesData(votesData) {
    votes = JSON.parse(votesData);

    $(document).ready(() => {
        let counts = [];
        votes.forEach(m => {
            counts[m] = counts[m] || 0;
            ++counts[m];
        });

        [...maps.map(m => m.name)].forEach(m => {
            $(`#map-${m}-votes`).text(counts[m] || 0);
        });
    });
}

// Counter
$(document).ready(() => {
    let counterVal = 1;
    const counterContainer = $("#votemapProgress")
    setInterval(() => {
        counterContainer.val(counterVal + 1)
        ++counterVal;
    }, 1000);
});
