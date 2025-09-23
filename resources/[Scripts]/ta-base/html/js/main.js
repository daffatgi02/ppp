let main_page = false
let gamemodes_ui = false;
let privlobbys_ui = false;
let market_ui = false;
let matchmaking_ui = false;
let settings_ui = false;
let crew_ui = false;
let leaderboard_ui = false;
let store_ui = false;
let help_menu = false;
let tikladi = false;
let editingHud = false

let default_damaged_ui = false
let custom_damaged_ui = false
let advanced_ui = false

playerSettings = {}

const objClone = (obj) => JSON.parse(JSON.stringify(obj))

const defaultSettings = {
    killfeed: "on",
    killed: "on",
    hitsound: "on",
    damage: "on",
    deathscreen: "on",
    hud: "on",
    crosshair: "on",
}

$(function() {
    loadSettings(localStorage.getItem("taSettings") ? JSON.parse(localStorage.getItem("taSettings")) : defaultSettings)

    function saveSettings(){
        playerSettings.killfeed = $("#show-killfeed").is(":checked") ? "on" : "off";
        playerSettings.killed = $("#show-killed").is(":checked") ? "on" : "off";
        playerSettings.hitsound = $("#show-hitsound").is(":checked") ? "on" : "off";
        playerSettings.damage = $("#show-damage").is(":checked") ? "on" : "off";
        playerSettings.deathscreen = $("#show-deathscreen").is(":checked") ? "on" : "off";
        playerSettings.hud = $("#show-hud").is(":checked") ? "on" : "off";
        playerSettings.crosshair = $("#show-crosshair").is(":checked") ? "on" : "off";

        localStorage.setItem("taSettings", JSON.stringify(playerSettings))

        $.post(`https://${GetParentResourceName()}/loadSettings`, JSON.stringify(playerSettings))
    }

    function loadSettings(settings){
        playerSettings = objClone(settings)

        for (let key in playerSettings){
            if (playerSettings[key] == "off"){
                $(`#show-${key}`).prop("checked", false) 
                $(`#show-${key}`).parent().parent().css("opacity", "0.4") 
            } else{
                $(`#show-${key}`).prop("checked", true) 
                $(`#show-${key}`).parent().parent().css("opacity", "1") 
            }
        }

        $.post(`https://${GetParentResourceName()}/loadSettings`, JSON.stringify(playerSettings))
    } 

    $(".reset-btn").click(() => {
        loadSettings(defaultSettings)
        saveSettings()
        $.post(`https://${GetParentResourceName()}/resetSettings`)
    })
    
    $(".slider-button").click(function(){
        if ($(this).find("input").prop("checked") == true){
            $(this).css("opacity", "1.0")
        }   else{
            $(this).css("opacity", "0.4")
        }

        saveSettings()
    })

    window.addEventListener("message", function(e){
        data = e.data;
        if(data.action == "stopEditing"){
            if (editingHud) {
                $("main").show()
                $(".facetoface").hide()
            }
        }
        if(data.action == "show"){
            $("body").show()
        }
        if(data.action == "hide"){
            $("body").hide()
        }
        if(data.action == "updateFPlayers"){
            let fplayers = data.fplayers
            fplayers.sort(function(a, b) {return b.score - a.score})
            let text = ''

            fplayers.forEach(el => {
                text += `
                <div class="user">
                    <div class="name">${el.name}</div>
                    <div class="score">${el.score}</div>
                </div>
                `
            });

            $(".facetoface .users").html(text)
        }
        if(data.action == "rekoAccept"){
            gamemodes_ui = false
            reko_page = true
            $(".right2").fadeOut(100);
            closeAll()
            setTimeout(() => {$(".help-menu").css({'display':'none'});}, 100);
            setTimeout(() => {$(".settings").css({'display':'none'});}, 100);
            setTimeout(() => {$(".right").css({'display':'none'});}, 100);
            setTimeout(() => {$(".leaderboard").css({'display':'none'});}, 100);
        }
        if(data.action == "enable"){
            main_page = true
            $("main").fadeIn(100);
            $(".facetoface").hide()
            $("main").css({'display':'block'});
            $(".right").fadeIn(100);
            $(".animator").css("height", "100vh")
        }
        if(data.action == "close"){
            $(".back").css({'display':'none'});
            $(".default_damaged_mods").css({'display':'none'});
            $(".custom_damaged_mods").css({'display':'none'});
            $(".advanced_mods").css({'display':'none'});
            $(".right2").css({'display':'none'});
            $(".gamemodes").css({'display':'none'});
            $(".settings").css({'display':'none'});
            $("main").css({'display':'none'});
        }
        if(data.action == "setUiData"){
            let kills = parseInt(data.player.kills)
            let death = parseInt(data.player.death)
            let rank = data.player.rank
            let kda = 0
            if (death == 0){kda = kills}else{kda = (kills / death).toFixed(2)}
            $("#kills").html(kills);
            $("#deaths").html(death);
            $("#kdas").html(kda);
            $("#ranks").html(rank);
        }
        if(data.action == "update"){
            $(".char").html('<div class="pp"><img alt="pp" src="'+data.playerAvatar+'" width=60" height="60"></div> <div class="title-wrapper"> <div class="title">'+data.playerId+'</div> <div class="subtitle">'+data.playerName+'</div></div>');
        }
        if(data.action == "babalartikladifalse"){
            tikladi = false
        }
        if(data.action == "showWinner"){
            $(".gungame-finish").fadeIn(100)
            $(".gungame-finish .pp img").attr("src", data.avatar)
            $(".gungame-finish .name").text(data.name)
        }
        if(data.action == "hideWinner"){
            $(".gungame-finish").fadeOut(100)
        }
        if(data.action == "refreshPlayers"){
            $(`#${data.gamemode} .players-title span`).text(data.players)
        }
        if(data.action == "firstJoin"){
            data.gamemodes.forEach(el => {
                $(`#${el.mode} .players-title span`).text(el.players)
            });
        }
        if(data.action == "setNuiCoords"){

            let headX = data.headX * (screen.width / 2)
            let headY = data.headY * (screen.height / 2)

            let shoulderLX = data.shoulderLX * (screen.width / 2)
            let shoulderLY = data.shoulderLY * (screen.height / 2)

            let shoulderRX = data.shoulderRX * (screen.width / 2)
            let shoulderRY = data.shoulderRY * (screen.height / 2)

            $(".character").css("top", headY + "px")
            $(".character").css("left", headX + "px")

            $("#kda").css("top", shoulderRY + "px")
            $("#kda").css("left", shoulderRX + "px")
            
            $("#death").css("top", shoulderLY + "px")
            $("#death").css("left", shoulderLX + "px")
            
            $("#kill").css("top", shoulderLY + "px")
            $("#kill").css("left", shoulderLX + "px")
            
            $("#rank").css("top", shoulderRY + "px")
            $("#rank").css("left", shoulderRX + "px")

        }
        if (data.type == "gungame-board-open") {
            $("#gungame-board").fadeIn(100);
            $("#current-weapon").fadeIn(100);
            $("#next-weapon").fadeIn(100);
            $("#remaing-kill").fadeIn(100);
            $("#remaing-weapon").fadeIn(100);
            $("#current-weapon b").html(data.currentweapon);
            $("#next-weapon b").html(data.nextweapon);
            $("#remaing-kill b").html(data.remaingkill);
            $("#remaing-weapon b").html(data.remaingweapon);
          }
          if (data.type == "gungame-board-close") {
            $("#gungame-board").fadeOut(100);
            $("#current-weapon").fadeOut(100);
            $("#next-weapon").fadeOut(100);
            $("#remaing-kill").fadeOut(100);
            $("#remaing-weapon").fadeOut(100);
          }
          if (data.type == "gungame-board-currentweapon-update") {
            $("#current-weapon b").html(data.currentweapon);
          }
          if (data.type == "gungame-board-nextweapon-update") {
            $("#next-weapon b").html(data.nextweapon);
          }
          if (data.type == "gungame-board-remaingkill-update") {
            $("#remaing-kill b").html(data.remaingkill);
          }
          if (data.type == "gungame-board-remaingweapon-update") {
            $("#remaing-weapon b").html(data.remaingweapon);
          }
    })

    $("#privlobbys").click(function(){
        privlobbys_ui = true
        $("main").fadeOut(100);
        $.post('http://ta-base/privlobby')
    })

    $("#crewMenu").click(function(){
        crew_ui = true
        $("main").fadeOut(100);
        $.post('http://ta-base/crewMenu')
    })

    $(".leaderSelection").change(function(){
        if ($(this).val() == 0){
            getLeaderboardData()
        }else{
            getMatchmakingData()
        }
    })
})

