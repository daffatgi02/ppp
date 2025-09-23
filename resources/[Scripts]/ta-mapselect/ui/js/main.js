$(function () {
    let maps = []
    let selectedMap
    let waitTime = 30

    function startTimer() {
        let total = waitTime

        let interval = setInterval(() => {
            if (total < 0) {
                clearInterval(interval) 
                
                $("body").fadeOut("slow")

                return
            }

            total--
            $(".title").text("SELECT NEXT MAP (" + total + ")")
        }, 1000)
    }

    $.post(`https://${GetParentResourceName()}/loaded`, function(cfg) {
        maps = cfg.Maps
        waitTime = cfg.WaitTime
    })

    window.addEventListener("message", function (event){
        const action = event.data.action;

        switch(action){
            case "startSelection":
                selectedMap = null

                startTimer()

                $(".map-wrapper").html('')

                maps.filter(map => map.bucket == event.data.bucket).forEach(map => {
                    let mapName = map.name;
                    let mapTitle = map.label;

                    $(".map-wrapper").append(`
                    <div class="map" id="${mapName}">
                        <div class="map-name">${mapTitle}</div>
                        <div class="counter">0</div>
                        <img src="assets/maps/${mapName}.png" class="map-img" />
                        <div class="selected">
                            <span>SELECTED</span>
                            <img src="assets/icon.png" />
                        </div>
                    </div>
                    `)
                })

                $(".map").click(function(){
                    const mapName = $(this).attr("id")

                    if (selectedMap && selectedMap == mapName) return

                    selectedMap = mapName

                    $(".map").removeClass("active")
                    $(this).addClass("active")

                    $.post(`https://${GetParentResourceName()}/mapSelected`, JSON.stringify(mapName ))
                })
                
                $("body").fadeIn("fast")

                break
    
            case "updateMap":
                $(`#${event.data.mapName} .counter`).text(event.data.mapCount);

                break
        }
    })
})