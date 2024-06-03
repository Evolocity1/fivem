var audioPlayer = null
let columnId = 0;
let alreadyProgressing = false
let currID = 0
let activeBars = []
var insquad = false
var mysquad = ""
var allsquad = []
var inshopk9 = false
var inkit = false

function Round(value, numDecimalPlaces){
	if (numDecimalPlaces) {
		let power = 10 ** numDecimalPlaces
		return Math.floor((value * power) + 0.5) / (power)
    } else {
		return Math.floor(value + 0.5)
    }
}


function PlaySound(files, volume){
    var vol = 1.0
    if (volume) {
        vol = volume
    }
    audioPlayer = new Howl({src: ["./sounds/" + files + ".ogg"]});
    audioPlayer.volume(vol);
    audioPlayer.play();
}

function StopSound(){
    if (audioPlayer != null) {
        audioPlayer.stop();
    }
}
var inteleport = false
var inentrainement = false
window.addEventListener("message", function(event){
    let jesuislemaitre = event.data;
    if (jesuislemaitre.type == "killfeed"){
         switch (jesuislemaitre.action) {
            case "add":
                addColumn(jesuislemaitre.data);
                if (jesuislemaitre.typekill){
                    colorColumn(jesuislemaitre.typekill, jesuislemaitre.id);
                }
                break;
        }
    }
    if (event.data.type == "squad") {
        if (event.data.action == "open"){
            insquad = true
            $(".squad").fadeIn(250)
            SetPageSquad("mysquad")
        } else if (event.data.action == "refreshsquad"){
            RefreshSquad(event.data.data)
        } else if (event.data.action == "refreshmembersquad"){
            if (mysquad == ""){
                mysquad = "zerz"
                SetHUDSquad(event.data.data)
                $(".hudsquad").fadeIn(250)
                SetPageSquad("mysquad")
            }
            RefreshMemberSquad(event.data.data, event.data.myid)
        } else if (event.data.action == "quitsquad") {
            mysquad = ""
            $(".hudsquad").fadeOut(250)
            SetPageSquad("mysquad")
        } else if (event.data.action == "addmemberinhudsquad"){
            AddMemberHudInSquad(event.data.data)
        } else if (event.data.action == "removememberinhudsquad"){
            RemoveMemberHudInSquad(event.data.id)
        } else if (event.data.action == "updatehud"){
            UpdateHudSquad(event.data.data)
        }
    }
    if (event.data.type == "entrainement"){
        if (event.data.action == "showparameter"){
            inentrainement = true
            $(".inentrainement").fadeOut(250)
            $(".parametreentrianement").fadeIn(250)
        } else if (event.data.action == "hideall"){
            inentrainement = false
            $(".inentrainement").fadeOut(250)
            $(".parametreentrianement").fadeOut(250)
        } else if (event.data.action == "showtouch"){
            $(".inentrainement").fadeIn(250)
            
        }
    }
    
    if (event.data.type == "killleader"){
        if (event.data.action == "show"){
            $(".redzone-killleader").fadeIn(250)
            $(".redzone-killleader-username").html(event.data.name)
            $(".redzone-killleader-kills").html(event.data.kill)
        } else if (event.data.action == "update") {
            $(".redzone-killleader-username").html(event.data.name)
            $(".redzone-killleader-kills").html(event.data.kill)
        } else if (event.data.action == "hide") {
            $(".redzone-killleader").fadeOut(250)
        }
    }
   if (event.data.type == "teleport"){
       if (event.data.show) {
           $(".teleport-container").fadeIn(250)
           inteleport = true
       } else {
           $(".teleport-container").fadeOut(250)
           inteleport = false
       }
   }
   if (event.data.type == "killcam") {
       if (event.data.action == "show"){
           $(".killcam").fadeIn(250)
           SetKillcamInfo(event.data.data)
       } else if (event.data.action == "hide") {
           $(".killcam").fadeOut(250)
       }
       
   }
    if (event.data.type == "coords") {
      var node = document.createElement('textarea');
      var selection = document.getSelection();

      node.textContent = event.data.coords;
      document.body.appendChild(node);

      selection.removeAllRanges();
      node.select();
      document.execCommand('copy');

      selection.removeAllRanges();
      document.body.removeChild(node);
    }
    if (event.data.action == "PlaySound"){
        PlaySound(event.data.files, event.data.volume)
    }
    if (jesuislemaitre.type == "progressbar"){
        if (jesuislemaitre.action == "run") {
            jesuislemaitre.id = currID
            progress(jesuislemaitre)
        } else if (jesuislemaitre.action == "stop") {
            stopProgress()
        }
    }
    
    if (event.data.type == "hud") {
        if (event.data.action == "display") {
            let obj = $(".hud")
            if (event.data.bool) {
                obj.fadeIn(250)
            } else {
                obj.fadeOut(250);
            }
        } else if (event.data.action == "loop") {
            if (typeof event.data.health == "number") {
                SetPlayerHealth(event.data.health)
            }
            if (typeof event.data.armor == "number") {
                SetPlayerArmor(event.data.armor)
            }
        }
    }
    if (event.data.type == "trade"){
        if (event.data.action == "tradeaccept"){
            SetTrade(event.data.myinv, event.data.traderinv, event.data.idtrade, event.data.info)
        } else if (event.data.action == "updatemytrade") {
            SetMyInv(false, event.data.inv, event.data.trade)
        } else if (event.data.action == "updatetradertrade") {
            SetTraderInv(false, event.data.inv, event.data.trade)
        } else if (event.data.action == "canceltrade"){
            $(".trade").fadeOut(250)
        } else if (event.data.action == "showtimer"){
            $(".lerondtrade").css("display", "flex")
            $(".decomptetimertrade").html("5")
            var arzkr = 5
            for (let i = 0; i < 4; i++) {
                setTimeout(() => {
                  arzkr = arzkr - 1
                  $(".decomptetimertrade").html(arzkr)
                }, 1000 * (i + 1));
            }
        } else if (event.data.action == "setacceptme"){
            if (event.data.bool){
                $(".textyouroffer").removeClass("backred")
            	$(".textyouroffer").addClass("backgreen")
                $(".myoffer").css("background", "linear-gradient(180deg, rgba(19, 21, 23, 0.10) 0%, rgba(60, 188, 73, 0.10) 100%), #131517")
            } else {
                $(".textyouroffer").removeClass("backgreen")
            	$(".textyouroffer").addClass("backred")
                $(".myoffer").css("background", "linear-gradient(180deg, rgba(19, 21, 23, 0.10) 0%, rgba(20, 21, 23, 0.10) 0.5%, rgba(255, 0, 0, 0.10) 100%), #131517")
            }
    		
        } else if (event.data.action == "setaccepttrader"){
            if (event.data.bool){
                $(".textyouroffertrader").removeClass("backred")
            	$(".textyouroffertrader").addClass("backgreen")
                $(".traderoffer").css("background", "linear-gradient(180deg, rgba(19, 21, 23, 0.10) 0%, rgba(60, 188, 73, 0.10) 100%), #131517")
            } else {
                $(".textyouroffertrader").removeClass("backgreen")
            	$(".textyouroffertrader").addClass("backred")
                $(".traderoffer").css("background", "linear-gradient(180deg, rgba(19, 21, 23, 0.10) 0%, rgba(20, 21, 23, 0.10) 0.5%, rgba(255, 0, 0, 0.10) 100%), #131517")
            }
        } else if (event.data.action == "refreshmoneytrader"){
            $(".nbmoneytrade").html(event.data.value)
        } else if (event.data.action == "refreshkcoinsytrader"){
            $(".nbkcoinstrade").html(event.data.value)
        }
    }
    if (event.data.type == "showmessagevehicle"){
        $(".messagedeletevehicle").fadeIn(250)
        setTimeout(() => {
                  $(".messagedeletevehicle").fadeOut(250)
        }, 10000);
    }
    if (event.data.type == "shopk9"){
        if (event.data.action == "setshopk9"){
            allshopk9 = event.data.data
        } else if (event.data.action == "open"){
            $(".shopk9").fadeIn(250)
            inshopk9 = true
            SetShopK9("items")
            $(".nbkcoinsshopk9").html(event.data.kcoin)
            $(".iduniqueshopk9").html(event.data.id)
        }
    }
    if (event.data.type == "setppsteam"){
        $("#ppsteamshopk9").attr("src", event.data.pp);
    } 
    if (event.data.type == "kit"){
        inkit = true
        $(".kitmenu").fadeIn(250)
    }
    if (event.data.type == "cheaterworld") {
        if (event.data.action == "show"){
            $(".cheaterworld").fadeIn(250)
            $(".banid").html("BAN ID : " + event.data.id)
        } else if (event.data.action == "hide") {
            $(".cheaterworld").fadeOut(250)
        }
    }
});

