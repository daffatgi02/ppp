$(function() {
    let editMode = false
    setPositions()
    
    window.addEventListener("message", function (event){
        let data = event.data;

        if (data.action == "notify") { 
            const Data = {
                title: event.data.title,
                text: event.data.message,
                time: event.data.time,
                appname: event.data.appname,
                icon: event.data.icon,
                iconcolor: event.data.iconcolor,
              }

            ShowNotification(Data)
        }

        if (data.action == "show_text") { 
            $(".killed-text").html("<l style='color:white'> KILLED </l><l style='color:red'>" + data.playername.toUpperCase() + "</l>");
            $(".killed-text").fadeIn(550);
        }

        if (data.action == "hide_text") {
            $(".killed-text").fadeOut(700);
        }
        
        if (data.action == "reset") {
            $.post(`https://ta-hud/notify`, JSON.stringify({icon: 'fab fa-cc-visa text-info', appname: 'System', title: "HUD", message: "Settings successfully reset", time: 10000}))
            localStorage.removeItem("editablePositions")
            $(".hud").css({
                'right': '2vw',
                'bottom': '2vh',
                'top': 'auto',
                'left': 'auto',
            })
            $(".kill-feed-wrapper").css({
                'right': '2vw',
                'top': '2vh',
                'bottom': 'auto',
                'left': 'auto',
            })
            $(".killed-text").css({
                'right': 'auto',
                'top': '80vh',
                'bottom': 'auto',
                'left': 'left',
            })
        }
    
        if (data.action == "addFeed"){
            let msg = data.data
            let weapon = msg.weapon.slice(7)
            var id = Math.floor((Math.random() * 1000000) + 1);
            let crewName = msg.killerCrewName ? `<font color="${msg.killerCrewColor}">[${msg.killerCrewName}]</font> ` : ''
            let victimCrewName = msg.victimCrewName ? `<font color="${msg.victimCrewColor}">[${msg.victimCrewName}]</font> ` : ''
            $(".kill-feed-wrapper").append(`
                <div class="kill-feed id-${id}">
                    <div class="other">
                        <div class="streak">
                            <span>${msg.streak}x</span>
                            <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M4.90007 5.6V7C5.67327 7 6.30003 6.37322 6.30003 5.6H4.90007ZM4.90007 5.6H3.50012C3.50012 6.37322 4.1269 7 4.90007 7V5.6ZM4.90007 5.6V4.2C4.1269 4.2 3.50012 4.8268 3.50012 5.6H4.90007ZM4.90007 5.6H6.30003C6.30003 4.8268 5.67327 4.2 4.90007 4.2V5.6ZM9.09993 5.6V7C9.87312 7 10.4999 6.37322 10.4999 5.6H9.09993ZM9.09993 5.6H7.69998C7.69998 6.37322 8.32674 7 9.09993 7V5.6ZM9.09993 5.6V4.2C8.32674 4.2 7.69998 4.8268 7.69998 5.6H9.09993ZM9.09993 5.6H10.4999C10.4999 4.8268 9.87312 4.2 9.09993 4.2V5.6ZM5.27212 14H8.72789V12.6H5.27212V14ZM12.2419 9.1511L13.1162 8.62652L12.3959 7.42602L11.5216 7.9506L12.2419 9.1511ZM2.47836 7.9506L1.6041 7.42602L0.883827 8.62652L1.75809 9.1511L2.47836 7.9506ZM4.90007 12.2279C4.90007 11.4498 4.90625 10.9251 4.76968 10.4389L3.42188 10.8174C3.49394 11.074 3.50012 11.3683 3.50012 12.2279H4.90007ZM1.75809 9.1511C2.49522 9.59336 2.74438 9.75009 2.92727 9.94385L3.94533 8.98289C3.59865 8.6156 3.14562 8.35093 2.47836 7.9506L1.75809 9.1511ZM4.76968 10.4389C4.61665 9.89401 4.33379 9.39442 3.94533 8.98289L2.92727 9.94385C3.16035 10.1908 3.33007 10.4905 3.42188 10.8174L4.76968 10.4389ZM10.4999 12.2279C10.4999 11.3683 10.506 11.074 10.5781 10.8174L9.23034 10.4389C9.09377 10.9251 9.09993 11.4498 9.09993 12.2279H10.4999ZM11.5216 7.9506C10.8544 8.35093 10.4013 8.6156 10.0547 8.98289L11.0727 9.94385C11.2556 9.75009 11.5048 9.59336 12.2419 9.1511L11.5216 7.9506ZM10.5781 10.8174C10.6699 10.4905 10.8396 10.1908 11.0727 9.94385L10.0547 8.98289C9.66621 9.39442 9.38335 9.89401 9.23034 10.4389L10.5781 10.8174ZM8.72789 14C8.89113 14 9.05086 14.0004 9.18568 13.9906C9.32735 13.9804 9.49507 13.9562 9.66747 13.8798L9.09993 12.6C9.13682 12.5836 9.15012 12.5896 9.08446 12.5943C9.01194 12.5996 8.9115 12.6 8.72789 12.6V14ZM9.09993 12.2279C9.09993 12.4116 9.09951 12.512 9.09426 12.5845C9.0895 12.6502 9.08355 12.6369 9.09993 12.6L10.3797 13.1676C10.4561 12.9951 10.4803 12.8274 10.4905 12.6857C10.5003 12.5509 10.4999 12.3912 10.4999 12.2279H9.09993ZM9.66747 13.8798C9.98498 13.739 10.2389 13.4851 10.3797 13.1676L9.09993 12.6L9.66747 13.8798ZM5.27212 12.6C5.08849 12.6 4.98804 12.5996 4.91556 12.5943C4.84991 12.5896 4.86318 12.5836 4.90007 12.6L4.3325 13.8798C4.50492 13.9562 4.67266 13.9804 4.81434 13.9906C4.94918 14.0004 5.10888 14 5.27212 14V12.6ZM3.50012 12.2279C3.50012 12.3912 3.49969 12.5509 3.50947 12.6857C3.51973 12.8274 3.54387 12.9951 3.62033 13.1676L4.90007 12.6C4.91643 12.6369 4.91051 12.6502 4.90576 12.5845C4.9005 12.512 4.90007 12.4116 4.90007 12.2279H3.50012ZM4.90007 12.6L3.62033 13.1676C3.76116 13.4852 4.01499 13.739 4.3325 13.8798L4.90007 12.6ZM1.40019 7C1.40019 3.9072 3.90731 1.4 7 1.4V0C3.13414 0 0.000240752 3.134 0.000240752 7H1.40019ZM7 1.4C10.0927 1.4 12.5998 3.9072 12.5998 7H13.9998C13.9998 3.134 10.8658 0 7 0V1.4ZM0.000240752 7V7.06587H1.40019V7H0.000240752ZM12.5998 7V7.06587H13.9998V7H12.5998ZM1.6041 7.42602C1.49817 7.36246 1.44428 7.32977 1.40651 7.30401C1.37529 7.28273 1.38374 7.28497 1.40019 7.30366L0.348871 8.22815C0.509963 8.41134 0.725213 8.53132 0.883827 8.62652L1.6041 7.42602ZM0.000240752 7.06587C0.000240752 7.25088 -0.00762699 7.49714 0.0665915 7.72954L1.40019 7.30366C1.40777 7.32739 1.40535 7.33579 1.40314 7.29806C1.40047 7.25242 1.40019 7.18942 1.40019 7.06587H0.000240752ZM1.40019 7.30366L0.0665915 7.72954C0.125312 7.91343 0.221412 8.08318 0.348871 8.22815L1.40019 7.30366ZM13.1162 8.62652C13.2748 8.53132 13.49 8.41134 13.6511 8.22815L12.5998 7.30366C12.6163 7.28497 12.6247 7.28273 12.5935 7.30401C12.5557 7.32977 12.5018 7.36246 12.3959 7.42602L13.1162 8.62652ZM12.5998 7.06587C12.5998 7.18942 12.5995 7.25242 12.5969 7.29806C12.5946 7.33579 12.5922 7.32739 12.5998 7.30366L13.9334 7.72954C14.0076 7.49714 13.9998 7.25088 13.9998 7.06587H12.5998ZM13.6511 8.22815C13.7786 8.08318 13.8747 7.91343 13.9334 7.72954L12.5998 7.30366L13.6511 8.22815Z" fill="white"/>
                            </svg>
                        </div>
                        <div class="distance">
                            <span>${msg.dist}</span>
                            <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M4.07761 0.0234063C4.49433 0.127587 4.74769 0.549855 4.64351 0.966578L1.53247 13.4107C1.4283 13.8274 1.00603 14.0808 0.589311 13.9766C0.172588 13.8724 -0.0807744 13.4502 0.0234063 13.0335L3.13444 0.589311C3.23862 0.172588 3.66089 -0.0807744 4.07761 0.0234063ZM10.8655 0.589311L13.9766 13.0335C14.0808 13.4502 13.8274 13.8724 13.4107 13.9766C12.994 14.0808 12.5717 13.8274 12.4676 13.4107L9.35654 0.966578C9.25232 0.549855 9.50572 0.127587 9.92244 0.0234063C10.3392 -0.0807744 10.7614 0.172588 10.8655 0.589311ZM7.00001 10.8888C7.39889 10.8888 7.72761 11.189 7.77254 11.5759L7.77777 11.6666V13.2221C7.77777 13.6516 7.42957 13.9998 7.00001 13.9998C6.60114 13.9998 6.27241 13.6996 6.22749 13.3128L6.22225 13.2221V11.6666C6.22225 11.237 6.57046 10.8888 7.00001 10.8888ZM7.00001 5.44449C7.42957 5.44449 7.77777 5.7927 7.77777 6.22225V7.77776C7.77777 8.20733 7.42957 8.55552 7.00001 8.55552C6.57046 8.55552 6.22225 8.20733 6.22225 7.77776V6.22225C6.22225 5.7927 6.57046 5.44449 7.00001 5.44449ZM7.00001 0.00018242C7.39889 0.00018242 7.72761 0.300431 7.77254 0.687238L7.77777 0.777941V2.33346C7.77777 2.763 7.42957 3.11121 7.00001 3.11121C6.60114 3.11121 6.27241 2.81097 6.22749 2.42416L6.22225 2.33346V0.777941C6.22225 0.3484 6.57046 0.00018242 7.00001 0.00018242Z" fill="white"/>
                            </svg>
                        </div>
                    </div>
                    <div class="wrapper">
                        <div class="killer-name" style="color: #${msg.killerColor} !important">${crewName}${msg.killerName}(${msg.attackerId})</div>
                        <img src="assets/weapons/${weapon}.png" class="killer-weapon">
                        ${msg.headshot ? '<img src="assets/headshot.png" class="killer-weapon">' : ''}
                        ${msg.driveby ? '<img src="assets/driveby.png" class="killer-weapon">' : ''}
                        <div class="victim-name" style="color: #${msg.victimColor} !important">${victimCrewName}${msg.victimName}(${msg.victimId})</div>
                    </div>
                </div>
            `)

            $(`.id-${id}`).hide()
            $(`.id-${id}`).fadeIn(300)

            setTimeout(function () {
                anime({
                    targets: `.id-${id}`,
                    opacity: 0,
                    duration: 750,
                    easing: 'spring(1, 80, 100, 5)'
                })
                setTimeout(function () {
                    $(`.id-${id}`).remove()
                }, 750)
            }, 6500)
        }

        if(data.action == "addStreak"){
            $("#streak").text(data.streak+"x")
            $(".streak").fadeIn(300)
        }

        if(data.action == "resetStreak"){
            $("#streak").text("0x")
            $(".streak").fadeOut(300)
        }

        if(data.action == "editing"){
            if (data.type == "hud"){
                $("main .hud").css({'display':'block'});
            }else if(data.type == "killfeed"){
                $(".kill-feed-wrapper").append(`
                <div class="kill-feed editingEl">
                    <div class="other">
                        <div class="streak">
                            <span>20x</span>
                            <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M4.90007 5.6V7C5.67327 7 6.30003 6.37322 6.30003 5.6H4.90007ZM4.90007 5.6H3.50012C3.50012 6.37322 4.1269 7 4.90007 7V5.6ZM4.90007 5.6V4.2C4.1269 4.2 3.50012 4.8268 3.50012 5.6H4.90007ZM4.90007 5.6H6.30003C6.30003 4.8268 5.67327 4.2 4.90007 4.2V5.6ZM9.09993 5.6V7C9.87312 7 10.4999 6.37322 10.4999 5.6H9.09993ZM9.09993 5.6H7.69998C7.69998 6.37322 8.32674 7 9.09993 7V5.6ZM9.09993 5.6V4.2C8.32674 4.2 7.69998 4.8268 7.69998 5.6H9.09993ZM9.09993 5.6H10.4999C10.4999 4.8268 9.87312 4.2 9.09993 4.2V5.6ZM5.27212 14H8.72789V12.6H5.27212V14ZM12.2419 9.1511L13.1162 8.62652L12.3959 7.42602L11.5216 7.9506L12.2419 9.1511ZM2.47836 7.9506L1.6041 7.42602L0.883827 8.62652L1.75809 9.1511L2.47836 7.9506ZM4.90007 12.2279C4.90007 11.4498 4.90625 10.9251 4.76968 10.4389L3.42188 10.8174C3.49394 11.074 3.50012 11.3683 3.50012 12.2279H4.90007ZM1.75809 9.1511C2.49522 9.59336 2.74438 9.75009 2.92727 9.94385L3.94533 8.98289C3.59865 8.6156 3.14562 8.35093 2.47836 7.9506L1.75809 9.1511ZM4.76968 10.4389C4.61665 9.89401 4.33379 9.39442 3.94533 8.98289L2.92727 9.94385C3.16035 10.1908 3.33007 10.4905 3.42188 10.8174L4.76968 10.4389ZM10.4999 12.2279C10.4999 11.3683 10.506 11.074 10.5781 10.8174L9.23034 10.4389C9.09377 10.9251 9.09993 11.4498 9.09993 12.2279H10.4999ZM11.5216 7.9506C10.8544 8.35093 10.4013 8.6156 10.0547 8.98289L11.0727 9.94385C11.2556 9.75009 11.5048 9.59336 12.2419 9.1511L11.5216 7.9506ZM10.5781 10.8174C10.6699 10.4905 10.8396 10.1908 11.0727 9.94385L10.0547 8.98289C9.66621 9.39442 9.38335 9.89401 9.23034 10.4389L10.5781 10.8174ZM8.72789 14C8.89113 14 9.05086 14.0004 9.18568 13.9906C9.32735 13.9804 9.49507 13.9562 9.66747 13.8798L9.09993 12.6C9.13682 12.5836 9.15012 12.5896 9.08446 12.5943C9.01194 12.5996 8.9115 12.6 8.72789 12.6V14ZM9.09993 12.2279C9.09993 12.4116 9.09951 12.512 9.09426 12.5845C9.0895 12.6502 9.08355 12.6369 9.09993 12.6L10.3797 13.1676C10.4561 12.9951 10.4803 12.8274 10.4905 12.6857C10.5003 12.5509 10.4999 12.3912 10.4999 12.2279H9.09993ZM9.66747 13.8798C9.98498 13.739 10.2389 13.4851 10.3797 13.1676L9.09993 12.6L9.66747 13.8798ZM5.27212 12.6C5.08849 12.6 4.98804 12.5996 4.91556 12.5943C4.84991 12.5896 4.86318 12.5836 4.90007 12.6L4.3325 13.8798C4.50492 13.9562 4.67266 13.9804 4.81434 13.9906C4.94918 14.0004 5.10888 14 5.27212 14V12.6ZM3.50012 12.2279C3.50012 12.3912 3.49969 12.5509 3.50947 12.6857C3.51973 12.8274 3.54387 12.9951 3.62033 13.1676L4.90007 12.6C4.91643 12.6369 4.91051 12.6502 4.90576 12.5845C4.9005 12.512 4.90007 12.4116 4.90007 12.2279H3.50012ZM4.90007 12.6L3.62033 13.1676C3.76116 13.4852 4.01499 13.739 4.3325 13.8798L4.90007 12.6ZM1.40019 7C1.40019 3.9072 3.90731 1.4 7 1.4V0C3.13414 0 0.000240752 3.134 0.000240752 7H1.40019ZM7 1.4C10.0927 1.4 12.5998 3.9072 12.5998 7H13.9998C13.9998 3.134 10.8658 0 7 0V1.4ZM0.000240752 7V7.06587H1.40019V7H0.000240752ZM12.5998 7V7.06587H13.9998V7H12.5998ZM1.6041 7.42602C1.49817 7.36246 1.44428 7.32977 1.40651 7.30401C1.37529 7.28273 1.38374 7.28497 1.40019 7.30366L0.348871 8.22815C0.509963 8.41134 0.725213 8.53132 0.883827 8.62652L1.6041 7.42602ZM0.000240752 7.06587C0.000240752 7.25088 -0.00762699 7.49714 0.0665915 7.72954L1.40019 7.30366C1.40777 7.32739 1.40535 7.33579 1.40314 7.29806C1.40047 7.25242 1.40019 7.18942 1.40019 7.06587H0.000240752ZM1.40019 7.30366L0.0665915 7.72954C0.125312 7.91343 0.221412 8.08318 0.348871 8.22815L1.40019 7.30366ZM13.1162 8.62652C13.2748 8.53132 13.49 8.41134 13.6511 8.22815L12.5998 7.30366C12.6163 7.28497 12.6247 7.28273 12.5935 7.30401C12.5557 7.32977 12.5018 7.36246 12.3959 7.42602L13.1162 8.62652ZM12.5998 7.06587C12.5998 7.18942 12.5995 7.25242 12.5969 7.29806C12.5946 7.33579 12.5922 7.32739 12.5998 7.30366L13.9334 7.72954C14.0076 7.49714 13.9998 7.25088 13.9998 7.06587H12.5998ZM13.6511 8.22815C13.7786 8.08318 13.8747 7.91343 13.9334 7.72954L12.5998 7.30366L13.6511 8.22815Z" fill="white"/>
                            </svg>
                        </div>
                        <div class="distance">
                            <span>18m</span>
                            <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M4.07761 0.0234063C4.49433 0.127587 4.74769 0.549855 4.64351 0.966578L1.53247 13.4107C1.4283 13.8274 1.00603 14.0808 0.589311 13.9766C0.172588 13.8724 -0.0807744 13.4502 0.0234063 13.0335L3.13444 0.589311C3.23862 0.172588 3.66089 -0.0807744 4.07761 0.0234063ZM10.8655 0.589311L13.9766 13.0335C14.0808 13.4502 13.8274 13.8724 13.4107 13.9766C12.994 14.0808 12.5717 13.8274 12.4676 13.4107L9.35654 0.966578C9.25232 0.549855 9.50572 0.127587 9.92244 0.0234063C10.3392 -0.0807744 10.7614 0.172588 10.8655 0.589311ZM7.00001 10.8888C7.39889 10.8888 7.72761 11.189 7.77254 11.5759L7.77777 11.6666V13.2221C7.77777 13.6516 7.42957 13.9998 7.00001 13.9998C6.60114 13.9998 6.27241 13.6996 6.22749 13.3128L6.22225 13.2221V11.6666C6.22225 11.237 6.57046 10.8888 7.00001 10.8888ZM7.00001 5.44449C7.42957 5.44449 7.77777 5.7927 7.77777 6.22225V7.77776C7.77777 8.20733 7.42957 8.55552 7.00001 8.55552C6.57046 8.55552 6.22225 8.20733 6.22225 7.77776V6.22225C6.22225 5.7927 6.57046 5.44449 7.00001 5.44449ZM7.00001 0.00018242C7.39889 0.00018242 7.72761 0.300431 7.77254 0.687238L7.77777 0.777941V2.33346C7.77777 2.763 7.42957 3.11121 7.00001 3.11121C6.60114 3.11121 6.27241 2.81097 6.22749 2.42416L6.22225 2.33346V0.777941C6.22225 0.3484 6.57046 0.00018242 7.00001 0.00018242Z" fill="white"/>
                            </svg>
                        </div>
                    </div>
                    <div class="wrapper">
                        <div class="killer-name">Edit Mode</div>
                        <img src="assets/weapons/pistol.png" class="killer-weapon">
                        <img src="assets/headshot.png" class="killer-weapon">
                        <img src="assets/driveby.png" class="killer-weapon">
                        <div class="victim-name">Edit Mode</div>
                    </div>
                </div>
            `)
            }else{
                $(".killed-text").html("<l style='color:white'> KILLED </l><l style='color:red'> TEST </l>");
                $(".killed-text").show();
            }
        }
        if(data.action == "sehidininami"){
            if(data.durum == true){
                $("main .hud").css({'display':'block'});
            } else {
                $("main .hud").css({'display':'none'});
            }
        }
        if(data.action == "player"){
            $(".health .main-bar svg").attr("width", convertValue(data.health, 0, 100, 0, 251));
            $(".armor .main-bar svg").attr("width", convertValue(data.armor, 0, 100, 0, 251));
            $(".health .main-bar svg").attr("viewBox", `0 0 ${convertValue(data.health, 0, 100, 0, 251)} 20`);
            $(".armor .main-bar svg").attr("viewBox", `0 0 ${convertValue(data.armor, 0, 100, 0, 251)} 20`);
    
            if(data.isArmed) {
                $(".weapon").fadeIn(300)
                $(".streak").css("right", "159px")
                $(".streak .content").css("padding-right", "10px")
                $(".streak .bg-1").show()
                $(".streak .bg-2").hide()
                $(".ammo").text(data.clipAmmo);
                $(".ammo-clip").text("/"+data.ammoLeft);
                $(".weapon-img img").attr("src", "assets/weapons/"+data.gunHash.slice(7)+".png");
            }else{
                $(".streak .bg-1").hide()
                $(".streak .bg-2").show()
                $(".streak .content").css("padding-right", "0px")
                $(".streak").css("right", "0px")
                $(".weapon").fadeOut(300)
            }
        }
    })

    $.post(`https://${GetParentResourceName()}/uiLoaded`)

    $(".editable").draggable({
		cursor: "move",
		start: function (e) {
			const $target = $(e.target)

			$target.css({
				right: "auto",
				bottom: "auto",
			})
		},
		stop: function (e, ui) {
			const target = e.target
			const className = target.classList[0]

			const positions = JSON.parse(localStorage.getItem("editablePositions"))

			localStorage.setItem("editablePositions", JSON.stringify({...positions, [className]: ui.position,}))
		},
	})

    $(window).on("keydown", function ({ originalEvent: { key } }) {
        if (key == "Escape") {
            $(".killed-text").html("");
            $(".killed-text").hide();
            $(".editingEl").remove()
            $.post(`https://${GetParentResourceName()}/saveHud`)
            $("main .hud").css({'display':'none'});
        }
    })
})

