let crew_wrap = false;
var crewData = [];
var isHaveCrew = false;
$(function () {

  $(".button").click(function(){
      $.post(`https://${GetParentResourceName()}/ta-crew:client:menu-back`)
      $("body").fadeOut(100);
      $(".back").addClass("hide");
  })

  window.addEventListener("message", function (event) {
    var item = event.data;
    if (item.type == "open-menu") {
      $(".back").removeClass("hide");
      $(".title-wrap .title").html("Crews");
      $("#crewSearch").show();
      $("#playerSearch").hide();
      $("body").fadeIn(100);
      $(".m-logo").attr("src", item.banner);
      $(".crew-var").hide();
      $(".crew-sil").hide();
      $(".crew-name-btn").hide();
      $(".crew-photo").hide();
      $(".crew-olustur").hide();
      $(".crew-davetleri").hide();

      if (item.crewbanner == "null") {
        $(".crew-olustur").show();
        $(".crew-davetleri").show();
      } else {
        $(".crew-var").show();
        $(".crew-sil").show();
        $(".crew-var").attr("src", item.crewbanner);
        $(".crew-var").attr("id", item.isHaveCrew);
      }

      $(".my-rank").html(item.rank);
      $(".my-name").html(item.name);
    }

    if (item.type == "isHaveCrew") {
      isHaveCrew = item.value;
    }

    if (item.type == "refresh-players") {
      refreshCrewlist(item.crewName);
    }

    if (item.type == "refresh-crew-players") {
      var playerTable = item.playerTable;
      $(".member-list").html("");
      $(".member-list").append(`
        <div class="member-list-box">
            <p class="member-name">NAME</p>
            <p class="member-kill">KILLS</p>
            <p class="member-death">DEATHS</p>
            <p class="member-kd">KDA</p>
            <p class="member-action">KICK</p>
        </div>`);
      for (let i = 0; i < playerTable.length; i++) {
        let text = ''
        if (isHaveCrew) {
          text = `
              <div class="member-list-box" name="${playerTable[i].identifier}">
                <p class="member-name">${playerTable[i].playername}</p>
                <p class="member-kill">${playerTable[i].kills}</p>
                <p class="member-death">${playerTable[i].death}</p>
                <p class="member-kd">${isNaN(playerTable[i].kills / playerTable[i].death) ? "0.0" : playerTable[i].death == 0 ? playerTable[i].kills : (playerTable[i].kills / playerTable[i].death).toFixed(2)}</p>
                <div class="member-list-kick" id="${playerTable[i].identifier}"><i class="fa-solid fa-x"></i></div>
              </div>
              `;
          $(".member-list-kick").click(function (e) {
            var identifier = this.id;
            $.post(
              `http://${GetParentResourceName()}/ta-crew:kickMember`,
              JSON.stringify({ identifier: identifier })
            );
            $(".my-crew-wrapper").fadeOut(100);
          });
          $(".crew-invite-side").show();
        } else {
          text = `
              <div class="member-list-box">
                <p class="member-name">${playerTable[i].name}</p>
                <p class="member-kill">${playerTable[i].kills}</p>
                <p class="member-death">${playerTable[i].death}</p>
                <p class="member-kd">${isNaN(playerTable[i].kills / playerTable[i].death) ? "0.0" : playerTable[i].death == 0 ? playerTable[i].kills : playerTable[i].kills / playerTable[i].death}</p>
                <div class="member-list-kick hide" id="${playerTable[i].identifier}"><i class="fa-solid fa-x"></i></div>
              </div>
              `;
        }
        $(".member-list").append(text);
      }
    }

    if (item.type == "list-all-crew") {
      var data = item.table;
      crewData = data;
      $(".crew-list").html("");
      Object.values(data).forEach(myFunction);

      function myFunction(value, index, array) {
        let text = ''
        text = `
              <div class="crew-list-box">

                <div class="crew-logo">
                  <img src="${value.crewPhoto}" class="c-logo">
                </div>

                <p class="crew-name">${value.name}</p>
                <p class="crew-member-amount">${value.members.length + value.leaders.length}/30</p>
              </div>
              `;

       $(".crew-list").append(text);
      }
    }

    if (item.type == "renew-inbox") {
      var crewname = item.crewname;
      var crewmembers = item.crewmembers;
      var crewphoto = item.crewphoto;
      const annDiv = document.createElement("div");
      annDiv.innerHTML = `
            <div class="davet">
              <div class="davet-edilen-crew-profile">
                  <img src="${crewphoto}" class="c-logo">
              </div>
              <p class="davet-edilen-crew-isim">${crewname}</p>
              <p class="davet-edilen-crew-member-count">${crewmembers}/30</p>
              <div class="davet-kabul" id="${crewname}-kabul"><i class="fa-solid fa-right-to-bracket"></i></div>
              <div class="davet-reddet" id="${crewname}-red"><i class="fa-solid fa-x"></i></div>
            </div>
          `;

      document.getElementsByClassName("davetler-list")[0].appendChild(annDiv);

      $(`#${crewname}-red`).click(function () {
        $(".davetler-list").html("");
        $.post(
          `http://${GetParentResourceName()}/ta-crew:inviteChoice`,
          JSON.stringify({ isAccepted: false, crewname: crewname })
        );
      });

      $(`#${crewname}-kabul`).click(function () {
        $(".davetler-list").html("");
        $.post(
          `http://${GetParentResourceName()}/ta-crew:inviteChoice`,
          JSON.stringify({ isAccepted: true, crewname: crewname })
        );
      });
    }
  });
});