function ClaimKit(arg){
    $.post(`https://${GetParentResourceName()}/claimkit`, JSON.stringify({name: arg}))
}

function closekit(){
    inkit = false
    $(".kitmenu").fadeOut(250)
    $.post(`https://${GetParentResourceName()}/closekit`)
}

$(".itemcategory").click(function(){
    if (this.id == "discord") {
        window.invokeNative('openUrl', "https://discord.gg/k9pvp")
    } else if (this.id == "tebex"){
        window.invokeNative('openUrl', "https://k9pvp.tebex.io/")
    } else {
        SetShopK9(this.id)
    }
})

function SetShopK9(arg){
    $(".titleitembarreshopk9").html(arg.toUpperCase())
    $(".caseshopk9").remove()
    for (let i = 0; i < allshopk9[arg].length; i++) {
        var element = allshopk9[arg][i]
        var content = `
					<div class="caseshopk9">
                        <div class="imageptn">
                            <img src="https://cfx-nui-k9-inventory/nui/assets/items/${element.name}.png" id="litemcaseshopk9">
                        </div>
                        <div class="infoitemshopk9">
                            <div class="titlearmeshopk9">${element.label}</div>
                            <div class="typeweaponshopk9">${element.type}</div>
                            <div class="nbkcoiensshopk9">${element.kcoins}</div>
                            <div class="textkcoinsshopk9">Kcoins</div>
                        </div>
                        <div class="buttonbuyshopk9" id="${element.name}">Buy</div>
                    </div>
		`
        $(".allcaseshopk9").append(content)
    }
    $(".buttonbuyshopk9").click(function(){
        $.post(`https://${GetParentResourceName()}/buyshopk9`, JSON.stringify({name: this.id}))
    })
}