const convertValue = (value, oldMin, oldMax, newMin, newMax) => {
	const oldRange = oldMax - oldMin
	const newRange = newMax - newMin
	const newValue = ((value - oldMin) * newRange) / oldRange + newMin
	return newValue
}

function setPositions() {
	var editablePositions = localStorage.getItem("editablePositions")

	if (editablePositions) {
		editablePositions = JSON.parse(editablePositions)

		for (const className in editablePositions) {
			const { top, left } = editablePositions[className]

			$(`.${className}`).css({
				position: "absolute",
				top: `${top}px`,
				right: "auto",
				bottom: "auto",
				left: `${left}px`,
			})
		}
	}
}

const notificationList = document.querySelector('.ios-notifications')

function ShowNotification(item) {
    const li = document.createElement('li')
    li.classList.add('ios-notifications__item')
    li.innerHTML = `
            <div class="mb-1 flex justify-between text-xs">
                <div>
                    <i class="${item.icon}" style="color:#${item.iconcolor};"> </i>
                    <span class="text-font">${item.appname}</span>
                </div>
            </div>
            <div class="text-sm font-bold text-font">${item.title}</div>
            <div class="text-sm text-font">${item.text}</div> 
        `
    notificationList.prepend(li)

    setTimeout(() => {
        li.classList.add('notif-hide')

        $(".notification:first-child").remove();

    }, item.time);
}