function change_page(page){
    if (page == "gamemods_page"){
        main_page = false
        gamemodes_ui = true
        $(".animator").css("height", "0vh")
        $(".right").fadeOut(100);
        $(".right2").fadeIn(100);
        $(".back").css({'display':'flex'});
        closeAll()
        $(".gamemodes").fadeIn(100);
    } else if (page == "default_damaged") {
        gamemodes_ui = false
        default_damaged_ui = true
        $(".right2").fadeOut(100);
        closeAll()
        $(".default_damaged_mods").fadeIn(100);
    } else if (page == "reko_page") {
        gamemodes_ui = false
        reko_page = true
        $(".right2").fadeOut(100);
        $.post("https://ta-base/showRekoPage")
        $("main").fadeOut(100)
        closeAll()
    } else if (page == "custom_damaged") {
        gamemodes_ui = false
        custom_damaged_ui = true
        $(".right2").fadeOut(100);
        closeAll()
        $(".custom_damaged_mods").fadeIn(100);
    } else if (page == "advanced_mods") {
        gamemodes_ui = false
        advanced_ui = true
        $(".right2").fadeOut(100);
        closeAll()
        $(".advanced_mods").fadeIn(100);
    } else if (page == "settings"){
        main_page = false
        settings_ui = true
        $(".right").fadeOut(100);
        $(".right3").fadeIn(100);
        closeAll()
        $(".settings").fadeIn(100);
        $(".back").css({'display':'flex'});
    } else if (page == "leaderboard"){
        main_page = false
        leaderboard_ui = true
        $(".right").fadeOut(100);
        $(".right3").fadeIn(100);
        getLeaderboardData()
        closeAll()
        $(".leaderboard").fadeIn(100);
        $(".back").css({'display':'flex'});
    }else if (page == "help-menu"){
        main_page = false
        help_menu = true
        $(".right").fadeOut(100);
        $(".right3").fadeIn(100);
        $(".back").css({'display':'flex'});
        closeAll()
        $(".help-menu").fadeIn(100);
    }else if (page == "market"){
        main_page = false
        market_ui = true
        $("main").fadeOut(100)
        $.post(`https://${GetParentResourceName()}/openMarket`)
    }
}