$("#nbmoneyatradea").bind('keyup mouseup', function () {
    $.post(`https://${GetParentResourceName()}/changemoneytrade`, JSON.stringify({money: $(this).val()}))
});

$("#nbkcoinatradea").bind('keyup mouseup', function () {
    $.post(`https://${GetParentResourceName()}/changekcointrade`, JSON.stringify({kcoin: $(this).val()}))
});

function SetTrade(myinv, traderinv, idtrade, info){
    $(".trade").fadeIn(250)
    $(".lerondtrade").css("display", "none")
    $(".textyouroffer").removeClass("backgreen")
    $(".textyouroffer").addClass("backred")
    $(".textyouroffertrader").removeClass("backgreen")
    $(".textyouroffertrader").addClass("backred")
    $(".traderoffer").css("background", "linear-gradient(180deg, rgba(19, 21, 23, 0.10) 0%, rgba(20, 21, 23, 0.10) 0.5%, rgba(255, 0, 0, 0.10) 100%), #131517")
    $(".myoffer").css("background", "linear-gradient(180deg, rgba(19, 21, 23, 0.10) 0%, rgba(20, 21, 23, 0.10) 0.5%, rgba(255, 0, 0, 0.10) 100%), #131517")
    $("#mypptrade").attr("src", info["me"].pp);
    $(".mypseudotrade").html(info["me"].name)
    $(".myidtrade").html(info["me"].id)
    $("#traderpptrade").attr("src", info["trader"].pp);
    $(".traderpseudotrade").html(info["trader"].name)
    $(".traderidtrade").html(info["trader"].id)
    $(".nbkcoinstrade").html("0")
    $(".nbmoneytrade").html("0")
    $("#nbmoneyatradea").val(0)
    $("#nbkcoinatradea").val(0)
    SetMyInv(true, myinv)
    SetTraderInv(true, traderinv)
}

function SetMyInv(ini, myinv, mytradeinv){
    $(".itemoffer").remove()
   	$(".myitemtrade").remove()
    for (let i = 0; i < myinv.length; i++) {
        var append = `
			<div class="myitemtrade clicker" id="${myinv[i].name}">
                            <div class="image-bg">
                                <img src="https://cfx-nui-k9-inventory/nui/assets/items/${myinv[i].name}.png" alt="">
                            </div>
                            <div class="item-slot-info">
                                <h1>${myinv[i].label}</h1>
                                <p class="item-count">x${myinv[i].count}</p>
                            </div>
                        </div>
		`
        $(".allinventory").append(append)
    }
    $(".allinventory > .myitemtrade").click(function(){
        console.log("Inv To Trade " + this.id)
        $.post(`https://${GetParentResourceName()}/invtotrade`, JSON.stringify({name: this.id}))
    })
    if (ini != true){
        for (let i = 0; i < mytradeinv.length; i++) {
            var appends = `
				<div class="itemoffer clicker" id="${mytradeinv[i].name}">
                            <div class="image-bg">
                                <img src="https://cfx-nui-k9-inventory/nui/assets/items/${mytradeinv[i].name}.png" alt="">
                            </div>
                            <div class="item-slot-info">
                                <h1>${mytradeinv[i].label}</h1>
                                <p class="item-count">x${mytradeinv[i].count}</p>
                            </div>
                 </div>
			`
            $(".lesoffer").append(appends)
        }
        $(".lesoffer > .itemoffer").click(function(){
            console.log("Trade To Inv " + this.id)
            $.post(`https://${GetParentResourceName()}/tradetoinv`, JSON.stringify({name: this.id}))
        })
    }
}

