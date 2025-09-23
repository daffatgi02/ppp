window.addEventListener('message', (event) => {
    let item = event.data;
    if (item.type === 'enable') {
        $(".logo").fadeIn(200);
        $(".general-text").html("<b>"+item.gamemode+"</b>")
        $(".general-text").fadeIn(200);
        $(".discord-text").fadeIn(200);
        $(".general-text").css({'color':'rgb(255, 255, 255)'});
    }
    if (item.type === 'disable') {
        $(".logo").fadeOut(200);
        $(".general-text").fadeOut(200);
        $(".discord-text").fadeOut(200);
    }
    if (item.type === 'fake-hide') {
        $(".logo").fadeOut(200);
        $(".discord-text").fadeOut(200);
        $(".general-text").css({'color':'rgb(255, 255, 255, 0)'});
    }
    if (item.type === 'fake-show') {
        $(".logo").fadeIn(200);
        $(".discord-text").fadeIn(200);
        $(".general-text").css({'color':'rgb(255, 255, 255)'});
    }
})