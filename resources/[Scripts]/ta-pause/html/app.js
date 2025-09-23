$(document).ready(function(){
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.open == true) {
            var xhr = new XMLHttpRequest();
            xhr.responseType = "text";
            xhr.open('GET', item.steamid, true);
            xhr.send();
            xhr.onreadystatechange = processRequest;
            function processRequest(e) {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var string = xhr.responseText.toString();
                }
            }
            var now = new Date();
            var day = now.getDate();
            var month = now.getMonth() + 1;
            var year = now.getFullYear();
            var hours = now.getHours();
            var minutes = now.getMinutes();

            var formattedDate = (day < 10 ? '0' : '') + day + '.' + (month < 10 ? '0' : '') + month + '.' + year;
            var formattedTime = (hours < 10 ? '0' : '') + hours + '.' + (minutes < 10 ? '0' : '') + minutes;

            var formattedDateTime = formattedDate + ', ' + formattedTime;
            $(".date").html(formattedDateTime)
            openPauseMenu();
        } else if (item.open == false) {
            closePauseMenu();
        }
    });
})

$(document).ready(function() {

    $(".elements").html("")
    $("#keybindings").html("")
    $("#serverinformation").html(aboutserver)
    $(".elements").append("<img src='"+ logo +"'>")
    $("#gobacktext").html(goBackText)

    let menuid = 0
    for (let menu of menus) {
        menuid = menuid + 1
        let classes = ""
        if (menu.defaultSelected == true) {
            classes = classes + " selected"
        }
        if (menu.isQuitMenu == true) {
            classes = classes + " quit"
        }

        let html = `
            <p class="${classes}" id="${menuid}" event="${menu.event}">${menu.text}</p>
        `
        $(".elements").append(html)
    }

    for (let keym of keys) {
        let html = `
            <span><div class="key">${keym.key}</div> &nbsp; <span style="float:left;">${keym.text}</span>  </span> 
        `
        $("#keybindings").append(html)
    }


    $(document).keydown(function(e) {
        if (e.keyCode === 38) { // Yukarı ok tuşu
            if ($(".selected").attr('id') == 1) {
                return
            }
            let sayi = Number($(".selected").attr('id')) - 1
            $(".selected").removeClass('selected')
            $("p[id='"+ sayi +"']").addClass('selected')
            menuSelectSound()
        } else if (e.keyCode === 40) { // Aşağı ok tuşu
            if ($(".selected").attr('id') == menuid) {
                return
            }
            let sayi = Number($(".selected").attr('id')) + 1
            $(".selected").removeClass('selected')
            $("p[id='"+ sayi +"']").addClass('selected')
            menuSelectSound()
        } else if (e.keyCode === 13) { // Enter tuşu
            menuSelectSound()
            let buttonaction = $(".selected").attr('event')
            openMenu(buttonaction)
        } else if (e.keyCode === 8) { // Enter tuşu
            menuSelectSound()
            $('.elements2').css('display', 'none')
            $('.elements2text').each(function(){
                $(this).hide()
            })
        }
    });

    $('.sound').click(function(){
        if($(this).children().hasClass('fa-volume-high')) {
            $(this).children().removeClass('fa-volume-high')
            $(this).children().addClass('fa-volume-xmark')
            // music(false)
            // localStorage.setItem('sound', 'off')
        } else {
            $(this).children().addClass('fa-volume-high')
            $(this).children().removeClass('fa-volume-xmark')
            // music(true)
            // localStorage.setItem('sound', 'on')
        }
    })

    async function menuSelectSound() {
        var sesOynatici = document.getElementById("sesOynatici2");
        sesOynatici.volume = 0.3;
        sesOynatici.play();
    }




    function openMenu(menuName) {
        $('.elements2text').each(function(){
            $(this).hide()
        })
        if (menuName == "about") {
            $("#serverinformation").show()
        } else if (menuName == "keybindings") {
            $("#keybindings").show()
        } else if (menuName == "map") {
            $.post('https://ta-pause/map');
            closePauseMenu()
            return
        } else if (menuName == "mainmenu") {
            $.post('https://ta-pause/mainmenu');
            return
        } else if (menuName == "settings") {
            $.post('https://ta-pause/settings');
            closePauseMenu()
            return
        } else if (menuName == "continue") {
            $.post('https://ta-pause/Close');
            closePauseMenu()
            return
        } else if (menuName == "quit") {
            $.post('https://ta-pause/DropPlayer');
            closePauseMenu()
            return
        } else if (menuName == "logout") {
            $.post('https://ta-pause/Logout');
            closePauseMenu()
            return
        }
        $('.elements2').css('display', 'flex')
    }

    $($(".elements").children()).each(function(){
        $(this).click(function(){
            menuSelectSound()
            $(".selected").removeClass('selected')
            $(this).addClass('selected')
            let buttonaction = $(this).attr('event')
            openMenu(buttonaction)
        })
    })

    $("#gobacks").click(function(){
        menuSelectSound()
        $('.elements2').css('display', 'none')
        $('.elements2text').each(function(){
            $(this).hide()
        })
    })


});

function openPauseMenu() {
    $("body").show()
    // if (! localStorage.getItem('sound')) {
        // localStorage.setItem('sound', 'on')
        // music(true)
    // } else {
        // if (localStorage.getItem('sound') == 'on') {
            // music(true)
        // } else {
            // music(false)
            // $('.sound').children().removeClass('fa-volume-high')
            // $('.sound').children().addClass('fa-volume-xmark')
        // }
    // }
}

function closePauseMenu() {
    $("body").hide()
    // music(false)
}

// function music(bool) {
//     let sesOynatici = document.getElementById("sesOynatici3");
//     if (bool == true) {
//         sesOynatici.volume = soundVolume;
//         sesOynatici.play();
//     } else {
//         sesOynatici.pause();
//     }
// }

document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") { 
        closePauseMenu();
        $.post('https://ta-pause/Close');
    }
});

