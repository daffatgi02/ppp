OtherInventoryType = null
ShiftPressed = false
ControlPressed = false
Config = null
LastOtherInv = null
Items = []

FormatMoney = money => {
    return Config.MoneyFormat ? (money).toLocaleString('en-US', {
        style: 'currency',
        currency: 'USD',
    }) : money
}

$(document).ready(function(){
    $.get("../config/jsconfig.json", function(data) {
        if(data) {
            Config = typeof data === 'string' ? JSON.parse(data) : data
        }
    })
})

window.addEventListener("message", function(e) {
    const data = e.data
    if (data.type == "display") {
        Display(data)
    } else if (data.type == "update") {
        UpdateInventory(data)
    } else if (data.type == "hotbar") {
        SetHotbar(data.hotbar)
    } else if (data.type == "setItems") {
        Items = data.items
    } else if (data.type == "playerInfo") {
        SetPlayerInfos(data.playerInfo)
    }
})

UpdateInventory = data => {
    if(data.inventory){
        LoadPlayerInventory(data.inventory)
    }
    if (data.inventoryInfo) {
        SetInventorySettings(data.inventoryInfo)
    }
    handleDragDrop()
}

Display = data => {
    if (data.bool) {
        if (Config && Config.SecondaryInventoryTypes && Config.SecondaryInventoryTypes[data.inventoryInfo.name]) {
            $(".gfxinv-main-contain").addClass("stash-active-main")
        } else {
            $(".gfxinv-main-contain").removeClass("stash-active-main")
        }
        SetInventorySettings(data.inventoryInfo)
        LoadPlayerInventory(data.inventory)
        if (data.money || data.money == 0) {
            SetMoneyData(data.money)
        }
        SetLevelData(data.level, data.money, data.tacoin, data.exp)
        $(".bg").show()
        $(".gfxinv-main-contain").css("display", "flex")
        $(".gfxinv-navbar").css("display", "flex")
        handleDragDrop()
    } else {
        OtherInventoryType = null
        $(".bg").hide()
        $(".gfxinv-navbar").css("display", "none")
        $(".gfxinv-main-contain").css("display", "none")
        $(".gfxinv-navbar").css("display", "none")
        $(".gfxlb-main-contain").css("display", "none")
        $(".gfxprofile-main-contain").css("display", "none")
        $(".navbar-buttons-contain > button > p").removeClass("active")
        const invObject = $(".navbar-buttons-contain").find(`[name=inventory]`)
        $(".navbar-buttons-contain > button").eq(invObject.index()).find("p").addClass("active")
        $(".menuImage").remove()
        invObject.append('<img class="menuImage" src="assets/invassets/tradelogo.png" alt="">')
    
        // $(".header-category > button > p").removeClass("active")
        // $(".header-category > button > p").eq(0).addClass("active")
        $(".order-key").eq(0).html("SCORE")
        CurrentOrder = "kill"
    }
}

DragItem = (data) => {
    const toInventory = $(data.toType == "inventory" ? ".gfxinv-player-inv" : ".gfxinv-protected-inv").find(".gfxinv-inv-content")
    const fromInventory = $(data.fromType == "inventory" ? ".gfxinv-player-inv" : ".gfxinv-protected-inv").find(".gfxinv-inv-content")
    const toObject = toInventory.find(`[data-key=${data.itemName}]`)
    const fromObject = fromInventory.find(`[data-key=${data.itemName}]`)
    const fromData = fromObject.data("itemdata")
    const toData = toObject.data("itemdata")
    if (toObject && toData) {
        toData.itemCount += data.count
        toObject.data("itemdata", toData)
        $(".item-slot-weight > p").html(toData.itemCount + "x");

    } else {
        const content = `
            <div class="gfxinv-item-slot ${Items[data.itemName].rarity}-item" data-key=${data.itemName} data-itemdata=${JSON.stringify({itemName: data.itemName, itemCount: data.count, currentContainer: data.toType, weight: data.weight})}>
            <img class="item-slot-image" src=${Items[data.itemName].image} alt="">
            <div class="item-slot-info">
                <h1>${Items[data.itemName].label.toUpperCase()}</h1>

            </div>
            <div class="item-slot-weight">
                <p>${data.count}x</p>
            </div>
        </div>
        `
        toInventory.append(content);
    }
    fromData.itemCount -= data.count
    if (fromData.itemCount <= 0) {
        fromObject.remove()
    } else {
        fromObject.find(".item-slot-weight > p").html(fromData.itemCount + "x")
        fromObject.data("itemdata", fromData)
    }
    $.post("https://ta-inv/ItemDrag", JSON.stringify(data));
    
    handleDragDrop()
}

