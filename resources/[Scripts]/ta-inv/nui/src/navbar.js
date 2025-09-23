$(document).on("click", ".navbar-buttons-contain > button", function() {
    if ($(this).find("p").hasClass("active")) return
    const index = $(this).attr("name")
    ImageAnimation($(this).find("p"))
    $(".navbar-buttons-contain > button > p").removeClass("active")
    $(this).find("p").addClass("active")
    $(".gfxinv-main-contain").css("display", "none")
    $(".gfxlb-main-contain").css("display", "none")
    $(".gfxprofile-main-contain").css("display", "none")
    if (index == "inventory") {
        $(".gfxinv-main-contain").css("display", "flex")
    }
})

ImageAnimation = (object) => {
    $(".menuImage").remove()
    $(object).parent().append('<img class="menuImage" src="assets/invassets/tradelogo.png" alt="">')
}