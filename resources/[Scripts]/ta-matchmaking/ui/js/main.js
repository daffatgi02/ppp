owner = true;
$(document).ready(function() {

    $(".menu-btn").click(function(){
        $.post(`https://${GetParentResourceName()}/ta-matchmaking:client:menu-back`)
        $("main").fadeOut(100);
        $(".back").fadeOut(100);
        $(".back .buttons-wrapper .button").fadeOut(100);
    })

    window.addEventListener("message", function(event) {
        let data = event.data;

        if (data.type == "open") {
            if (data.display == true) {
                $(".back").fadeIn(100);
                $(".back .buttons-wrapper .button").fadeIn(100);
                $("body > main").fadeIn(100);
                $(".back").fadeIn(100);
                $(".back .buttons-wrapper .button").fadeIn(100);
            } else {
                $("body > main").fadeOut(100);
                $(".back").fadeOut(100);
                $(".back .buttons-wrapper .button").fadeOut(100);
            }
        }

        if (data.type == "recieveinvite") {
            recievenotify(data.message);
        }

        if (data.type == "stopNotification") {
            $(".notify").fadeOut(100);
            $(".notify-wrapper").fadeOut(100);
        }

        if (data.type == "kicked") {
            changediv("main")
        }

        if (data.type == "openNUIWithTeam") {
            changediv(data.kackisivararkakoltukta);
        }

        if (data.type == "CloseQueue") {
            CloseQueue();
        }

        if (data.type == "StartMatchmakingUI") {
            matchmakingui();
        }

        if (data.type == "getMyTeam") {
            $(`.player-1 .name`).text("+");
            $(`.player-2 .name`).text("+");
            $(`.player-3 .name`).text("+");
            $(`.player-4 .name`).text("+");
            $(`.player-5 .name`).text("+");
            $(`.player-6 .name`).text("+");
            $(`.player-7 .name`).text("+");
            $(`.player-8 .name`).text("+");
            $(`.player-9 .name`).text("+");
            $(`.player-10 .name`).text("+");
            $(`.player-11 .name`).text("+");
            $(`.player-12 .name`).text("+");
            $(`.player-13 .name`).text("+");
            $(`.player-14 .name`).text("+");
            $(`.player-15 .name`).text("+");

            data.players.forEach((player, index) => {
                if (player != null) {
                    $(`.player-${index + 1} .name`).text(player.name);

                    if (data.owner) {
                        $("#matchstartlamabutonu").removeClass("disabled");

                        if (type != 1) {
                            $(".hide").show();
                        }
                    }else{
                        $("#matchstartlamabutonu").addClass("disabled");
                    }
                }
            });
        }

        if (data.type == "roundopen") {
            $(".in-game").css("display", "flex").hide().fadeIn(100);
        }

        if (data.type == "roundclose") {
            $(".in-game").css("display", "flex").fadeOut(100);
        }

        if (data.type == "roundupdate") {
            $(".team-1").text(data.myteam)
            $(".team-2").text(data.enemyteam)
        }
    });

    $("#inviteBtn").click(function() {
        inviteplayer($("#inviteInp").val())
    })
});