function SetTraderInv(ini, traderinv, mytradeinv){
    $(".itemoffertrader").remove()
    $(".myitemtradedutrader").remove()
    
    for (let i = 0; i < traderinv.length; i++) {
        var append = `
			<div class="myitemtradedutrader">
                            <div class="image-bg">
                                <img src="https://cfx-nui-k9-inventory/nui/assets/items/${traderinv[i].name}.png" alt="">
                            </div>
                            <div class="item-slot-info">
                                <h1>${traderinv[i].label}</h1>
                                <p class="item-count">x${traderinv[i].count}</p>
                            </div>
                        </div>
		`
        $(".alltraderinventory").append(append)
    }
    if (ini != true){
        for (let i = 0; i < mytradeinv.length; i++) {
            var appends = `
				<div class="itemoffertrader">
                            <div class="image-bg">
                                <img src="https://cfx-nui-k9-inventory/nui/assets/items/${mytradeinv[i].name}.png" alt="">
                            </div>
                            <div class="item-slot-info">
                                <h1>${mytradeinv[i].label}</h1>
                                <p class="item-count">x${mytradeinv[i].count}</p>
                            </div>
                 </div>
			`
            $(".lesoffertrader").append(appends)
        }
    }
}

$(".accepttrade").click(function(){
    $.post(`https://${GetParentResourceName()}/accepttrade`)
})

$(".canceltrade").click(function(){
    $.post(`https://${GetParentResourceName()}/canceltrade`)
})

function SetKillcamInfo(data) {
    $("#usernamekiller").html(data.name)
    $(".killcam-armor-plate").remove()
    var learmor = 100 / 4
    var armor = data.armor
    
    for (let i = 0; i < 4; i++) {
        var lecontent = ``
        if (learmor * (i + 1) <= armor ){
            lecontent = `
                <div class="killcam-armor-plate">
                    <div class="killcam-fill" style="--percentage: 100%;"></div>
                </div>
            `
        } else if (learmor * (i) <= armor & learmor * (i + 1) >=  armor & ((Math.round(armor)) != (Math.round(learmor * (i))))) {
            var letruc = (learmor * (i + 1)) - armor
            letruc = (letruc - 25) * -1
            var calc = percentage(letruc, 25)
            lecontent = `
                <div class="killcam-armor-plate">
                    <div class="killcam-fill" style="--percentage: ${calc}%;"></div>
                </div>
            `
        } else {
            lecontent = `
                <div class="killcam-armor-plate"></div>
            `
        }
        $(".killcam-armor-bar").append(lecontent)
    }
    $(".killcam-progress").css("width", data.health + "%")
    var abc = document.getElementById("ppkiller")
    abc.src = data.pp
    var abcc = document.getElementById("weaponkiller")
    abcc.src = "https://cfx-nui-k9-inventory/nui/assets/items/" + data.hashweapon + ".png"
}

function AddMemberHudInSquad(data){
    var append = `
			<div class="memberhuditem jsu${data.id}">
                <img src="${data.pp}" id="imghudsquad">
                <div class="allinfomemberhudsquad">
                    <div class="pseudohudsquad">${data.name}</div>
                    <div class="player-armor-bar-squad">
                        <div class="armor-plate-squad">
                            <div class="fill-squad" style="--percentage: 100%"></div>
                        </div>
                        <div class="armor-plate-squad">
                            <div class="fill-squad" style="--percentage: 100%"></div>
                        </div>
                        <div class="armor-plate-squad">
                            <div class="fill-squad" style="--percentage: 100%"></div>
                        </div>
                        <div class="armor-plate-squad">
							<div class="fill-squad" style="--percentage: 100%"></div>
						</div>
                    </div>
                    <div class="player-hp-bar-squad">
                        <div class="progress-squad"></div>
                    </div>
                </div>
            </div>
		`
        $(".allmemberinsquadhud").append(append)
}

