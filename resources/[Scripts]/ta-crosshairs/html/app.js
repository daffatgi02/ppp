$(function(){    
    $.post(`https://${GetParentResourceName()}/loadData`, JSON.stringify({}));
    LoadCrosshair(localStorage.getItem("ta-crosshair") ? localStorage.getItem('ta-crosshair') : "https://media.discordapp.net/attachments/1056647437411954758/1149772962136870922/Layer.png?width=57&height=57",
    localStorage.getItem("ta-crosshair:size") ? localStorage.getItem("ta-crosshair:size") : 40)

    window.addEventListener("message", function(event) {
        switch (event.data.action) {
            case 'openMenu':
                $('.container').fadeIn(100)
                $('.crosshair').show()
                $(".crosshair img").attr("src", localStorage.getItem("ta-crosshair"))
            break;

            case 'show':
                $('.crosshair').show()
            break;

            case 'hide':
                $('.crosshair').hide()
            break;

            case 'fake-show':
                $(".crosshair").fadeIn(0);
            break;

            case 'fake-hide':
                $(".crosshair").fadeOut(0);
            break;
        }
    });

    $(".save-btn").click(() => {
        let url = $(".url").val()

        if (url != ""){
            $(".crosshair img").attr("src", url)
            localStorage.setItem("ta-crosshair", url)
            CloseAll()
        }else{
            $(".crosshair img").attr("src", "https://media.discordapp.net/attachments/1056647437411954758/1149772962136870922/Layer.png?width=57&height=57")
            localStorage.setItem("ta-crosshair", "https://media.discordapp.net/attachments/1056647437411954758/1149772962136870922/Layer.png?width=57&height=57")
            CloseAll()
        }

        LoadCrosshair(localStorage.getItem("ta-crosshair"), localStorage.getItem("ta-crosshair:size"))
    })

    $(".size").on("change", function(){
        localStorage.setItem("ta-crosshair:size", $(this).val())
        $('.crosshair img').css('width', $(this).val())
    })
})

function CloseAll() {
    $('.container').fadeOut(100)
    $('.crosshair').hide()
    $.post(`https://${GetParentResourceName()}/exit`);
}

$(document).keyup((e) => {
    if (e.key === "Escape") {
        CloseAll()
    }
});

function LoadCrosshair(srcimgpe, size) {
    $('.crosshair img').attr('src', srcimgpe || '')
    $('.crosshair img').css('width', size || '30px')
    $(".url").val(srcimgpe)
    $(".size").val(size)
}