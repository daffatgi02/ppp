window.addEventListener("message", function(e){
    data = e.data;
    if (data.action == "out-of-zone") {
        $("main").fadeIn(600);
        $(".out-of-zone").fadeIn(600);
      }
      if (data.action == "out-of-zone-close") {
        $("main").fadeOut(600);
        $(".out-of-zone").fadeOut(600);
      }
      if (data.action == "roof-camp") {
        $("main").fadeIn(600);
        $(".roof-camp").fadeIn(600);
      }
      if (data.action == "roof-camp-close") {
        $("main").fadeOut(600);
        $(".roof-camp").fadeOut(600);
      }
})