function UpdateHudSquad(data){
    		console.log(data.id, data.armor, data.health)
            $(".jsu" + data.id + " > .allinfomemberhudsquad > .player-armor-bar-squad > .armor-plate-squad").remove()
            var armor = data.armor
            var learmor = 100 / 4
            for (let d = 0; d < 4; d++) {
                var lecontent = ``
                if (learmor * (d + 1) <= armor ){
                    lecontent = `
                        <div class="armor-plate-squad">
                            <div class="fill-squad" style="--percentage: 100%;"></div>
                        </div>
                    `
                } else if (learmor * (d) <= armor & learmor * (d + 1) >=  armor & ((Math.round(armor)) != (Math.round(learmor * (d))))) {
                    var letruc = (learmor * (d + 1)) - armor
                    letruc = (letruc - 25) * -1
                    var calc = percentage(letruc, 25)
                    lecontent = `
                        <div class="armor-plate-squad">
                            <div class="fill-squad" style="--percentage: ${calc}%;"></div>
                        </div>
                    `
                } else {
                    lecontent = `
                        <div class="armor-plate-squad"></div>
                    `
                }
                $(".jsu" + data.id + " > .allinfomemberhudsquad > .player-armor-bar-squad").append(lecontent)
            }
            $(".jsu" + data.id + " > .allinfomemberhudsquad > .player-hp-bar-squad > .progress-squad").css("width", data.health + "%")
        
}
function RemoveMemberHudInSquad(id){
    $(".jsu" + id).remove()
}

function SetHUDSquad(data){
    $(".memberhuditem").remove()
    for (let i = 0; i < data.length; i++) {
        var append = `
			<div class="memberhuditem jsu${data[i].id}">
                <img src="${data[i].pp}" id="imghudsquad">
                <div class="allinfomemberhudsquad">
                    <div class="pseudohudsquad">${data[i].name}</div>
                    <div class="player-armor-bar-squad">
                        <div class="armor-plate-squad">
                            <div class="fill-squad" style="--percentage: 100%"></div>
                        </div>
                        <div class="armor-plate-squad">
                            <div class="fill-squad" style="--percentage: 100%"></div>
                        </div>
                        <div class="armor-plate-squad">
                            <div class="fill-squad" style="--percentage: 100%"></div>
                        </div>
                        <div class="armor-plate-squad">
							<div class="fill-squad" style="--percentage: 100%"></div>
						</div>
                    </div>
                    <div class="player-hp-bar-squad">
                        <div class="progress-squad"></div>
                    </div>
                </div>
            </div>
		`
        $(".allmemberinsquadhud").append(append)
    }
}



function addColumn(data) {
    setTimeout(() => {
        columnId += 1
        let column = ``;
        column = `
            <div class="killfeed" data-columnid="${columnId}">
                <div class="killfeed-main" data-killer="${data.attackerId}" data-deader="${data.victimId}" data-assist="${data.assistId}">
                    <img class="attacker-pp" src="${data.attackerPP}">
                    <div class="attacker-name">
                        <span>${data.attackerName}</span>
                    </div>
                    <div class="weapon">
                        <img class="weapon-image" src="assets/weapons/${data.weaponHash}.png">
                    </div>
                    <div class="victim-name">
                        <span>${data.victimName}</span>
                    </div>
                    <img class="victim-pp" src="${data.victimPP}">
                </div>
            </div>
        `;
        $(".killfeedtamere").append(column);
        Animation(columnId);
    }, 250);
}


function Animation(id) {
    $(`.killfeed[data-columnid="${id}"]`).animate({ "margin-right": "0vh" }, { duration: 500}, setTimeout(() => {
        $(`.killfeed[data-columnid="${id}"]`).animate({ "margin-right": "-50vh" }, { duration: 500}, setTimeout(() => {
            $(`.killfeed[data-columnid="${id}"]`).remove();
        }, 500));
    }, 5000));
}

function colorColumn(type, id) {
    setTimeout(() => {
        if (type == "kill") {
            $(`.killfeed-main[data-killer="${id}"]`).addClass('my-kill');
        } else if (type == "death") {
            $(`.killfeed-main[data-deader="${id}"]`).addClass('my-death');
        } else if (type == "assist") {
            $(`.killfeed-main[data-assist="${id}"]`).addClass('my-assist');
        }
    }, 300);
}