LoadPlayerInventory = inventory => {
    $(".gfxinv-player-inv > .gfxinv-inv-content > .gfxinv-item-slot").remove()
    $.each(inventory, function (k, v) { 
        const content = `
            <div class="gfxinv-item-slot ${v.rarity}-item" data-key=${v.name} data-itemdata=${JSON.stringify({itemName: v.name, itemCount: v.count, currentContainer: "inventory", index: k + 1, weight: v.weight})}>
            <img class="item-slot-image" src=${v.image} alt="">
            <div class="item-slot-info">
                <h1>${v.label.toUpperCase()}</h1>
            </div>
            <div class="item-slot-weight">
                <p>${v.count}x</p>
            </div>
        </div>
        `
        $(".gfxinv-player-inv > .gfxinv-inv-content").append(content);
    });
}



SetInventorySettings = settings => {
    if (settings.name) {
        OtherInventoryType = settings.name
    }
}

SetHotbar = hotbar => {
    $(".gfxinv-hotbarinv-content > .gfxinv-item-slot").remove()
    for (let i = 0; i < 5; i++) {
        const v = hotbar[i]
        const content = `
            <div class="gfxinv-item-slot ${v && v.rarity && v.hasItem ? (v.rarity + "-item") : ""}" data-id="${i + 1}" name="hotbar">
                ${v && v.image && v.hasItem ? `<img src=${v.image} alt="">`:""}
                <div class="item-slot-info">
                    <h1>${v && v.label && v.hasItem ? v.label:""}</h1>
                </div>
                <div class="hotbarslot-numbers">
                    <h1>${i + 1}</h1>
                </div>
            </div>
        `
        $(".gfxinv-hotbarinv-content").append(content);
    }
    handleDragDrop()
}

var DraggingData = null
function handleDragDrop(){
    $(".gfxinv-inv-content > .gfxinv-item-slot").draggable({
        helper: 'clone',
        appendTo: ".bg",
        scroll: true,
        revertDuration: 0,
        revert: "invalid",
        cancel: ".item-nodrag",
        start: function(event, ui) {
            DraggingData = $(this).data("itemdata")
        },    
        stop: function() {
            DraggingData = null
        },
    });

    $(".gfxinv-inv-content > .gfxinv-item-slot").draggable({
        helper: 'clone',
        appendTo: ".bg",
        scroll: true,
        revertDuration: 0,
        revert: "invalid",
        cancel: ".item-nodrag",
        start: function(event, ui) {
            DraggingData = $(this).data("itemdata")
        },    
        stop: function() {
            DraggingData = null
        },
    });
    
    $(".gfxinv-player-inv").droppable({
        hoverClass: 'item-slot-hoverClass',
        drop: function(event, ui) {
            if(DraggingData["currentContainer"] != "inventory") {
                DragItem({itemName: DraggingData["itemName"], count: 1, fromType: OtherInventoryType, toType: "inventory", index: DraggingData["index"]})
            }
        },
    });

    $(".gfxinv-hotbar-inv > .gfxinv-hotbarinv-content > .gfxinv-item-slot").droppable({
        hoverClass: 'item-slot-hoverClass',
        drop: function(event, ui) {
            $.post("https://ta-inv/SetHotbar", JSON.stringify({id: $(this).data("id"), itemName: DraggingData["itemName"]}));
        },
    });
}