function closeAll(){
    $(".settings").fadeOut(100);
    $(".leaderboard").fadeOut(100);
    $(".help-menu").fadeOut(100);
    $(".gamemodes").fadeOut(100);
    $(".custom_damaged_mods").fadeOut(100);
    $(".advanced_mods").fadeOut(100);
    $(".default_damaged_mods").fadeOut(100);
    $(".animator").css("height", "0vh")
}

function openCrewMenu(){
    $.post(`https://${GetParentResourceName()}/crew`)
}

function getLeaderboardData(){
    $.post(`https://${GetParentResourceName()}/getLeaderboardData`, function(data){
        players = data.players
        let text = ''

        players.sort(function(a, b) {return b.kills - a.kills})

        $(".leaderboard .head .kill").text("KILLS")
        $(".leaderboard .head .death").text("DEATHS")
        $(".leaderboard .head .kda").text("KDA")


        for (let i = 0; i < players.length && i < 50; i++){
            let kda = 0
            players[i].death = (players[i].death === 0) ? 1 : players[i].death
            kda = Number(players[i].kills / players[i].death).toFixed(2)
            text += `
            <div class="box ${players[i].identifier == data.identifier ? "selff" : ""}">
                <div class="rank">${i + 1}</div>
                <div class="name">${players[i].playername}</div>
                <div class="kill">${players[i].kills}</div>
                <div class="death">${players[i].death}</div>
                <div class="kda">${kda}</div>
            </div>
            `
        }

        players.forEach((el, i) => {
            if (data.identifier == el.identifier){
                let kda = 0
                players[i].death = (players[i].death === 0) ? 1 : players[i].death
                kda = Number(players[i].kills / players[i].death).toFixed(2)
                $(".leaderboard .self").html(`
                    <div class="rank">${i + 1}</div>
                    <div class="name">${el.playername}</div>
                    <div class="kill">${el.kills}</div>
                    <div class="death">${el.death}</div>
                    <div class="kda">${kda}</div>
                `)
            }
        });

        $(".leaderboard .body").html(text)
    })
}