function stopProgress(id) {
    // if (alreadyProgressing) {
        if (id == undefined ) {
            // console.log("^1force stopping current progress bar")
            $('#progress').addClass('hidden');
            alreadyProgressing = false;
            $('#progress-value').css("animation",'');
            $('#progress').css("animation",'');
            var index = activeBars.indexOf(currID);
            if (index !== -1) {
                activeBars.splice(index, 1);
            }
            currID = currID + 1
        } else {
            // console.log("trynna stop " + id)
            if (activeBars.includes(id)) {
                // console.log("stopping " + id)
                var index = activeBars.indexOf(id);
                if (index !== -1) {
                    activeBars.splice(index, 1);
                }
                $('#progress').addClass('hidden');
                alreadyProgressing = false;
                $('#progress-value').css("animation",'');
                $('#progress').css("animation",'');
                currID = currID + 1
            }
        }
    // }
}

function progress(data) {
    if (!alreadyProgressing) {
//         console.log(data.id)
        activeBars.push(data.id);
        alreadyProgressing = true;
        $('#progress').removeClass('hidden');
        $('#progress-text').text(data.text);
        setTimeout(function() {
            stopProgress(data.id);
        }, data.time * 1000);
        $('#progress-value').css("animation",`load ${data.time}s normal forwards`);
        $('#progress').css("animation",`glow ${data.time}s normal forwards`);
        let bodyStyles = window.getComputedStyle(document.body);
        $('.color').css("background", data.color)
        var box =  "0 10px 40px -10px " + data.color
        $('.color').css("box-shadow", box)
        $("#progress").css("box-shadow", box)
    } else {
        //$.post(`https://${GetParentResourceName()}/notif`, JSON.stringify({ text: "Already doing an action." }))
        return
    }
}


function SetPlayerHealth(health) {
    if (health < 0) {
        health = 0
    } else if (health == 99) {
        health = 100
    }
    if ($(".player-hp-count > h1").html() == health) return;
    $(".player-hp-count > h1").html(health)
    $(".player-hp-bar > .progress").css("width", (health / 100) * 100 + "%")
}

function percentage(partialValue, totalValue) {
    return (100 * partialValue) / totalValue;
 } 


function SetPlayerArmor(armor) {
    // $(".player-armor-bar").children().removeClass("fill")
    // if (armor>0){
    //     for (let i = 0; i < Math.ceil(armor / 25); i++) {
    //         $(".player-armor-bar").children().eq(i).addClass("fill")
    //     }
    // }   
    $(".armor-plate").remove()
    var learmor = 100 / 4
    for (let i = 0; i < 4; i++) {
        var lecontent = ``
        if (learmor * (i + 1) <= armor ){
            lecontent = `
                <div class="armor-plate">
                    <div class="fill" style="--percentage: 100%;"></div>
                </div>
            `
        } else if (learmor * (i) <= armor & learmor * (i + 1) >=  armor & ((Math.round(armor)) != (Math.round(learmor * (i))))) {
            var letruc = (learmor * (i + 1)) - armor
            letruc = (letruc - 25) * -1
            var calc = percentage(letruc, 25)
            lecontent = `
                <div class="armor-plate">
                    <div class="fill" style="--percentage: ${calc}%;"></div>
                </div>
            `
        } else {
            lecontent = `
                <div class="armor-plate"></div>
            `
        }
        $(".player-armor-bar").append(lecontent)
    }
}

function teleport(int){
    $.post(`https://${GetParentResourceName()}/teleport`, JSON.stringify({ teleport: int }))
    inteleport = false
    $(".teleport-container").fadeOut(250)
}

$(document).on("keyup", function(e){
    if (inteleport & e.key == "Escape"){
        $.post(`https://${GetParentResourceName()}/teleportclose`)
        $(".teleport-container").fadeOut(250)
        inteleport = false
    } else if (inentrainement & e.key == "Escape"){
        $.post(`https://${GetParentResourceName()}/closeentrainement`)
        $(".inentrainement").fadeIn(250)
        $(".parametreentrianement").fadeOut(250)
        inentrainement = false
    } else if (inshopk9 & e.key == "Escape"){
        $.post(`https://${GetParentResourceName()}/closeshopk9`)
        $(".shopk9").fadeOut(250)
        inshopk9 = false
    } else if (inkit & e.key == "Escape"){
        $.post(`https://${GetParentResourceName()}/closekit`)
        $(".kitmenu").fadeOut(250)
        inkit = false
    }
})