function changediv(divname) {
    $(".lobbies").hide();
    $(".players").hide();
    $(".in-loby").hide();

    $(".empty").show()
    $(".empty").show()
    $(".empty").show()
    $(".empty").show()

    $(".empty").removeClass("hide")
    $(".empty").removeClass("hide")
    $(".empty").removeClass("hide")
    $(".empty").removeClass("hide")

    if (divname == "main") {
        $.post(`https://${GetParentResourceName()}/backbutton`)
        $(".lobbies").show()
        $(".in-loby").hide()
        $(".players").hide()
        $(".clear-btn").addClass("disabled")
        $(".back-btn").addClass("disabled")
    }

    if (divname == "davetler") {
        $(".invites").hide()
        $(".lobbies").hide()
        $(".in-loby").hide()
        $(".players").hide()
    }

    if (divname == "1v1") {
        type = 1;
        $.post(`https://${GetParentResourceName()}/CreateTeam`, JSON.stringify({ type: type })).then((data) => {
            $(".lobbies").hide()
            $(".in-loby").show()
            $(".player-2").addClass("hide")
            $(".player-3").addClass("hide")
            $(".player-4").addClass("hide")
            $(".player-5").addClass("hide")
            $(".player-6").addClass("hide")
            $(".player-7").addClass("hide")
            $(".player-8").addClass("hide")
            $(".player-9").addClass("hide")
            $(".player-10").addClass("hide")
            $(".player-11").addClass("hide")
            $(".player-12").addClass("hide")
            $(".player-13").addClass("hide")
            $(".player-14").addClass("hide")
            $(".player-15").addClass("hide")
            $(".clear-btn").removeClass("disabled")
        })
    }

    if (divname == "2v2") {
        type = 2;
        $.post(`https://${GetParentResourceName()}/CreateTeam`, JSON.stringify({ type: type })).then((data) => {
            $(".lobbies").hide()
            $(".in-loby").show()
            $(".player-3").addClass("hide")
            $(".player-4").addClass("hide")
            $(".player-5").addClass("hide")
            $(".player-6").addClass("hide")
            $(".player-7").addClass("hide")
            $(".player-8").addClass("hide")
            $(".player-9").addClass("hide")
            $(".player-10").addClass("hide")
            $(".player-11").addClass("hide")
            $(".player-12").addClass("hide")
            $(".player-13").addClass("hide")
            $(".player-14").addClass("hide")
            $(".player-15").addClass("hide")
            $(".clear-btn").removeClass("disabled")
        })
    }

    if (divname == "3v3") {
        type = 3;
        $.post(`https://${GetParentResourceName()}/CreateTeam`, JSON.stringify({ type: type })).then((data) => {
            $(".lobbies").hide()
            $(".in-loby").show()
            $(".player-4").addClass("hide")
            $(".player-5").addClass("hide")
            $(".player-6").addClass("hide")
            $(".player-7").addClass("hide")
            $(".player-8").addClass("hide")
            $(".player-9").addClass("hide")
            $(".player-10").addClass("hide")
            $(".player-11").addClass("hide")
            $(".player-12").addClass("hide")
            $(".player-13").addClass("hide")
            $(".player-14").addClass("hide")
            $(".player-15").addClass("hide")
            $(".clear-btn").removeClass("disabled") 
        })
    }

    if (divname == "4v4") {
        type = 4;
        $.post(`https://${GetParentResourceName()}/CreateTeam`, JSON.stringify({ type: type })).then((data) => {
            $(".lobbies").hide()
            $(".in-loby").show()
            $(".clear-btn").removeClass("disabled")
            $(".player-5").addClass("hide")
            $(".player-6").addClass("hide")
            $(".player-7").addClass("hide")
            $(".player-8").addClass("hide")
            $(".player-9").addClass("hide")
            $(".player-10").addClass("hide")
            $(".player-11").addClass("hide")
            $(".player-12").addClass("hide")
            $(".player-13").addClass("hide")
            $(".player-14").addClass("hide")
            $(".player-15").addClass("hide")
        })
    }
    
    if (divname == "5v5") {
        type = 5;
        $.post(`https://${GetParentResourceName()}/CreateTeam`, JSON.stringify({ type: type })).then((data) => {
            $(".lobbies").hide()
            $(".in-loby").show()
            $(".clear-btn").removeClass("disabled")
            $(".player-6").addClass("hide")
            $(".player-7").addClass("hide")
            $(".player-8").addClass("hide")
            $(".player-9").addClass("hide")
            $(".player-10").addClass("hide")
            $(".player-11").addClass("hide")
            $(".player-12").addClass("hide")
            $(".player-13").addClass("hide")
            $(".player-14").addClass("hide")
            $(".player-15").addClass("hide")
        })
    }

    if (divname == "15v15") {
        type = 15;
        $.post(`https://${GetParentResourceName()}/CreateTeam`, JSON.stringify({ type: type })).then((data) => {
            $(".lobbies").hide()
            $(".in-loby").show()
            $(".clear-btn").removeClass("disabled")
        })
    }
}

intervalID = null;

function startmatchmaking() {
    $.post(`https://${GetParentResourceName()}/startmatchmaking`, JSON.stringify({ type: type }));
    matchmakingui();
}

function matchmakingui() {
    $(".bg").fadeIn(100);
    $(".match.mini-page").css("display", "flex").hide().fadeIn(100);
    gecensure = 0;
    $("#timesadsadsa").text(gecensure+ "s");
    if (intervalID) {
        clearInterval(intervalID);
    }
    intervalID = setInterval(function () {
        gecensure++;
        $("#timesadsadsa").text(gecensure+ "s");
    }, 1000);
}

CloseQueue = function () {
    $(".bg").css("display", "none");
    $(".match.mini-page").css("display", "none");
    clearInterval(intervalID);
    gecensure = 0;
    $("#timesadsadsa").text(gecensure+ "s");
}

function cancelmatchmaking() {
    $.post(`https://${GetParentResourceName()}/removeteamfromqueue`)
}

function openlookplayer(serverid) {
    $.post(`https://${GetParentResourceName()}/getPlayerdata`, JSON.stringify({ serverid: serverid }))
    $(".user-info.mini-page").css("display", "flex").hide().fadeIn(100);
}

function kd(kill, deaths) {
    var sayi = kill / deaths
    return sayi.toFixed(2)
}

function back() {
    $(".players").hide()
    $(".in-loby").show()
    $(".lobbies").hide()
    $(".back-btn").addClass("disabled");
}

function invitemenu() {
    $.post(`https://${GetParentResourceName()}/getInviteablePlayers`).then((data) => {
        $(".back-btn").removeClass("disabled");

        $(".players").show()
        $(".in-loby").hide()
        $(".lobbies").hide()
    })
}

function inviteplayer(id) {
    $.post(`https://${GetParentResourceName()}/invitePlayer`, JSON.stringify({ id: id })).then((data) => {
        back()
    })
}

function kickplayer(id) {
    $.post(`https://${GetParentResourceName()}/kickPlayer`, JSON.stringify({ id: id })).then((data) => {
    })
}

function recievenotify(notifytext) {
    $(".progbar").css("width", "0%")
    $(".notify").fadeIn(1500);
    $(".notify-wrapper").fadeIn(1500);
    $(".desc").text(notifytext);
    setTimeout(function () {
        $(".progbar").css("width", "100%")
    }, 1500);
    setTimeout(function () {
        $(".notify").fadeOut(1500);
        $(".notify-wrapper").fadeOut(1500);
    }, 10000);

    $.post(`https://ta-base/isFocused`)
}

function closesomenuis() {
    $(".user-info.mini-page").css("display", "none");
    $(".match.mini-page").css("display", "none");
    $(".bg").css("display", "none");
    $(".invite.mini-page").css("display", "none");
}

$("#btn-accept").click(() => {
    $.post(`https://${GetParentResourceName()}/acceptMatch`)
})

$("#btn-decline").click(() => {
    $.post(`https://${GetParentResourceName()}/declineMatch`)
})