ShiftOrControlCount = itemData => {
    let count = 1
    if (ShiftPressed) {
        count = itemData.itemCount >= 5 ? 5 : itemData.itemCount
    } else if (ControlPressed) {
        count = itemData.itemCount
    }
    return count
}

$(document).on("contextmenu", ".gfxinv-item-slot", function(e){
    const itemData = $(this).data("itemdata")
    const isHotbar = $(this).attr("name") == "hotbar"
    if (!isHotbar) {
        $.post("https://ta-inv/SetHotbar", JSON.stringify({id: $(this).data("id"), itemName: false}));
    }
})

$(document).on("dblclick", ".gfxinv-item-slot", function(e){
    const itemData = $(this).data("itemdata")
    const isHotbar = $(this).attr("name") == "hotbar"
    if (!isHotbar) {
        const count = ShiftOrControlCount(itemData)
        if (itemData.itemCount - count > 0) {
            itemData.itemCount -= count
            $(this).find(".item-slot-info > p").html(itemData.itemCount + "x")
            $(this).data("itemdata", itemData)
        } else {
            $(this).remove()
        }
        $.post("https://ta-inv/RemoveItem", JSON.stringify({itemName: itemData["itemName"], count: count, fromType: itemData.currentContainer}));
    }
})

$(document).on("keydown", function(e){
    switch (e.which) {
        case 16:
            ShiftPressed = true
            break;
        case 17:
            ControlPressed = true
            break;
    }
})

const HotBarKeys = {
    49: 1,
    50: 2,
    51: 3,
    52: 4,
    53: 5
}

MouseData = null
$(document).on("keyup", function(e){
    switch (e.which) {
        case 16:
            ShiftPressed = false
            break;
        case 17:
            ControlPressed = false
            break;
    }
    $.each(HotBarKeys, function (k, v) { 
        if (e.which == k && MouseData) {
            $.post("https://ta-inv/SetHotbar", JSON.stringify({id: v, itemName: MouseData.itemName}));
        }
    });
    if (Config && Config.CloseKeys) {
        $.each(Config.CloseKeys, function (k, v) {
            if (e.key == v) {
                $.post("https://ta-inv/Close");
            }
        });
    }
})

$(document).on("mouseenter", ".gfxinv-item-slot", function(){
    const itemData = $(this).data("itemdata")
    MouseData = itemData
})

$(document).on("mouseleave", ".gfxinv-item-slot", function(){
    MouseData = null
})

SetMoneyData = (money) => {
    $(".profile-header > .header-profile-info > .char-info > .point > p").html(
    FormatMoney(money)
    );
    $(".navbar-player-info > .player-infos-text > .infos-money > p").html(
    FormatMoney(money)
    );
};

SetPlayerInfos = (info) => {
    if (info) {
        const desc = localStorage.getItem("userDesc");
        if (desc) {
            $(".name > p").html(desc);
        } else {
            $(".name > p").html("You Description");
        }
        $(".navbar-player-info > .player-infos-text > h1").html(
            `${info.name.toUpperCase()}`
        );
        $(".navbar-player-info > .player-infos-pp > img").attr("src", info.photo);
        $(".character-main-infos > .pp > img").attr("src", info.photo);
        $(".character-main-infos > .infos > .name > h1").html(
            info.name.toUpperCase()
        );
    }
};

SetLevelData = (level, money, tacoin, exp) => {
    $(".infos-pp-level p").text(level);
    $(".infos-pp-exp p").text(exp % 100+"%");
    $(".infos-pp-exp p").css("width", exp % 100 + "%");
    $(".infos-money p.points").text(money);
    $(".infos-money p.tacoin").text(tacoin);
};