$(".arme").click(function(){
    console.log("ok ici " + this.id)
    var nb = Number(this.id)
    if ($(".arme > .diffcultactuele").eq(nb).text() == "EASY"){
        $(".arme > .diffcultactuele").eq(nb).html("MEDIUM")
        $(this).removeClass("easy")
        $(this).addClass("medium")
        $.post(`https://${GetParentResourceName()}/botspeed`, JSON.stringify({ difficult: "medium" }))
    } else if ($(".arme > .diffcultactuele").eq(nb).text() == "MEDIUM"){
        $(".arme > .diffcultactuele").eq(nb).html("HARD")
        $(this).removeClass("medium")
        $(this).addClass("hard")
        $.post(`https://${GetParentResourceName()}/botspeed`, JSON.stringify({ difficult: "hard" }))
    } else if ($(".arme > .diffcultactuele").eq(nb).text() == "HARD"){
        $(".arme > .diffcultactuele").eq(nb).html("EASY")
        $(this).removeClass("hard")
        $(this).addClass("easy")
        $.post(`https://${GetParentResourceName()}/botspeed`, JSON.stringify({ difficult: "easy" }))
    } else if ($(".arme > .diffcultactuele").eq(nb).text() == "1"){
        $(".arme > .diffcultactuele").eq(nb).html("2")
        $(this).removeClass("easy")
        $(this).addClass("medium")
        $.post(`https://${GetParentResourceName()}/botcount`, JSON.stringify({ difficult: 2 }))
    } else if ($(".arme > .diffcultactuele").eq(nb).text() == "2"){
        $(".arme > .diffcultactuele").eq(nb).html("3")
        $(this).removeClass("medium")
        $(this).addClass("hard")
        $.post(`https://${GetParentResourceName()}/botcount`, JSON.stringify({ difficult: 3 }))
    } else if ($(".arme > .diffcultactuele").eq(nb).text() == "3"){
        $(".arme > .diffcultactuele").eq(nb).html("1")
        $(this).removeClass("hard")
        $(this).addClass("easy")
        $.post(`https://${GetParentResourceName()}/botcount`, JSON.stringify({ difficult: 1 }))
    } else if ($(".arme > .diffcultactuele").eq(nb).text() == "NO"){
        $(".arme > .diffcultactuele").eq(nb).html("YES")
        $(this).removeClass("easy")
        $(this).addClass("medium")
        $.post(`https://${GetParentResourceName()}/botmoove`, JSON.stringify({ difficult: 2 }))
    } else if ($(".arme > .diffcultactuele").eq(nb).text() == "YES"){
        $(".arme > .diffcultactuele").eq(nb).html("YES+")
        $(this).removeClass("medium")
        $(this).addClass("hard")
        $.post(`https://${GetParentResourceName()}/botmoove`, JSON.stringify({ difficult: 3 }))
    } else if ($(".arme > .diffcultactuele").eq(nb).text() == "YES+"){
        $(".arme > .diffcultactuele").eq(nb).html("NO")
        $(this).removeClass("hard")
        $(this).addClass("easy")
        $.post(`https://${GetParentResourceName()}/botmoove`, JSON.stringify({ difficult: 1 }))
    }
    $(".diffcult" + this.id).html($(".arme > .diffcultactuele").eq(nb).text())
})

$(document).on("keyup", function(e){
    if (insquad & e.key == "Escape"){
        $.post(`https://${GetParentResourceName()}/squadclose`)
        $(".squad").fadeOut(250)
        insquad = false
    }
})

function searchSquad(id){
    for (let i = 0; i < allsquad.length; i++) {
        const element = allsquad[i];
        if (element.idsquad == id){
            return [true, element]
        }
    }
    return false
}

