$('.wrapper, .left-wrapper, .invites, .creates').hide();

/////////////////////////////////////////////////////////////////////////////////////////
// VARIABLES'S //
/////////////////////////////////////////////////////////////////////////////////////////

let myhex;
let lastpage = "squads";
let insquads = false;
let private  = false;
let cooldown = false;

/////////////////////////////////////////////////////////////////////////////////////////
// LISTENER AND SECOND BUILD FUNCTION'S //
/////////////////////////////////////////////////////////////////////////////////////////

window.addEventListener('message', function (event) {
    let e = event.data;
    switch (e.type) {
        case "LOAD_HEX":
            myhex = e.hex;
            break;
        case "FIRST_LOAD_ROOMS":
            buildRoomsFirst(e.object);
            break;
        case "LOAD_ROOMS":
            buildRooms(e.object);
            break;
        case "OPEN_MENU":
            UIbuilder();
            break;
        case "CLOSE_MENU":
            $('.left-wrapper').css({"display": `${insquads ? "flex" : "none"}`});
            $('.wrapper, .has_squad, .invites, .creates').hide();
            break;
        case "ADDLIST_NEWSQUAD":
            addSquadForList(e.object);
            break;
        case "BUILD_SQUAD":
            squadBuild(e.object);
            break;
        case "SQUAD_STATS":
            buildStats(e.object);
            break;
        case "DELETE_SQUAD":
            deleteSquad(e.squad);
            break;
        case "KICKED_SQUAD":
            kickedSquad();
            break;
        case "LIST_UPDATE_COUNT":
            UpdateSquadForList(e.object);
            break;
        case "COME_INVITE":
            addNewInvite(e.invited);
            break;
        case "LEAVE_SQUAD":
            leaveSquad();
            break;
        case "DELETE_INVITES":
            deleteInvite();
            break;
        default: break;
    }
});

window.addEventListener('input', (e) => {
    if (e.target.id == "search-squad") {
        $(".squad").each((i,el) => $(el).text().toLowerCase().includes(e.target.value) ? $(el).toggle(true) : $(el).toggle(false))
    }
});

