var arr = ["Seni şişledi!", "Derini yüzdü!", "Bu acıtmış olmalı!", "Yere fırlattı!"]

$('document').ready(function(){
    window.addEventListener('message', function(event) {
        var item = event.data;  
        var screentime = item.screentime
        if (item.type == "death"){
          setTimeout(function(){
          $(".bg").animate({opacity: '1'}, 500);
        }, 1300);
        $(".bg").css({"display": "block"})
          let msg = item.message == "0" ? "Yerde Kal." : item.message 
          $(".player-photo").css({"background-image": "url("+item.plyAvatar+")"})
          $(".player-name").text(item.plyName)
          $(".player-msg").text(msg)
          $(".player-health-armor").html('<p><i class="fas fa-heartbeat" style="font-size: 15px; margin-right: 5.5px; margin-bottom:-2px;"></i><b>'+item.health+'</b>&nbsp;&nbsp;  <i class="fas fa-shield-alt" style="font-size: 15px; margin-right: 5.5px; margin-bottom:-2px;"></i><b>'+item.armor+'</b></p>')
          setTimeout(function(){
            $(".bg").animate({opacity: '0'}, 500);
            setTimeout(function(){
              $(".bg").css({'display':'none'});
            }, screentime)
            
          }, screentime);
        }
    })
})