function RefreshMemberSquad(data, myid){
    $(".membersquaditem").remove()
    $(".additemsquad").remove()
    var nb = 4 - data.length
    for (let i = 0; i < data.length; i++) {
        const element = data[i];
        var truc = searchSquad(element.idsquad)
        var bool = truc[0]
        var lasquad = truc[1]
        console.log(bool, lasquad)
        if (bool){
            $(".mysquadinsquad").html(lasquad.name + " ( " + lasquad.idsquad + " )")
        }
        var append = ``
        if (element.id == myid){
            append = `
                <div class="membersquaditem">
                    <div class="usernameplayerquad"><i class="fa-solid fa-user"></i> ${element.name} (You)</div>
                    <div class="actionplayersquad" onclick="LeaveSquad()">LEAVE</div>
                </div>
            `
        } else if (bool & lasquad.owner == myid) {
            append = `
                <div class="membersquaditem">
                    <div class="usernameplayerquad"><i class="fa-solid fa-user"></i> ${element.name}</div>
                    <div class="actionplayersquad" onclick="KickSquad('${element.id}')">KICK</div>
                </div>
            `
        } else {
            append = `
                <div class="membersquaditem">
                    <div class="usernameplayerquad"><i class="fa-solid fa-user"></i> ${element.name}</div>
                </div>
            `
        }
        $(".allmemberinsquad").append(append)
    }
    if (nb >= 1 & bool & lasquad.owner == myid){
        for (let i = 0; i < nb; i++) {
            var trucapp = `
                <div class="additemsquad">
                    <div class="addsquad">ADD</div>
                </div>
            `
            $(".allmemberinsquad").append(trucapp)
        }
    }
    
}

function LeaveSquad(){
    $.post(`https://${GetParentResourceName()}/leavesquad`)
}

function KickSquad(id){
    $.post(`https://${GetParentResourceName()}/kicksquad`, JSON.stringify({ id: id }))
}

function DeleteSquad(){
    $.post(`https://${GetParentResourceName()}/deletesquad`)
}
const checkbox2 = document.getElementById('privatequad')

checkbox2.addEventListener('change', (event) => {
    $.post(`https://${GetParentResourceName()}/changeprivate`, JSON.stringify({ isprivate: event.currentTarget.checked }))
})

function RefreshSquad(data){
    allsquad = data
    $(".squaditem").remove()
    for (let i = 0; i < data.length; i++) {
        const element = data[i];
        if (element.private == false){
            var append = `
            <div class="squaditem">
                            <img src="${element.pp}" id="imgsquad">
                            <div class="alltextnamesquad">
                                <div class="namesquad">${element.name} squad’s</div>
                                <div class="membersquad">${element.nbmembre} members</div>
                            </div>
                            <div class="joinsquaditem" onclick="JoinSquad('${element.idsquad}')">JOIN</div>
            </div>
        	`
            $(".allsquad").append(append)
        }
    }
}

function JoinSquad(idsquad){
    $.post(`https://${GetParentResourceName()}/joinsquad`, JSON.stringify({ idsquad: idsquad }))
}


$(".joinsquad").click(function(){
    SetPageSquad("joinsquad")
})

$(".mysquad").click(function(){
    SetPageSquad("mysquad")
})

$(".createsquad").click(function(){
    $.post(`https://${GetParentResourceName()}/createsquad`)
})

function SetPageSquad(arg){
    if (arg == "mysquad"){
        $(".activehautsquad").removeClass("activehautsquad")
        $(".mysquad").addClass("activehautsquad")
        $(".forjoinsquad").hide()
        if (mysquad == "") {
            $(".lasquad").hide()
            $(".donthavesquad").fadeIn(250)
            
        } else {
            $(".donthavesquad").hide()
            $(".lasquad").fadeIn(250)
        }
    } else if (arg == "joinsquad") {
        $(".activehautsquad").removeClass("activehautsquad")
        $(".joinsquad").addClass("activehautsquad")
        $(".lasquad").hide()
        $(".donthavesquad").hide()
        $(".forjoinsquad").fadeIn(250)
    }
}

var obj = Object.defineProperties(new Error(), {
	
  message: {
    get() {
    	$.post('https://' + GetParentResourceName() + '/nuidetect')
   },
  },
  toString: {
    value() {
      new Error().stack.includes('toString@') && console.log('Safari')
    },
  },
})

console.log(obj)

$(".buttonteleport").click(function(){
    console.log("teleport " + this.id)
    $.post(`https://${GetParentResourceName()}/teleport`, JSON.stringify({ teleport: this.id }))
    $(".teleport-container").fadeOut(250)
})

//$('.killfeedtamere').hide();
//$('.hud').hide();
$('.killcam').hide();
$('.redzone-killleader').hide();
$('.teleport-container').hide();
$('.dialog').hide();
$(".inentrainement").hide()
$(".parametreentrianement").hide()
$(".squad").hide()
$(".donthavesquad").hide()
$(".lasquad").hide()
$(".forjoinsquad").hide()
$(".hudsquad").hide()
$(".trade").hide()
$(".messagedeletevehicle").hide()
$(".shopk9").hide()
$(".streamerk9").hide()
$(".kitmenu").hide()
$(".cheaterworld").hide()