document.onkeyup = function(data){
    if (data.key == "Escape"){
        if (!cooldown) {
            $.post('http://ta-squad/close', JSON.stringify({}));
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////
// UI CONTROL'S //
/////////////////////////////////////////////////////////////////////////////////////////

$(document).on('click', '.category', function(){
    if (!cooldown) {
        cooldown = true
        let page = $(this).data('page');
        ShowPage(page);
        $('.category').removeClass('active');
        $(this).addClass('active');
    }
});

$(document).on('click', '.privateselect', function(){
    if (!private) {
        $('.privateselect').html("");
        let div = `<i class="fa-solid fa-lock"></i>`
        $('.privateselect').append(div);
        private = true
    }else {
        $('.privateselect').html("");
        let div2 = `<i class="fa-solid fa-unlock"></i>`
        $('.privateselect').append(div2);
        private = false
    }
});

$(document).on('click', '.create-squads', function(){
    if (!cooldown) {
        cooldown = true
        let squadname = $('#newsquadname').val().toLowerCase();
        if (squadname.length > 1 && squadname != "" && squadname != null) {
            $.post('http://ta-squad/createsquad', JSON.stringify({name: squadname, isprivate: private}), function(created) {
                if (created) {
                    $('#newsquadname').val("");
                    $('#newsquadname').attr('placeholder','Squad Name')
                    insquads = true;
                    $(".leave-squad").data("roomname", squadname)
                    UIbuilder();
                }
            });
        }
    }
});

function leaveSquad(){
    $(".leave-squad").click()
}

$(".leave-squad").click(function(){
    if (!cooldown) {
        cooldown = true
        let squadname = $(this).data('roomname');
        $.post('http://ta-squad/leavesquad', JSON.stringify({name: squadname}), function(leaved) {
            if (leaved) {
                insquads = false;
                UIbuilder2();
            }
        });
    }
});

$(document).on('click', '#join', function(){
    if (!cooldown) {
        cooldown = true
        let squadname = $(this).parent().parent().data('squadname');
        $.post('http://ta-squad/joinsquad', JSON.stringify({name: squadname}), function(joined) {
            if (joined) {
                insquads = true;
                UIbuilder();
            }else {
                cooldown = false
            }
        });
    }
});

$(document).on('click', '#kick', function(){
    if (!cooldown) {
        cooldown = true
        let squadname = $(this).data('squadname');
        let targetid  = $(this).data('playerid');
        $.post('http://ta-squad/kickplayer', JSON.stringify({name: squadname, target: targetid}), function(kicked) {
            if (kicked) {
                cooldown = false
            }else {
                cooldown = false
            }
        });
    }
});

$(document).on('click', '.accept', function(){
    if (!cooldown) {
        cooldown = true
        let div = $(this).parent().parent();
        let squadname = $(this).data('squadname');
        $.post('http://ta-squad/invite-accept', JSON.stringify({name: squadname}), function(joined) {
            if (joined) {
                div.remove();
                insquads = true;
                UIbuilder();
            }else {
                cooldown = false
                div.remove();
            }
        });
    }
});

$(document).on('click', '.decline', function(){
    if (!cooldown) {
        cooldown = true
        let div = $(this).parent().parent();
        div.remove();
        cooldown = false;
    }
});

window.onload = loaded

/////////////////////////////////////////////////////////////////////////////////////////
// MAIN BUILD UI FUNCTION'S //
/////////////////////////////////////////////////////////////////////////////////////////

function loaded() {
    $.post('http://ta-squad/nuiloaded', JSON.stringify({}));
}

function ShowPage(page) {
    $('.squads, .invites, .creates').hide();
    $(`.${page}`).show();
    lastpage = page
    cooldown = false;
}

function buildRoomsFirst(rooms) {
    $.each(rooms, function (k, v) { 
        let div = `
        <div class="squad" data-squadname="${rooms[k].roomname}" data-roomid="${rooms[k].roomid}">
            <div class="s-img">
                <img class="roomimg" src="img/rooms/${rooms[k].icon}.png">
            </div>
            <div class="s-name">
                <span>${rooms[k].roomname}</span>
            </div>
            <div class="s-properties">
                ${rooms[k].isPrivate ? '<i class="fa-solid fa-lock"></i>' : '<i class="fa-solid fa-unlock"></i>'}
                <span id="${rooms[k].roomid}-count">${rooms[k].pcounts}/${rooms[k].maxp}</span>
                <button id="join">join</button>
            </div>
        </div>
        `;
        $('.squads').append(div);
    });
    $.post('http://ta-squad/nuidataloaded', JSON.stringify({}));
}

function buildRooms(rooms) {
    $('.squads').html("")
    $.each(rooms, function (k, v) { 
        let div = `
        <div class="squad" data-squadname="${rooms[k].roomname}" data-roomid="${rooms[k].roomid}">
            <div class="s-img">
                <img class="roomimg" src="img/rooms/${rooms[k].icon}.png">
            </div>
            <div class="s-name">
                <span>${rooms[k].roomname}</span>
            </div>
            <div class="s-properties">
                ${rooms[k].isPrivate ? '<i class="fa-solid fa-lock"></i>' : '<i class="fa-solid fa-unlock"></i>'}
                <span id="${rooms[k].roomid}-count">${rooms[k].pcounts}/${rooms[k].maxp}</span>
                <button id="join">join</button>
            </div>
        </div>
        `;
        $('.squads').append(div);
    });
}

function UIbuilder() {
    $('.wrapper').css({"display": "flex"});
    $('.left-wrapper').css({"display": `${insquads ? "flex" : "none"}`});
    if (!insquads) {
        $('.squads, .invites, .creates .has_squad').hide();
        $('.squad_main, .leave-squad').hide();
        $('.squad_list, .squad_create, .squad_invites').show();
        $(`.${lastpage}`).show();
    }else{
        $('.squad_main, .leave-squad, .has_squad').show();
        $('.squad_list, .squad_create, .squad_invites, .squads, .invites, .creates').hide();
    }
    cooldown = false
}

function UIbuilder2() {
    $('.wrapper').css({"display": "flex"});
    $('.left-wrapper').css({"display": `${insquads ? "flex" : "none"}`});
    if (!insquads) {
        $('.squads, .invites, .creates .has_squad').hide();
        $('.squad_main, .leave-squad').hide();
        $('.squad_list, .squad_create, .squad_invites').show();
        $(`.${lastpage}`).show();
    }else{
        $('.squad_main, .leave-squad, .has_squad').show();
        $('.squad_list, .squad_create, .squad_invites, .squads, .invites, .creates').hide();
    }
    cooldown = false
    $('.wrapper').hide()
}

function addSquadForList(squadprop) {
    let name = squadprop.name;
    let prop = squadprop.squadlist;
    let div = `
    <div class="squad" data-squadname="${name}" data-roomid="${prop[name].roomid}">
        <div class="s-img">
            <img class="roomimg" src="img/rooms/${prop[name].icon}.png">
        </div>
        <div class="s-name">
            <span>${name}</span>
        </div>
        <div class="s-properties">
            ${prop[name].isPrivate ? '<i class="fa-solid fa-lock"></i>' : '<i class="fa-solid fa-unlock"></i>'}
            <span id="${prop[name].roomid}-count">${prop[name].pcounts}/${prop[name].maxp}</span>
            <button id="join">join</button>
        </div>
    </div>
    `;
    $('.squads').append(div);
}

function GetLeader(players) {
    var isleader = false;
    $.each(players, function (i, e) { 
        if (e.leader) {
            isleader = e.identifier
        }
    });
    return isleader
}

function squadBuild(prop) {
    $('.left-wrapper').html("");
    let playerbox = ''
    let player = ''
    $.each(prop.players, function (i, v) { 
        player += `
        <div class="players">
            <div class="players-img">
                <img class="pimg" src="${v.avatar}">
            </div>
            <div class="players-n-r">
                <div class="players-name">
                    <span>${v.name}</span>
                </div>
                <div class="players-rank">
                    ${v.leader ? '<i class="fa-solid fa-user-chef"></i><span>Leader</span>' : `<i class="fa-solid fa-user"></i><span>${v.leader ? "wtf" : "User"}</span>`}
                </div>
            </div>
            ${v.identifier == myhex ? "" : GetLeader(prop.players) == myhex ? `<div class="players-actions"><button id="kick" data-squadname="${prop.roomname}" data-playerid="${v.id}">Kıck</button></div>` : ""}
        </div>
        `;
        playerbox += `
        <div class="player-box">
            <div class="pb-img">
                <img class="pb-image" src="${v.avatar}">
            </div>
            <div class="pb-information">
                <div class="pb-name">
                    <span>${v.name}</span>
                </div>
                <div class="pb-healt"><div class="pb-healt-in" id="${v.hexlast}-hp" style="width: 0%;"></div></div>
                <div class="pb-armour"><div class="pb-armour-in" id="${v.hexlast}-armour" style="width: 0%;"></div></div>
            </div>
        </div>
        `;
    });

    $('.left-wrapper').html(playerbox);
    $('.i-players').html(player);
}

function UpdateSquadForList(prop) {
    setTimeout(() => {
        $(`#${prop.roomid}-count`).html(`${prop.nowp}/${prop.maxp}`)
    }, 250);
}

function buildStats(stats) {
    $.each(stats, function (k, v) { 
        $(`#${k}-hp`).css({
            "width": `${stats[k].hp}%`
        });
        $(`#${k}-armour`).css({
            "width": `${stats[k].armour}%`
        });
    });
}

function deleteSquad(room) {
    $(`.squad[data-roomid="${room}"]`).remove();
}

function kickedSquad() {
    insquads = false;
    UIbuilder();
}

function addNewInvite(squad) {
    let newinvite = `
    <div class="squad">
        <div class="s-img">
            <img class="roomimg" src="img/rooms/${squad.icon}.png">
        </div>
        <div class="s-name">
            <span>${squad.roomname}</span>
        </div>
        <div class="s-properties">
            ${squad.isPrivate ? '<i class="fa-solid fa-lock"></i>' : '<i class="fa-solid fa-unlock"></i>'}
            <span id="${squad.roomid}-count">${squad.pcounts}/${squad.maxp}</span>
            <div class="accept" data-squadname="${squad.roomname}">
                <i class="fa-solid fa-check"></i>
            </div>
            <div class="decline" data-squadname="${squad.roomname}">
                <i class="fa-solid fa-xmark"></i>
            </div>
        </div>
    </div>
    `;
    $('.invites').append(newinvite);
}

function deleteInvite() {
    $('.invites').html("");
}

$(window).on("keydown", function ({ originalEvent: { key } }) {
    if (key == "Escape") {
        $(".wrapper").fadeOut(100)
        $.post(`https://${GetParentResourceName()}/close`)
    }
})