$(".back").click(function () {
  if (crew_wrap == true) {
    $(".my-crew-wrapper").fadeOut(100);
    $(".crew-list-wrapper").fadeIn(100);
    crew_wrap = false;
  } else {
    $(".back").addClass(".hide");
    $("body").fadeOut(100);
    $.post(`http://${GetParentResourceName()}/ta-crew:closeUI`);
  }
});

$(document).ready(function () {
  $("#searchInput").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $(".crew-list-box").filter(function () {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
});

$(document).ready(function () {
  $("#searchInput2").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $(".member-list-box").filter(function () {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
});

$(".crew-olustur").click(function (e) {
  $(".crew-olustur-wrapper").fadeIn(100);
});

$(".crew-olustur-button").click((e) => {
  var name = $("#crew-olustur-name").val();
  var altname = $("#crew-olustur-kisaltma").val();
  var color = $("#crew-olustur-renk").val();
  if (pfp == "" || name == "" || altname == "" || color == "") {
  }else{
    var pfp = ''
    $.get($("#crew-olustur-profile").val()).done(function() { 
            pfp = $("#crew-olustur-profile").val();
            $.post(
              `http://${GetParentResourceName()}/ta-crew:createCrew`,
              JSON.stringify({ pfp: pfp, name: name, altname: altname, color: color })
            );
            $(".crew-olustur-wrapper").fadeOut(100);
            $(".btn-2").hide();
            $(".btn-2.crew-var").show();
            $(".btn-2.crew-sil").show();
            $.post(`https://${GetParentResourceName()}/ta-crew:client:menu-back`)
            $("body").fadeOut(100);
            $(".back").addClass("hide");
        }).fail(function() { 
            pfp = "https://media.discordapp.net/attachments/1088950559068917852/1148279156375830698/trans.png"
            $.post(
              `http://${GetParentResourceName()}/ta-crew:createCrew`,
              JSON.stringify({ pfp: pfp, name: name, altname: altname, color: color })
            );
            $(".crew-olustur-wrapper").fadeOut(100);
            $(".btn-2").hide();
            $(".btn-2.crew-var").show();
            $(".btn-2.crew-sil").show();
            $.post(`https://${GetParentResourceName()}/ta-crew:client:menu-back`)
            $("body").fadeOut(100);
            $(".back").addClass("hide");
        })
  }
});

$(".crew-davetleri").click(function (e) {
  $(".crew-davetler-wrapper").fadeIn(100);
});

$("#close-davetler").click(function (e) {
  $(".crew-davetler-wrapper").fadeOut(100);
});

$("#close-olustur").click(function (e) {
  $(".crew-olustur-wrapper").fadeOut(100);
});

$(".crew-var").click(function (e) {
  crew_wrap = true;
  $(".my-crew-wrapper").fadeIn(100);
  $(".crew-olustur-wrapper").fadeOut(100);
  $(".crew-list-wrapper").fadeOut(100);
  $(".crew-davetler-wrapper").fadeOut(100);
  $("#crewSearch").hide();
  $("#playerSearch").show();
  $(".crew-var").hide();
  $(".crew-name-btn").show();
  $(".crew-photo").show();
  refreshCrewlist(this.id);
});

$(".crew-sil").click(function (e) {
  $(".crew-onay-ui-wrapper").show()
});

$("#crew-sil").click(function (e) {
  $.post(`http://${GetParentResourceName()}/closecrew`);
  $.post(`https://${GetParentResourceName()}/ta-crew:client:menu-back`)
  $("body").fadeOut(100);
  $(".back").addClass("hide");
  $(".crew-onay-ui-wrapper").hide();
});

$("#crew-sil-iptal").click(function (e) {
  $(".crew-onay-ui-wrapper").hide()
});

// $(".crew-name-btn").click(function (e) {
//   $(".crew-name-wrapper").fadeIn(100)

//   $(".crew-name-button-ic").click(function(){
//     let name = $("#crew-degis-name").val()

//     if (name != ""){
//       $.post(`https://${GetParentResourceName()}/ta-crew:client:change-name`, JSON.stringify(name))
//     }
//   })
// });

$(".crew-photo").click(function (e) {
  $(".crew-photo-wrapper").fadeIn(100)

  $(".crew-photo-button").click(function(){
    let url = $("#crew-photo-name").val()

    if (url != ""){
      $.post(`https://${GetParentResourceName()}/ta-crew:client:change-photo`, JSON.stringify(url))
      $(".crew-photo-wrapper").hide()
      $.post(`https://${GetParentResourceName()}/ta-crew:client:menu-back`)
      $("body").fadeOut(100);
      $(".back").trigger( "click" );
      $(".back").addClass("hide");
    }
  })
});

$("#close-name").click(function (e) {
  $(".crew-name-wrapper").fadeOut(100)
});

$("#close-photo").click(function (e) {
  $(".crew-photo-wrapper").fadeOut(100)
});

function refreshCrewlist(crewName) {
  var crewInfo = crewData[crewName];
  $(".title-wrap .title").html(crewInfo.name);
  $(".mc-logo").attr("src", crewInfo.crewPhoto);
  currentPlayers = [];

  crewData[crewName].members.forEach(function (value) {
    currentPlayers.push(value);
  });
  crewData[crewName].leaders.forEach(function (value) {
    currentPlayers.push(value);
  });
  $.post(
    `http://${GetParentResourceName()}/ta-crew:fetchPlayerInformations`,
    JSON.stringify({
      players: currentPlayers,
      name: crewInfo.name,
      leaders: crewData[crewName].leaders,
    })
  );
}

$(".crew-invite-side").click(function (e) {
  $(".crew-invite-side-wrapper").fadeIn(100);
});

$("#close-invite-side").click(function (e) {
  $(".crew-invite-side-wrapper").fadeOut(100);
});

$(".crew-invite-side-button").click(function (e) {
  var id = $(".crew-invite-side-input").val();
  $.post(
    `http://${GetParentResourceName()}/ta-crew:sendInvite`,
    JSON.stringify({ playerId: id })
  );
  $(".crew-invite-side-wrapper").fadeOut(100);
});

$("#crew-olustur-profile").change(function () {
  $(".c-create-logo").attr("src", $("#crew-olustur-profile").val());
});
document.addEventListener("DOMContentLoaded", function (event) {
  document.querySelectorAll(".c-create-logo").forEach(function (img) {
    img.onerror = function () {
      this.style.display = "none";
    };
  });
});
