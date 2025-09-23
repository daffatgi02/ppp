$(function(){
    let lobbies = []
    let lobby = {}

    $("#openCreate").click(() => {
        $(".create-lobby").toggle(100)
    })

    $("#searchInput").on("input change", filterList)

    $(".join").click(function() {
        if (String(lobby.password) == String($("#joinPassword").val())){
            $.post(`https://${GetParentResourceName()}/joinLobby`, JSON.stringify(lobby))
            $("body").fadeOut("fast")
            $(".password-wrap").fadeOut("fast")
            $("#joinPassword").val("")
        }else{
            $(".password-wrap").fadeOut("fast")
            $("#joinPassword").val("")
            $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'Lobi', title: "Error", message: "The password you entered is incorrect or the lobby is full!", time: 15000}))
        }
    })

    $(".button").click(function(){
        $.post(`https://${GetParentResourceName()}/ta-lobbys:client:menu-back`)
        $("main").fadeOut(500);
    })

    $(".cancel").click(function() {
        $(".password-wrap").fadeOut("fast")
    })

    function filterList(){
        let filter = $("#searchInput").val().toLowerCase()

        let listItems = $(".lobby");

        listItems.each((_, el) => {
            const $el = $(el)
            const name = $el.find(".lobby-name span")

            if (name.text().toLowerCase().includes(filter)) $el.css("display", "flex")
            else $el.hide()
        })
    }

    window.addEventListener("message", function(event){
        let data = event.data

        switch(data.action){
            case 'openUi':
                lobbies = data.lobbies;
                let text = ""
                $("main").fadeIn(500);
                lobbies.forEach((lobby, i) => {
                    text += `
                    <div class="lobby" data-lobbyid="${i}">
                        <div class="lobby-limit">
                            <div class="title">Players</div>
                            <span>${lobby.players.length}/${lobby.limit}</span>
                        </div>
                        <div class="lobby-name">
                            <div class="title">Lobby Name</div>
                            <span>${lobby.name}</span>
                        </div>
                        <div class="lobby-location">
                            <div class="title">Map</div>
                            <span>${lobby.map}</span>
                        </div>
                        <div class="lobby-mode">
                            <div class="title">Mode</div>
                            <span>${lobby.gameMode}</span>
                        </div>
                        <div class="lobby-damage">
                            <div class="title">Damage</div>
                            <span>${lobby.damageType}</span>
                        </div>
                        <div class="locked-state">
                            <div class="box ${lobby.password ? "locked" : ""}">
                                <svg width="15" height="16" viewBox="0 0 15 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M3.1125 6.94045V5.55422C3.1125 3.03899 5.07685 1 7.5 1C9.92313 1 11.8875 3.03899 11.8875 5.55422V6.94045C12.6121 6.99666 13.084 7.13841 13.4288 7.49647C14 8.08933 14 9.04349 14 10.9518C14 12.8601 14 13.8143 13.4288 14.4071C12.8577 15 11.9385 15 10.1 15H4.9C3.06152 15 2.14228 15 1.57114 14.4071C1 13.8143 1 12.8601 1 10.9518C1 9.04349 1 8.08933 1.57114 7.49647C1.91605 7.13841 2.38791 6.99666 3.1125 6.94045ZM4.0875 5.55422C4.0875 3.59793 5.61533 2.01205 7.5 2.01205C9.38467 2.01205 10.9125 3.59793 10.9125 5.55422V6.90604C10.6635 6.90361 10.3935 6.90361 10.1 6.90361H4.9C4.60652 6.90361 4.33646 6.90361 4.0875 6.90604V5.55422Z" fill="white" stroke="white"/>
                                </svg>
                            </div>
                        </div>
                    </div>`
                });

                $(".lobbies-wrapper").html(text)

                $("body").fadeIn("fast")
                    
                $(".lobby").click(function() {
                    lobby = lobbies[parseInt($(this).data("lobbyid"))]
                    
                    if (lobby.players.length < lobby.limit) {
                        $(".password-wrap").fadeIn("fast")
                    }
                })
            break;
            case 'close':
                $("body").fadeOut(100)
            break;
        }
    })

    let Maps = {}
    $.post(`https://${GetParentResourceName()}/loaded`, function(cfgMaps) {
        Maps = cfgMaps

        Maps.forEach(map => {
            let mapLabel = map.label;
            let mapx = map.x;
            let mapy = map.y;
            let mapz = map.z;
    
            $("#maps").append(`
                <li data-x="${mapx}" data-y="${mapy}" data-z="${mapz}">${mapLabel}</li>
            `)
        });

        $(".dropdown").click(function () {
            $(this).attr("tabindex", 1).focus()
            $(this).toggleClass("active")
            $(this).find(".dropdown-menu").slideToggle(300)
        })
        $(".dropdown").focusout(function () {
            $(this).removeClass("active")
            $(this).find(".dropdown-menu").slideUp(300)
        })
        $(".dropdown .dropdown-menu li").click(function () {
            $(this).parents(".dropdown").find("span").text($(this).text())
            $(this).parents(".dropdown").find("input").attr("value", $(this).text())
            $(this).parents(".dropdown").find("input").attr("data-x", $(this).attr("data-x"))
            $(this).parents(".dropdown").find("input").attr("data-y", $(this).attr("data-y"))
            $(this).parents(".dropdown").find("input").attr("data-z", $(this).attr("data-z"))
        })
    })

    $("#create-lobby").click(function() {
        if ($("#lobbyName").val() == ""  
        || $("#lobbyLimit").val() == "" 
        || $("#damageType input").attr("value") == "" 
        || $("#gameMode input").attr("value") == "" 
        || $("#lobbyMap input").attr("value") == ""
        || $("#lobbyLimit").val() < 2 || $("#lobbyLimit").val() > 20 )
        {$.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'Lobi', title: "Hata", message: "The entered data is empty or incorrect!", time: 15000}))}else{
            let name = $("#lobbyName").val();
            let password = $("#lobbyPassword").val();
            let limit = $("#lobbyLimit").val();
            let damageType = $("#damageType input").attr("value");
            let gameMode = $("#gameMode input").attr("value");
            let map = $("#lobbyMap input").attr("value");
            let x = $("#lobbyMap input").data("x");
            let y = $("#lobbyMap input").data("y");
            let z = $("#lobbyMap input").data("z");

            $.post(`https://${GetParentResourceName()}/createLobby`, JSON.stringify({
                name, password, limit, damageType, gameMode, map, x, y, z
            }), function(success) {
                if (success){
                    $(".create-lobby").fadeOut(100)
                    $("#lobbyName").val("")
                    $("#lobbyPassword").val("")
                    $("#lobbyLimit").val("")
                    $("#damageType input").attr("value", "")
                    $("#gameMode input").attr("value", "")
                    $("#lobbyMap input").attr("value", "")

                    $("#damageType span").text("Select")
                    $("#gameMode span").text("Select")
                    $("#lobbyMap span").text("Select")
                }else{
                    $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'Lobi', title: "Error", message: "Failed create to lobby!", time: 15000}))
                }
            })
        }
    })
})