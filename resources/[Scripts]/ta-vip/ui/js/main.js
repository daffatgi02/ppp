let loggedIn = false
var colorInput = null
var msgInput = null
var bannerInput = null
var mainScreen = null

$(function(){

    window.addEventListener("message", function(e){
        data = e.data

        if (data.action == "open"){
            $("body").fadeIn(100);

            if (!loggedIn){
                loggedIn = true
                if(data.vip.vip > Date.now()){
                    $(".setting").removeClass("disabled")
                    addFunctions()
                }else{
                    $(".setting").addClass("disabled")
                }
            }
        }
    })

    $(".reset-btn").click(function(){
        window.invokeNative('openUrl', 'https://discord.gg/turkishacademy/')
    })
})


function addFunctions(){

    $("#nickBtn").click(function(e){
        $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'System', title: "V.I.P", message: "Click anywhere on the screen to confirm.", time: 15000}))
        if (colorInput) colorInput.remove()

		colorInput = $(`<div class="color-input-wrapper"> 
			<div class="color-input-background"> </div>
			<input type="color" class="color-input" id="colorInput" style="--x: ${e.clientX}px; --y: ${e.clientY}px;" />
		</div>`)

		$("body").append(colorInput)

		$(".color-input-background").click(() => {
            $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'System', title: "V.I.P", message: "Name color successfully set!", time: 15000}))
        
            $.post(`https://${GetParentResourceName()}/setNickColor`, JSON.stringify($("#colorInput").val().slice(1, 7)))
            
			if (colorInput) {
				colorInput.remove()
				colorInput = null
			}
		})

		colorInput.on("change input", (e) => {
			var hex = e.target.value.substr(1).match(/.{1,2}/g)
			var rgb = [parseInt(hex[0], 16), parseInt(hex[1], 16), parseInt(hex[2], 16)]

			$(this).attr("style", `--color: rgb(${rgb.join(",")}); --colorBg: rgba(${rgb.join(",")},0.3)`)
		})
    })
    $("#messageBtn").click(function(e){
        $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'System', title: "V.I.P", message: "Click anywhere on the screen to confirm.", time: 15000}))
        if (msgInput) msgInput.remove()

		msgInput = $(`<div class="color-input-wrapper"> 
			<div class="color-input-background"> </div>

            <select id="msgInput" class="color-input" style="--x: ${e.clientX}px; --y: ${e.clientY}px;">
                <option value="Stay Down!">Stay Down!</option>
                <option value="Close your team!">Close your team!</option>
                <option value="Delete the game ^^">Delete the game ^^</option>
                <option value="You're on the ground, boy.">You're on the ground, boy.</option>
                <option value="Armless son of a bitch.">Armless son of a bitch.</option>
                <option value="Fuck you.">Fuck you.</option>
            </select>
		</div>`)

		$("body").append(msgInput)

		$(".color-input-background").click(() => {
            $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'System', title: "V.I.P", message: "The message of death has been successfully calibrated!", time: 15000}))
            $.post(`https://${GetParentResourceName()}/setDeathMessage`, JSON.stringify($("#msgInput").val()))
            
			if (msgInput) {
				msgInput.remove()
				msgInput = null
			}
		})
    })
    $("#bannerBtn").click(function(){
        
    })
    $("#mainBtn").click(function(e){
        $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'System', title: "V.I.P", message: "Click anywhere on the screen to confirm.", time: 15000}))
        if (mainScreen) mainScreen.remove()

		mainScreen = $(`<div class="color-input-wrapper"> 
			<div class="color-input-background"> </div>

            <select id="mainScreen" class="color-input" style="--x: ${e.clientX}px; --y: ${e.clientY}px;">
                <option value="0">Default Screen</option>
                <option value="1">VIP Screen</option>
                <option value="2">VIP Screen 2</option>
                <option value="3">VIP Screen 3</option>
            </select>
		</div>`)

		$("body").append(mainScreen)

		$(".color-input-background").click(() => {
            $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'System', title: "V.I.P", message: "Home screen position successfully set!", time: 15000}))
            $.post(`https://${GetParentResourceName()}/setMainScreen`, JSON.stringify($("#mainScreen").val()))
            
			if (mainScreen) {
				mainScreen.remove()
				mainScreen = null
			}
		})
    })
    $("#pedBtn").click(function(){
        
    })
}

function back(){
    $("body").fadeOut(100);
    $.post(`https://${GetParentResourceName()}/close`)
}