function getMatchmakingData(){
    $.post(`https://${GetParentResourceName()}/getMatchmakingData`, function(data){
        players = data.players
        let text = ''

        players.sort(function(a, b) {return b.wins - a.wins})

        $(".leaderboard .head .kill").text("WINS")
        $(".leaderboard .head .death").text("LOSES")
        $(".leaderboard .head .kda").text("W/L")

        for (let i = 0; i < players.length && i < 50; i++){
            let kda = Number(players[i].wins / players[i].loses).toFixed(2)
            if (kda == NaN){kda = 0}
            text += `
            <div class="box ${players[i].identifier == data.identifier ? "selff" : ""}">
                <div class="rank">${i + 1}</div>
                <div class="name">${players[i].name}</div>
                <div class="kill">${players[i].wins}</div>
                <div class="death">${players[i].loses}</div>
                <div class="kda">${kda}</div>
            </div>
            `
        }

        players.forEach((el, i) => {
            if (data.identifier == el.identifier){
                let kda = Number(el.kills / el.deaths).toFixed(2)
                if (el.wins == 0){kda = el.loses}else{(el.wins / el.loses).toFixed(2)}
                if (kda == NaN){kda = 0}
                $(".leaderboard .self").html(`
                    <div class="rank">${i + 1}</div>
                    <div class="name">${el.name}</div>
                    <div class="kill">${el.wins}</div>
                    <div class="death">${el.loses}</div>
                    <div class="kda">${kda}</div>
                `)
            }
        });

        $(".leaderboard .body").html(text)
    })
}

function back(){
    if (gamemodes_ui){
        main_page = true
        gamemodes_ui = false
        $(".animator").css("height", "100vh")
        $(".right").fadeIn(100);
        $(".right2").fadeOut(100);
        $(".back").css({'display':'none'});
        $(".gamemodes").fadeOut(100);
    } else if (default_damaged_ui) {
        gamemodes_ui = true
        default_damaged_ui = false
        $(".default_damaged_mods").fadeOut(100);
        $(".default_damaged_mods").css({'display':'none'});
        $(".right2").fadeIn(100);
        $(".gamemodes").fadeIn(100);
    } else if (custom_damaged_ui) {
        gamemodes_ui = true
        custom_damaged_ui = false
        $(".custom_damaged_mods").fadeOut(100);
        $(".custom_damaged_mods").css({'display':'none'});
        $(".right2").fadeIn(100);
        $(".gamemodes").fadeIn(100);
    } else if (advanced_ui) {
        gamemodes_ui = true
        advanced_ui = false
        $(".advanced_mods").fadeOut(100);
        $(".advanced_mods").css({'display':'none'});
        $(".right2").fadeIn(100);
        $(".gamemodes").fadeIn(100);
    } else {
        main_page = true
        settings_ui = false
        leaderboard_ui = false
        help_menu = false
        market_ui = false
        crew_ui = false
        closeAll()
        $(".animator").css("height", "100vh")
        $(".right").fadeIn(100);
        $(".right3").fadeOut(100);
        $(".back").fadeOut(100);
    }
    $(".advanced_mods").css({'display':'none'});
    $(".default_damaged_mods").css({'display':'none'});
    $(".help-menu").css({'display':'none'});
    $(".custom_damaged_mods").css({'display':'none'});
    $(".settings").css({'display':'none'});
}

$(".game").click(function(){
    if (tikladi == false) {
        if ($(this).find("span").text() < ($(this).data("max"))){
            tikladi = true
            $(this).attr("id") == "advanced_parkour" ? $(".facetoface").fadeIn(100) : ""
            $.post('http://ta-base/ta-base:join-gamemode', JSON.stringify($(this).attr("id")))
            $("main").fadeOut(100)
            // $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'Oyun', title: "Başarılı", message: "Odaya katıldın!", time: 5000}))
        }else{
            // $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'Oyun', title: "Hata", message: "Oda dolu!", time: 5000}))
        }
    }
})

function startEditing(eType){
    editingHud = true
    $("main").hide()
    $.post('http://ta-hud/startEditing', JSON.stringify(eType))
}

function crosshairSelect(){
    editingHud = true
    $("main").hide()
    $.post('http://ta-crosshairs/startEditing')
}

function kiyafetbaba(){
    $.post('http://ta-base/kiyafetallahsehit')
}

function aimlab(){
    $.post('http://ta-base/ta-base:join-aimlab')
}

function join_game(){}