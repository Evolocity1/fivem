OtherInventoryType = null
ShiftPressed = false
ControlPressed = false
PlayerMaxWeight = 1
OtherMaxWeight = 1
DragEvent = 0
Config = null
Bool = false
lecrew = []
gold = false 
diamond = false
allstat = []
allstatcrew = []
opacity = 0.65
alliteminshop = []
var lecolor = "#f9f871"
var typeactuelshop = "weapon"
var buyorsellshop = "buy"
var paniershop = []
var myinventorysell = []
combatmode = false
modedejeu = "pvp"
havecrew = false
crew = []


var PlayerItems = {
    "inventory": [],
    "protected": [],
}

$(document).on('input', '#myRange', function() {
    $('#valuerange').html( $(this).val() + "%" );
    opacity = ($(this).val() / 100)

});

function SetParameter(cat, para, val){
    $.post("https://k9-inventory/SetParameter", JSON.stringify({categorie: cat, parameter: para, value: val}))
}

function PlaySound(files, volume){
    var vol = 1.0
    if (volume) {
        vol = volume
    }
    audioPlayer = new Howl({src: ["https://cfx-nui-k9pvp/k9/ui/sounds/" + files + ".ogg"]});
    audioPlayer.volume(vol);
    audioPlayer.play();
}

function StopSound(){
    if (audioPlayer != null) {
        audioPlayer.stop();
    }
}

$(document).on("change" , "#colorinv" , function(){
    $(".valuecolorinv").html($(this).val());
    if ($(this).val() != lecolor){
        SetInventoryColor($(this).val())
    	SetParameter("inventory", "color", $(this).val())
    }
});

function hexToRgb(hex) {
  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? {
    r: parseInt(result[1], 16),
    g: parseInt(result[2], 16),
    b: parseInt(result[3], 16)
  } : null;
}

function SetInventoryColor(val){
    lecolor = val
    console.log(val)
    var torgb = hexToRgb(val)
    var rgb = torgb.r + ", " + torgb.g + ", " + torgb.b
    $(".barlinear").css("background", "linear-gradient(90deg, #000 0%, " + val + " 50%, #000 100%)")
    $(".buttons-crew > .button-crew").css("border-bottom", "2px solid " + val)
    $(".crew-int > .navbar-crewint").css("border-bottom", "0.5vh solid " + val)
    $(".crew > .crew-main > .text-crew h1").css("color", val)
    $(".crew > .crew-main > .text-crew h1").css("text-shadow", "0 0 15px " + val)
    $(".crew > .crew-main > .case-content > .caserow-item > .text-content > .title").css("color", val)
    $(".crew > .crew-main > .case-content > .caserow-item > .text-content > .title").css("text-shadow", "0px 0px 8px " + val)
    $(".crew-int > .crewint-main > .crewint-item > .crewint-image > img").css("border", "4px solid " + val)
    $(".crew-int > .crewint-main > .crewint-item > .crewint-image > img").css("box-shadow", "0px 0px 8px " + val)
    $(".crewint-defi-progress > .crewint-defi-progressbar").css("background", val)
    $(".crewint-item > .crewint-leaderboard-title").css("border-bottom", "0.5vh solid" + val)
    $("#owner").css("color", val)
    $(".statscrewint-content > .statscrewint-statss > .statscrewint-item > .sdt-statsitemscrew-title").css("color", val)
    $(".leaderboard > .PlayerTopThree > .TopItem").css("border-left", "0.7vh solid rgba(" + rgb + ", 60)")
    $(".sdtleaderboard-main > .sdtleaderboard-title").css("border-bottom", "0.5vh solid " + val)
    $(".leaderboardcrew > .PlayerTopThreecrew > .TopItemcrew").css("border-left", "0.7vh solid rgba(" + rgb + ", 60)")
    $(".sdtleaderboardcrew-main > .sdtleaderboardcrew-title").css("border-bottom", "0.5vh solid " + val)
    $(".lejaune").css("color", val)
    $(".buttonbuykcoins").css("background", val)
    $("#imgaccountinfo").css("border", "0.25vw solid " + val)
    $(".progress .fill").css("stroke", val)
    $(".sdtleaderboardrow-item").eq(0).css("background",  "rgba(" + rgb + ", 60)")
    $("#player").hover(function(){
        $(this).css("border", "0.1vh solid rgba(" + rgb + ", 70)")
        }, function() {
        $( this ).css("border","");
      })
    $("#crews").hover(function(){
        $(this).css("border", "0.1vh solid rgba(" + rgb + ", 70)")
        }, function() {
        $( this ).css("border","");
      })
    $(".arena-item").hover(function(){
        $(this).css("border-bottom", "5px solid " + val)
        $(this).css("border-top", "5px solid " + val)
    }, function() {
        $( this ).css("border-top","");
        $( this ).css("border-bottom","");
    })
}

function SetInventoryInitialisation(data){
    SetInventoryColor(data["inventory"]["color"])
    $("#colorinv").val(data["inventory"]["color"])
    if (data["fpsboost"]["enable"]){
        $(".buttonfpsboost > .select > #standard-select").val("Option1")
    } else {
        $(".buttonfpsboost > .select > #standard-select").val("Option2")
    }
    
    if (data["zombie"]["sound"]){
        $(".buttonzombiesounds > .select > #standard-select").val("Option1")
    } else {
        $(".buttonzombiesounds > .select > #standard-select").val("Option2")
    }
    
    if (data["zombie"]["autoloot"]){
        $(".buttonautozombieloot > .select > #standard-select").val("Option1")
    } else {
        $(".buttonautozombieloot > .select > #standard-select").val("Option2")
    }
    
    if (data["privacy"]["streamer"]){
        $(".buttonstreamermodesettings > .select > #standard-select").val("Option1")
    } else {
        $(".buttonstreamermodesettings > .select > #standard-select").val("Option2")
    }
    
    if (data["privacy"]["trade"]){
        $(".buttontradesettings > .select > #standard-select").val("Option1")
    } else {
        $(".buttontradesettings > .select > #standard-select").val("Option2")
    }
    
    if (data["privacy"]["ppsteam"]){
        $(".buttonsteamsettings > .select > #standard-select").val("Option1")
    } else {
        $(".buttonsteamsettings > .select > #standard-select").val("Option2")
    }
    
    if (data["privacy"]["crew"]){
        $(".buttoncrewrequestsettings > .select > #standard-select").val("Option1")
    } else {
        $(".buttoncrewrequestsettings > .select > #standard-select").val("Option2")
    }
    
    if (data["vip"]["speedboost"]){
        $(".buttonspeedboostsafesettings > .select > #standard-select").val("Option1")
    } else {
        $(".buttonspeedboostsafesettings > .select > #standard-select").val("Option2")
    }
    
    if (data["vip"]["autofarmzombie"]){
        $(".buttonautozombiefarmsettings > .select > #standard-select").val("Option1")
    } else {
        $(".buttonautozombiefarmsettings > .select > #standard-select").val("Option2")
    }
    
    $(".listsound > .select > #standard-select").val("Option" + data["hitmarker"]["sound"])
    $(".buttonhitmarkersize > .select > #standard-select").val("Option" + data["hitmarker"]["size"])
}


$(document).ready(function(){
    $.get("../config/jsconfig.json", function(data) {
        if(data) Config = JSON.parse(data)
    })
    $(".buy").click(function(){
        if (buyorsellshop == "sell"){
            buyorsellshop = "buy"
            SetShopPage(alliteminshop)
            $(".sellall").css("display", "none")
        }
    })

    $(".sell").click(function(){
        console.log("test ici")
        if (buyorsellshop == "buy"){
            buyorsellshop = "sell"
            SetShopPage(alliteminshop)
            $(".sellall").css("display", "flex")
        }
    })
    
    $(".weaponorvehicle").click(function(){
        if (typeactuelshop == "weapon"){
            typeactuelshop = "vehicle"
            $(".weaponorvehicle").html("VEHICLE")
        } else {
            typeactuelshop = "weapon"
            $(".weaponorvehicle").html("WEAPON")
        }
        SetShopPage(alliteminshop)
    })
    $(".buypanier").click(function(){
        if (paniershop.length > 0){
            $.post("https://k9-inventory/ConfirmBakset", JSON.stringify({panier: paniershop}))
        	paniershop = []
            $.post("https://k9-inventory/Close");
        } 
    })
    $(".cancelpanier").click(function(){
        paniershop = []
        SetPanierShop()
    })
    $(".sellall").click(function(){
        $.post("https://k9-inventory/SellAll")
        $.post("https://k9-inventory/Close")
    })
    
    const myprotectedinv = document.getElementById("protected-inv");

    myprotectedinv.addEventListener('keydown', function(event) {
                if (event.key === ' ') {
                    event.preventDefault();
                }
    });

    const myinvcotnent = document.getElementById("inv-content");

    myinvcotnent.addEventListener('keydown', function(event) {
                if (event.key === ' ') {
                    event.preventDefault();
                }
    });
    svgElement = document.getElementById('progress');
    $(".buttonbuykcoins").click(function(){
        window.invokeNative('openUrl', "https://k9pvp.tebex.io/category/points")
    })
})
function Round(value, numDecimalPlaces){
	if (numDecimalPlaces) {
		let power = 10 ** numDecimalPlaces
		return Math.floor((value * power) + 0.5) / (power)
    } else {
		return Math.floor(value + 0.5)
    }
}
var ancien = ""
var ancienne = ""
var defi = []

window.addEventListener("message", function(e) {
    const data = e.data
    if (data.type == "display") {
        myinventorysell = data.inventory
        Display(data)
        if (ancien == ""){
            //var za = document.getElementById("quotidien")
            //za.style.background = "var(--yellow50)"
            //ancien = "quotidien"
        }
        if (ancienne != ""){
            $("#" + ancienne + " > p").css("color", "")
        }
        if (data.bool){
            $("#inventory > p").css("color", "#FFFFFF")
            ancienne = "inventory"
            $(".bg").css("background", "rgba(13, 15, 17, " + opacity + ")")
            $(".barlinear").show()
            if (data.page){
                console.log(data.page)
                $(".itempaniershop").remove()
                paniershop = []
                $(".panierprice").html("$0")
                SetCurrentPage(data.page)
                buyorsellshop = "buy"
                SetShopPage(alliteminshop)
                $(".sellall").css("display", "none")
            }
        } else {
            $(".barlinear").hide()
        }
    } else if (data.type == "update") {
        UpdateInventory(data)
    } else if (data.type == "initialisation"){
        SetInventoryInitialisation(data.data)
        
    } else if (data.type == "hotbar") {
        SetHotbar(data.hotbar)
    } else if (data.type == "dowlylapute") {
        allstat = data.stats
        SetDowlyLaPute(data)
        
        
        SetInventoryColor(lecolor)
    } else if (data.type == "leaderboard") {
        SetLeaderboard(data)
        SetInventoryColor(lecolor)
    } else if (data.type == "leaderboardcrew") {
        SetLeaderboardCrew(data)
        SetInventoryColor(lecolor)
    } else if (data.type == "ppsteam") {
        $(".lappsteamdujoueuruniverselle").attr("src", data.urlpp);
    } else if (data.type == "defi"){
        defi = data.data
        //$(".challenge-row").remove()
       // if (ancien == ""){
           // var za = document.getElementById("quotidien")
            //za.style.background = "var(--yellow50)"
            //ancien = "quotidien"
       // }
    for (let i = 0; i < defi[ancien].length; i++) {
        const lecontentss = `
            <div class="challenge-row">
                            <div class="iconschallenge">
                                <img src="./assets/icons/AR.png" alt="">
                            </div>
                            <div class="challengemiddle">
                                <div class="challenge-row-title">${defi[ancien][i].label}</div>
                                <div class="progresschallenge">
                                    <div class="progresschallengebar" style="--lavalue: ${percentage(defi[ancien][i].value, defi[ancien][i].maxvalue)}%;">
                                        <div class="progresschallengebarprogress">${defi[ancien][i].value}/${defi[ancien][i].maxvalue}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="challengerecompense">
                                <div class="xp">
                                    <div class="xp-img">
                                        <img src="./assets/icons/xp.png" alt="">
                                    </div>
                                    <div class="xp-value">+1000</div>
                                </div>
                                <div class="money">
                                    <div class="money-img">
                                        <img src="./assets/icons/xp.png" alt="">
                                    </div>
                                    <div class="money-value">+1000</div>
                                </div>
                            </div>
                        </div>
        `
        $(".challenge").append(lecontentss);
        }
    } else if (data.type == "refreshcrew"){
        $(".crew-main").hide()
        $(".crew-image").hide()
        $(".crew-int").show()
        crew = data.crew
        havecrew = true
        allstatcrew = data.crew["crew"].stats
        RefreshCrew()
        SetInventoryColor(lecolor)
    } else if (data.type == "updateinvitecrew"){
        UpdateInviteCrew(data.invitecrew)
    } else if (data.type == "kickcrew"){
        $(".crew-int").hide()
        $(".crew-image").show()
        $(".crew-main").show()
        havecrew = false
        
    } else if (data.type == "refreshkit"){
        SetKit(data.kit)
    } else if (data.type == "setshop"){
        alliteminshop = data.data
        buyorsellshop = "buy"
        SetShopPage(data.data)
        $(".sellall").css("display", "none")
    } else if (data.type == "setcombatmode"){
        combatmode = data.bool
    } else if (data.type == "setmodedejeu"){
        modedejeu = data.value
    }
})

function haveItemInInventory(name){
    if (myinventorysell){
        for (let i = 0; i < myinventorysell.length; i++) {
            if (myinventorysell[i].name == name & myinventorysell[i].count >= 1){
                return true
            }
        }
    }
    
    return false
}

function SetShopPage(data){
    $(".itemshop").remove()
    console.log(data[buyorsellshop], buyorsellshop)
    for (let i = 0; i < data[buyorsellshop].length; i++) {
        var element = data[buyorsellshop][i]
        if ((buyorsellshop == "sell" & haveItemInInventory(element.name)) || buyorsellshop == "buy"){
            var classt = "buyitem"
            var labelt = "Buy"
            if (buyorsellshop == "sell"){
                classt = "sellitem"
                labelt = "Sell"
            }
            if (element.type == typeactuelshop){
                var append = `
                    <div class="itemshop">
                                <img src="assets/items/${element.img}.png" id="imgitemshop">
                                <div class="infoitem">
                                    <div class="nameitem">${element.label}</div>
                                    <div class="typeitem">${element.type.toUpperCase()}</div>
                                    <div class="priceitem">$${element.priceeee}</div>
                                </div>
                                <div class="${classt}" id="${element.name}">${labelt}</div>
                    </div>
                `
                $(".lesitems").append(append)
            }
        }
    }
    $(".itemshop > .buyitem").click(function(){
        AddItemInPanier(this.id, "buy")
    })
    $(".itemshop > .sellitem").click(function(){
        AddItemInPanier(this.id, "sell")
    })
}

function ReturnItemInfo(name, buyorsell){
    for (let i = 0; i < alliteminshop[buyorsell].length; i++) {
        if (alliteminshop[buyorsell][i]["name"] == name){
            return alliteminshop[buyorsell][i]
        }
    }
}

function HaveItemInPanier(name, type){
    for (let i = 0; i < paniershop.length; i++) {
        if (paniershop[i]["name"] == name & paniershop[i]["buyorsell"] == type){
            return [true, paniershop[i], i]
        }
    }
    return [false]
}

function AddItemInPanier(name, buyorsell){
    var boolandarr = HaveItemInPanier(name, buyorsell)
    if (boolandarr[0]){
        boolandarr[1].quantity = boolandarr[1].quantity + 1
    } else {
        var iteminfo = ReturnItemInfo(name, buyorsell)
        var arr = {
            "name": iteminfo.name,
            "label": iteminfo.label,
            "quantity": 1,
            "type": iteminfo.type,
            "price": iteminfo.price,
            "buyorsell": buyorsell
        }
        paniershop.push(arr)
    }
    SetPanierShop()
}

function addCommas(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

function SetPanierShop(){
    $(".itempaniershop").remove()
    var calc = 0
    for (let i = 0; i < paniershop.length; i++) {
        var element = paniershop[i]
        var text = addCommas((Number(element.price) * element.quantity).toString())
        var letrue = ""
        var lesigne = ""
        if (element.buyorsell == "buy"){
            calc = calc + Number(element.price) * element.quantity
            letrue = "rougeprice"
            lesigne = "-"
        } else {
            calc = calc - Number(element.price) * element.quantity
            letrue = "vertprice"
            lesigne = "+"
        }
        
        var append = `
			<div class="itempaniershop">
                        <div class="larowshop">
                            <div class="nameweaponpanier">${element.label}</div>
                            <div class="priceweaponpanier ${letrue}">${lesigne}$${text}</div>
                        </div>
                        <div class="typeweaponpanier">Type : ${element.type.toUpperCase()}</div>
                        <div class="larowshop">
                            <div class="laquantity">
                                <div class="textquantity">Quantity :</div>
									<div class="quantityweaponshop">
                                        <div class="unequantity">${element.quantity}</div>
                                        <div class="listeplusmoins">
                                            <div class="plusquantity" onclick="PlusItemShop('${element.name}', '${element.buyorsell}')">+</div>
                                            <div class="moinsquantity" onclick="MoinsItemShop('${element.name}', '${element.buyorsell}')">-</div>
                                        </div>
                                    </div>
                                <div class="quantityweaponshop"></div>
                            </div>
                            <div class="lapoubelle">
                                <i class="fa-light fa-trash"></i>
                            </div>
                            
                        </div>
           	</div>
		`
        $(".lepanier").append(append)
    }
    $(".panierprice").removeClass("vertprice")
    $(".panierprice").removeClass("rougeprice")
    if (calc > 0){
        $(".panierprice").addClass("rougeprice")
        $(".panierprice").html("-$"+ addCommas(calc))
    } else {
        $(".panierprice").addClass("vertprice")
        calc = calc * -1
        $(".panierprice").html("+$"+ addCommas(calc))
    }
}

function PlusItemShop(name, type){
    var tkt = HaveItemInPanier(name, type)
    tkt[1].quantity = tkt[1].quantity + 1
    SetPanierShop()
}

function MoinsItemShop(name, type){
    var tkt = HaveItemInPanier(name, type)
    if (tkt[1].quantity >= 2){
        tkt[1].quantity = tkt[1].quantity - 1
    } else {
        paniershop.splice(tkt[2], 1)
    }
    SetPanierShop()
}

var labelstats = {
    "kill": "Players Killed",
    "death": "Deaths",
    "zombiekill": "Zombies Killed",
}

var ancienstats = ""

function SetPageStats(str){
    if (str != ancienstats){
        if (ancienstats != ""){
            $("#" + ancienstats).css("background", "")
        }
        ancienstats = str
        $("#" + str).css("background", "#0A0A0A")
    }
    var lesstats = allstat[str]
    var kd = 0
    if (str != "account"){
        kd = GetKD(lesstats["kill"], lesstats["death"])
    }
    $(".lacolonnestat").remove()
    var content = ``
    if (str == "pvp"){
        content = `
			<div class="lacolonnestat">
                            <div class="kdstat lejaune">${kd}</div>
                            <div class="grise soustitre">KD/A</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["kill"]}</div>
                            <div class="grise soustitre">${labelstats["kill"]}</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["death"]}</div>
                            <div class="grise soustitre">${labelstats["death"]}</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["zombiekill"]}</div>
                            <div class="grise soustitre">${labelstats["zombiekill"]}</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${returnk9points(lesstats["kill"], lesstats["zombiekill"], lesstats["death"])}</div>
                            <div class="grise soustitre">K9 Points</div>
                        </div>
		` 
    } else if (str == "darkzone" || str == "redzone"){
        content = `
			<div class="lacolonnestat">
                            <div class="kdstat lejaune">${kd}</div>
                            <div class="grise soustitre">KD/A</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["kill"]}</div>
                            <div class="grise soustitre">${labelstats["kill"]}</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["death"]}</div>
                            <div class="grise soustitre">${labelstats["death"]}</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["zombiekill"]}</div>
                            <div class="grise soustitre">${labelstats["zombiekill"]}</div>
                        </div>
		` 
    } else if (str == "account"){
        content = `
						<div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["timeplay"]}</div>
                            <div class="grise soustitre">Time of played</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["accountcreated"]}</div>
                            <div class="grise soustitre">Account created</div>
                        </div>
		` 
    } else {
        content = `
			<div class="lacolonnestat">
                            <div class="kdstat lejaune">${kd}</div>
                            <div class="grise soustitre">KD/A</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["kill"]}</div>
                            <div class="grise soustitre">${labelstats["kill"]}</div>
                        </div>
                        <div class="lacolonnestat">
                            <div class="kdstat lejaune">${lesstats["death"]}</div>
                            <div class="grise soustitre">${labelstats["death"]}</div>
                        </div>
		` 
    }
    $(".lestatsplayerprofil").append(content)
    $(".lejaune").css("color", lecolor)
}

var ancienstatscrew = ""

function SetPageStatsCrew(str){
    if (str != ancienstatscrew){
        if (ancienstatscrew != ""){
            $("#" + ancienstats).css("background", "")
        }
        ancienstatscrew = str
        $("#" + str).css("background", "#0A0A0A")
    }
    var lesstats = allstatcrew[str]
    var kd = 0
    if (str != "account"){
        kd = GetKD(lesstats["kill"], lesstats["death"])
    }
    $(".lacolonnestatcrew").remove()
    var content = ``
    if (str == "pvp"){
        content = `
			<div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${kd}</div>
                            <div class="grise soustitre">KD/A</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["kill"]}</div>
                            <div class="grise soustitre">${labelstats["kill"]}</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["death"]}</div>
                            <div class="grise soustitre">${labelstats["death"]}</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["zombiekill"]}</div>
                            <div class="grise soustitre">${labelstats["zombiekill"]}</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${returnk9points(lesstats["kill"], lesstats["zombiekill"], lesstats["death"])}</div>
                            <div class="grise soustitre">K9 Points</div>
                        </div>
		` 
    } else if (str == "darkzone" || str == "redzone"){
        content = `
			<div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${kd}</div>
                            <div class="grise soustitre">KD/A</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["kill"]}</div>
                            <div class="grise soustitre">${labelstats["kill"]}</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["death"]}</div>
                            <div class="grise soustitre">${labelstats["death"]}</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["zombiekill"]}</div>
                            <div class="grise soustitre">${labelstats["zombiekill"]}</div>
                        </div>
		` 
    } else if (str == "account"){
        content = `
						<div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["timeplay"]}</div>
                            <div class="grise soustitre">Time of played</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["accountcreated"]}</div>
                            <div class="grise soustitre">Account created</div>
                        </div>
		` 
    } else {
        content = `
			<div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${kd}</div>
                            <div class="grise soustitre">KD/A</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["kill"]}</div>
                            <div class="grise soustitre">${labelstats["kill"]}</div>
                        </div>
                        <div class="lacolonnestatcrew">
                            <div class="kdstat lejaune">${lesstats["death"]}</div>
                            <div class="grise soustitre">${labelstats["death"]}</div>
                        </div>
		` 
    }
    $(".lestatsplayercrew").append(content)
    $(".lejaune").css("color", lecolor)
}

function UpdateInviteCrew(invitecrew){
    $(".popup-inviterow").remove()
    for (let i = 0; i < invitecrew.length; i++) {
        console.log(invitecrew[i].name)
        var content = `
        <div class="popup-inviterow">
                        <div class="popup-invite-crewimage">
                            <img src="${invitecrew[i].image}" alt="">
                        </div>
                        <div class="popup-invite-crewname">
                            <p>${invitecrew[i].name}<p> #</p><p>6666</p></p>
                        </div>
                        <div class="popup-invite-button">
                            <div class="invite-button accept-invite" onclick="acceptinvite('${invitecrew[i].name}')">ACCEPT</div>
                            <div class="invite-button refuse-invite" onclick="refuseinvite('${invitecrew[i].name}')">REFUSE</div>
                        </div>
                    </div>
        `
        $(".popup-invite-content").append(content)
    }
    
}



function GetPlayerOnline(member){
    var online = 0
    for (let i = 0; i < member.length; i++) {
        if (member[i].statut == "ONLINE"){
            online = online + 1
        }
    }
    return online
}

function ReturnGrade(grade){
    if (grade == 0){
        return "member"
    } else if (grade == 1){
        return "admin"
    } else if (grade >= 2){
        return "owner"
    }
}

function RefreshCrew(){
    var membercrew = crew["allmembercrew"]
    var crews = crew["crew"]
    var myperm = crew["myperm"]
    // crew info
    console.log("ici c good ", crews.name)
    $(".mycrewprofil").html(crews.name)
    $(".mycrewname").html(crews.name)
    $(".mycrewtag").html(crews.tag)
    
    $(".mytotalplayercrew").html(membercrew.length + "/30")
    $(".ppcreww").attr('src', crews.image)
    
    // crew stat 
    
    // info membre
    
    $(".itemplayerlist").remove()
    for (let i = 0; i < membercrew.length; i++) {
        var content = ``
        if ((myperm.permission >= 1 & myperm.permission > membercrew[i].permission) || (myperm.identifier == crews.owner)){
			console.log();

            content = `
                

				<div class="itemplayerlist">
                            <img src="${membercrew[i].image}" id="imgplayerlist">
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].idunique}</div>
                                <div class="soustitre">Server ID</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].name}</div>
                                <div class="soustitre">Name</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].kills}</div>
                                <div class="soustitre">Kills</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].deaths}</div>
                                <div class="soustitre">Death</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${GetKD(membercrew[i].kills, membercrew[i].deaths)}</div>
                                <div class="soustitre">K/D</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].money}$</div>
                                <div class="soustitre">Money</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo lejaune">${ReturnGrade(membercrew[i].permission).toUpperCase()}</div>
                                <div class="soustitre">Permission</div>
                            </div>
                            <div class="buttonmanage" id="${membercrew[i].image}" onclick="ManagePlayer('${membercrew[i].idunique}', '${membercrew[i].name}', '${membercrew[i].identifier}')">MANAGE</div>
                            <div class="isplayeronline ${membercrew[i].statut.toLowerCase()}"></div>
                        </div>
            `
        } else {

            content = `
                <div class="itemplayerlist">
                            <img src="${membercrew[i].image}" id="imgplayerlist">
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].idunique}</div>
                                <div class="soustitre">Server ID</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].name}</div>
                                <div class="soustitre">Name</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].kills}</div>
                                <div class="soustitre">Kills</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${membercrew[i].deaths}</div>
                                <div class="soustitre">Death</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">${GetKD(membercrew[i].kills, membercrew[i].deaths)}</div>
                                <div class="soustitre">K/D</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo">0$</div>
                                <div class="soustitre">Money</div>
                            </div>
                            <div class="lacolonneplayerinfo">
                                <div class="textcolonneplayerinfo lejaune">${ReturnGrade(membercrew[i].permission).toUpperCase()}</div>
                                <div class="soustitre">Permission</div>
                            </div>
                            
                            <div class="isplayeronline ${membercrew[i].statut.toLowerCase()}"></div>
                        </div>
            `
        }
        $(".allplayerinfo").append(content)
    }
}

function ManagePlayer(idunique, name, identifier){
    $(".manageplayercrew").css("display", "flex")
    console.log($(this))
    console.log(this.id)
    $("#manageplayercrewimg").attr('src', this.id)
    $(".pseudoplayermanagecrew").html(name + "(" + idunique + ")")
    $(".actionmanageplayer").remove()
    var append = `
		<div class="actionmanageplayer">
                            <div class="uniquekick">
                                <div class="kickmanage" style="background: #FF0000;" onclick="ActionPlayer('kick', '${identifier}')">KICK</div>
                            </div>
                            <div class="autreaction">
                                <div class="demotemanage" style="background: #FF9900;" onclick="ActionPlayer('demote', '${identifier}')">DEMOTE</div>
                                <div class="promotemanage" style="background: #42FF00;" onclick="ActionPlayer('promote', '${identifier}')">PROMOTE</div>
                            </div>
        </div>
	`
    $(".manageplayercrew").append(append)
}

function SetParameterList(evt, cat, para){
    console.log(para)
    if (evt.target.value == "Option1"){
        SetParameter(cat, para, 1)
        if (para == "sound"){
            PlaySound("hitmarker1", 0.25)
        }
    } else if (evt.target.value == "Option2"){
        SetParameter(cat, para, 2)
        if (para == "sound"){
            PlaySound("hitmarker2", 0.25)
        }
    } else if (evt.target.value == "Option3"){
        SetParameter(cat, para, 3)
        if (para == "sound"){
            PlaySound("hitmarker3", 0.25)
        }
    } else if (evt.target.value == "Option4"){
        SetParameter(cat, para, 4)
        if (para == "sound"){
            PlaySound("hitmarker4", 0.25)
        }
    } else if (evt.target.value == "Option5"){
        SetParameter(cat, para, 5)
        if (para == "sound"){
            PlaySound("hitmarker5", 0.25)
        }
    }
}
function SetParameterEnable(evt, cat, para){
    if (evt.target.value == "Option1"){
        SetParameter(cat, para, true)
    } else if (evt.target.value == "Option2"){
        SetParameter(cat, para, false)
    }
}

function ActionPlayer(evt, idunique){ // idunique = identifier
    console.log(evt)
    if (evt == "promote"){
        $.post("https://k9-inventory/ActionPlayer", JSON.stringify({action: "promote", idunique: idunique}))
    } else if (evt == "demote") {
        $.post("https://k9-inventory/ActionPlayer", JSON.stringify({action: "demote", idunique: idunique}))
    } else if (evt == "kick") {
        $.post("https://k9-inventory/ActionPlayer", JSON.stringify({action: "kick", idunique: idunique}))
    }
}

function percentage(partialValue, totalValue) {
    return (100 * partialValue) / totalValue;
 } 

function test(args){
    console.log("uhzruzurhu")
    if (ancien != ""){
        var mp = document.getElementById(ancien)
        mp.style.background = "var(--case)"
        ancien = "quotidien"
    }
    var za = document.getElementById(args)
    za.style.background = "var(--yellow50)"
    ancien = args
    $(".challenge-row").remove()
    for (let i = 0; i < defi[args].length; i++) {
        const lecontentss = `
        <div class="challenge-row">
                            <div class="iconschallenge">
                                <img src="./assets/icons/AR.png" alt="">
                            </div>
                            <div class="challengemiddle">
                                <div class="challenge-row-title">${defi[args][i].label}</div>
                                <div class="progresschallenge">
                                    <div class="progresschallengebar" style="--lavalue: ${percentage(defi[args][i].value, defi[args][i].maxvalue)}%;">
                                        <div class="progresschallengebarprogress">${defi[args][i].value}/${defi[args][i].maxvalue}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="challengerecompense">
                                <div class="xp">
                                    <div class="xp-img">
                                        <img src="./assets/icons/xp.png" alt="">
                                    </div>
                                    <div class="xp-value">+1000</div>
                                </div>
                                <div class="money">
                                    <div class="money-img">
                                        <img src="./assets/icons/xp.png" alt="">
                                    </div>
                                    <div class="money-value">+1000</div>
                                </div>
                            </div>
                        </div>
        `
        $(".challenge").append(lecontentss);
    }
}

function SetLeaderboard(data){
    $(".TopItem").remove()
    for (let i = 0; i < 4; i++) {
        if (data.leaderboard[i]){
            var contents = `
                <div class="TopItem">
                    <div class="top-image">
                        <img src="${data.leaderboard[i].img}" alt="">
                    </div>
                    <div class="place"><p>#${i + 1}</p></div>
                    <div class="username-leaderboardTop">
                        <p>${data.leaderboard[i].name}</p>
                    </div>
    
                </div>
            `
            $(".PlayerTopThree").append(contents)
        }
    }
    $(".sdtleaderboardrow-item").remove()
    if (data.myplacement){
        var resulte = Round(data.myplacement.kills / data.myplacement.deaths, 2)
            if (data.myplacement.deaths == 0){
                if (data.myplacement.kills != 0){
                    resulte = data.myplacement.kills
                } else {
                    resulte = 0
                }
            }
        var lecontent = `
            <div class="sdtleaderboardrow-item" style="background: var(--yellow60);">
                <h1>${data.myplacement.placement}</h1>
                <p>${data.myplacement.name}</p>
                <p>${data.myplacement.points}</p>
                <p>${data.myplacement.kills}</p>
                <p>${data.myplacement.deaths}</p>
                <p>${resulte}</p>
            </div>
        `
            $(".sdtleaderboard-content").append(lecontent)
    }
    for (let i = 0; i < 100; i++) {
        if (data.leaderboard[i]){
            var result = Round(data.leaderboard[i].kills / data.leaderboard[i].deaths, 2)
            if (data.leaderboard[i].deaths == 0){
                if (data.leaderboard[i].kills != 0){
                    result = data.leaderboard[i].kills
                } else {
                    result = 0
                }
            }
            var lecontent = `
                <div class="sdtleaderboardrow-item">
                    <h1>${i + 1}</h1>
                    <p>${data.leaderboard[i].name}</p>
                    <p>${data.leaderboard[i].points}</p>
                    <p>${data.leaderboard[i].kills}</p>
                    <p>${data.leaderboard[i].deaths}</p>
                    <p>${result}</p>
                </div>
            `
            $(".sdtleaderboard-content").append(lecontent)
        }
    }
    
}


function SetLeaderboardCrew(data){
    $(".TopItemcrew").remove()
    for (let i = 0; i < 4; i++) {
        if (data.leaderboardcrew[i]){
            var contents = `
                <div class="TopItemcrew">
                    <div class="topcrew-image">
                        <img src="${data.leaderboardcrew[i].img}" alt="">
                    </div>
                    <div class="placecrew"><p>#${i + 1}</p></div>
                    <div class="username-leaderboardcrewTop">
                        <p>${data.leaderboardcrew[i].name}</p>
                    </div>
    
                </div>
            `
            $(".PlayerTopThreecrew").append(contents)
        }
    }
    
    $(".sdtleaderboardcrewrow-item").remove()
    for (let i = 0; i < 100; i++) {
        if (data.leaderboardcrew[i]){
            var lecontent = `
                <div class="sdtleaderboardcrewrow-item">
                    <h1>${i + 1}</h1>
                    <p>${data.leaderboardcrew[i].name}</p>
                    <p>${data.leaderboardcrew[i]["stats"]["pvp"].kill}</p>
                    <p>${data.leaderboardcrew[i]["stats"]["pvp"].death}</p>
                    <p>${GetKD(data.leaderboardcrew[i]["stats"]["pvp"].kill, data.leaderboardcrew[i]["stats"]["pvp"].death)}</p>
                    <p>${data.leaderboardcrew[i]["stats"]["redzone"].kill}</p>
                    <p>${data.leaderboardcrew[i]["stats"]["redzone"].death}</p>
                </div>
            `
            $(".sdtleaderboardcrew-content").append(lecontent)
        }
    }
}

function GetKD(kills, deaths){
    var result = Round(kills / deaths, 2)
    if (deaths == 0){
        if (kills != 0){
            result = kills
        } else {
            result = 0
        }
    }
    return result
}
function returnk9points(kill, zombie, death){
    var result = Round(kill * zombie / death, 2)
    if (death == 0){
        result = kill * zombie
    }
    return result
}



function SetDowlyLaPute(data){
    $(".pseudo").html(data.name + " (" + data.idunique + ")")
    $(".moneyuniversel").html("$" + data.money)
    $(".moneyshop").html("Balance : $" + data.money)
    $(".pseudouniversel").html(data.name)
    $(".monidaccountprofil").html(data.idunique)
    $(".myk9pointsprofil").html(returnk9points(data.stats["pvp"]["kill"], data.stats["pvp"]["zombiekill"], data.stats["pvp"]["death"]))
    $("#progress-text").html(data.level[0])
    svgElement.style.setProperty('--percentage', data.level[1]);
    $(".mycountryprofil").html(data.pays)
    $(".monnombrekcoinsaccountprofil").html(data.kcoin)
    if (data.transaction.length == 0){
        $(".havenottransaction").show()
    } else {
        $(".havenottransaction").hide()
    }
    
    if (data.crew["crew"].name != ""){
        $(".crew-main").hide()
        $(".crew-image").hide()
        $(".crew-int").show()
        crew = data.crew
        havecrew = true
        allstatcrew = data.crew["crew"].stats
    }
}

function SetCurrentPage(str){
    if (str != "profil" & str != "shop"){
        if (ancienne != ""){
            $("#" + ancienne + " > p").css("color", "")
        }
        $("#" + str + " > p").css("color", "#FFFFFF")
    }
    $(".bg").css("background", "rgba(13, 15, 17, " + opacity + ")")
    $(".manageplayercrew").css("display", "none")
    ancienne = str
    if (str === "inventory"){
        $(".sdt-main-contain").css("display", "flex")
        $(".leaderboard").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".profile").css("display", "none")
        $(".crew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".settings").css("display", "none")
        $(".help").css("display", "none")
        $(".kit").css("display", "none")
        $(".arena").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".sdt-main-contain").fadeIn(500)
        $(".side-bar-information-container").fadeIn(500)
    } else if (str === "profile") {
        $(".sdt-main-contain").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".crew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".settings").css("display", "none")
        $(".help").css("display", "none")
        $(".kit").css("display", "none")
        $(".arena").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".bg").css("background", "#131517")
        $(".profile").fadeIn(500)
        SetPageStats("pvp")
        
    } else if (str === "leaderboard") {
        $(".sdt-main-contain").css("display", "none")
        $(".profile").css("display", "none")
        $(".crew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".settings").css("display", "none")
        $(".help").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".kit").css("display", "none")
        $(".arena").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".leaderboard").fadeIn(500)
    } else if (str === "crew") {
        $(".sdt-main-contain").css("display", "none")
        $(".profile").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".settings").css("display", "none")
        $(".help").css("display", "none")
        $(".arena").css("display", "none")
        $(".kit").css("display", "none")
        
        if (havecrew) {
            $(".crew").css("display", "none")
            $(".lecrewzz").fadeIn(500)
            SetPageStatsCrew("pvp")
            $(".bg").css("background", "#131517")
            RefreshCrew()
        	SetInventoryColor(lecolor)
        } else {
            $(".crew").fadeIn(500)
            $(".lecrewzz").css("display", "none")
        }
        
    } else if (str === "shop") {
        $(".sdt-main-contain").css("display", "none")
        $(".profile").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".crew").css("display", "none")
        $(".settings").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".help").css("display", "none")
        $(".arena").css("display", "none")
        $(".kit").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".leshop").fadeIn(500)
        $(".bg").css("background", "#131517")
    } else if (str === "settings") {
        $(".sdt-main-contain").css("display", "none")
        $(".profile").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".crew").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".help").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".leshop").css("display", "none")
        $(".kit").css("display", "none")
        $(".arena").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".bg").css("background", "#131517")
        $(".settings").fadeIn(500)
    } else if (str === "help") {
        $(".sdt-main-contain").css("display", "none")
        $(".profile").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".crew").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".settings").css("display", "none")
        $(".kit").css("display", "none")
        $(".arena").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".help").fadeIn(500)
    } else if (str == "kit") {
        $(".sdt-main-contain").css("display", "none")
        $(".profile").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".crew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".settings").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".help").css("display", "none")
        $(".arena").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".kit").fadeIn(500)
    } else if (str == "leaderboardcrew") {
        $(".sdt-main-contain").css("display", "none")
        $(".profile").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".crew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".settings").css("display", "none")
        $(".help").css("display", "none")
        $(".arena").css("display", "none")
        $(".kit").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".leaderboardcrew").fadeIn(500) 
    } else if (str == "arena") {
        $(".sdt-main-contain").css("display", "none")
        $(".profile").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".crew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".settings").css("display", "none")
        $(".help").css("display", "none")
        $(".kit").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".lecrewzz").css("display", "none")
        $(".arena").fadeIn(500) 
    }
}

function ok(int){
    $.post('https://k9-inventory/buy', JSON.stringify({
        boutique: int
    }));
}

UpdateInventory = data => {
    if(data.inventory){
        LoadPlayerInventory(data.inventory)
        PlayerItems["inventory"] = data.inventory
    }
    if (data.otherInventory) {
        LoadOtherInventory(data.otherInventory, OtherInventoryType)
        PlayerItems["protected"] = data.otherInventory
    }
    if (data.inventoryInfo) {
        SetInventorySettings(data.inventoryInfo)
    }
    handleDragDrop()
}


Display = data => {
    if (data.bool) {
        if (Config.SecondaryInventoryTypes[data.inventoryInfo.name]) {
            $(".sdt-main-contain").addClass("stash-active-main")
        } else {
            $(".sdt-main-contain").removeClass("stash-active-main")
        }
        PlayerItems["inventory"] = data.inventory
        PlayerItems["protected"] = data.otherInventory
        LoadPlayerInventory(data.inventory)
        LoadOtherInventory(data.otherInventory, data.inventoryInfo.name)
        SetInventorySettings(data.inventoryInfo)
        $(".bg").show()
        $(".container").show()
        $(".sdt-main-contain").css("display", "flex")
        $(".side-bar-information-container").show()
        handleDragDrop()
    } else {
        OtherInventoryType = null
        $(".bg").hide()
        $(".container").hide()
        $(".sdt-main-contain").css("display", "none")
        $(".leaderboard").css("display", "none")
        $(".leaderboardcrew").css("display", "none")
        $(".profile").css("display", "none")
        $(".crew").css("display", "none")
        $(".leshop").css("display", "none")
        $(".settings").css("display", "none")
        $(".side-bar-information-container").css("display", "none")
        $(".kit").css("display", "none")
        $(".help").css("display", "none")
        $(".arena").css("display", "none")
        $(".lecrewzz").css("display", "none")
    }
}

LoadPlayerInventory = inventory => {
    console.log("zrizrikz")
    $(".sdt-player-inv > .sdt-inv-content > .sdt-item-slot").remove()
    $.each(inventory, function (k, v) { 
        if (v){
            const content = `
            <div class="sdt-item-slot" id="${v.name + "inventory"}" data-itemdata=${JSON.stringify({itemName: v.name, itemCount: v.count, currentContainer: "inventory"})}>
                <div class="image-bg">
                    <img src=${v.image} alt="">
                </div>
                <div class="item-slot-info">
                    <h1>${v.label}</h1>
                    <p class="item-count">X${v.count}</p>
                </div>
            </div>
        `
        $(".sdt-player-inv > .sdt-inv-content").append(content);
        }
        
    });
}

LoadOtherInventory = (otherInventory, inventoryType) => {
    $(".sdt-protected-inv > .sdt-inv-content > .sdt-item-slot").remove()
    $.each(otherInventory, function (k, v) { 
        if (v){
            const content = `
                <div class="sdt-item-slot" id="${v.name + "protected"}" data-itemdata=${JSON.stringify({itemName: v.name, itemCount: v.count, currentContainer: inventoryType})}>
                    <div class="image-bg">
                        <img src=${v.image} alt="">
                    </div>
                    <div class="item-slot-info">
                        <h1>${v.label}</h1>
                        <p class="item-count">X${v.count}</p>
                    </div>
                </div>
            `
        	$(".sdt-protected-inv > .sdt-inv-content").append(content);
        }
        
    });
}

SetInventorySettings = settings => {
    if (settings.label){
        $(".sdt-protected-inv > .sdt-inv-header > h1 > strong").html(settings.label.toUpperCase())
    }
    if (settings.name) {
        OtherInventoryType = settings.name
    }
    if (settings.otherInventoryWeight || settings.otherInventoryWeight == 0) {
        $(".sdt-protected-inv > .sdt-inv-header > .header-weight > .weight-text > p > .weight").html(settings.otherInventoryWeight)
        $(".sdt-protected-inv > .sdt-inv-header > .header-weight > .weight-text > p > .weight").html(settings.otherInventoryWeight)
    }
    if (settings.inventoryWeight || settings.inventoryWeight == 0) {
        $(".sdt-player-inv > .sdt-inv-header > .header-weight > .weight-text > p > .weight").html(settings.inventoryWeight)
    }
    if (settings.maxWeight || settings.maxWeight == 0) {
        OtherMaxWeight = settings.maxWeight
    }
    if (settings.invMax || settings.invMax == 0) {
        PlayerMaxWeight = settings.invMax
    }
    //$(".sdt-player-inv > .sdt-inv-header > .header-weight > .weight-text > p > .maxWeight").html(PlayerMaxWeight)
    //$(".sdt-protected-inv > .sdt-inv-header > .header-weight > .weight-text > p > .maxWeight").html(OtherMaxWeight)
    //$(".sdt-player-inv > .sdt-inv-header > .header-weight > .weight-progress > .progress").css("width", (settings.inventoryWeight / PlayerMaxWeight) * 100 + "%")
    //$(".sdt-protected-inv > .sdt-inv-header > .header-weight > .weight-progress > .progress").css("width", (settings.otherInventoryWeight / OtherMaxWeight) * 100 + "%")

}

SetHotbar = hotbar => {
    $(".sdt-hotbarinv-content > .sdt-item-slot").remove()
    for (let i = 0; i < 7; i++) {
        const v = hotbar[i]
        const content = `
            <div class="sdt-item-slot ${v && v.rarity && v.hasItem ? (v.rarity + "-item") : ""}" data-id="${i + 1}" name="hotbar">
                <div class="item-slot-state"></div>
                ${v && v.image && v.hasItem ? `<img src=${v.image} alt="">`:""}
                <div class="item-slot-info">
                    <h1>${v && v.label && v.hasItem ? v.label:""}</h1>
                </div>
                <div class="hotbarslot-numbers">
                    <h1>${i + 1}</h1>
                </div>
            </div>
        `
        $(".sdt-hotbarinv-content").append(content);
    }
    handleDragDrop()
}

var DraggingData = null
function searchItem(inventory, item) {
    for (let i = 0; i < PlayerItems[inventory].length; i++) {
        if (PlayerItems[inventory][i] && PlayerItems[inventory][i].name === item) {
            return [true, PlayerItems[inventory][i], i];
        }
    }
    return [false];
}

function handleDragDrop(){

    $(".sdt-inv-content > .sdt-item-slot").draggable({
        helper: 'clone',
        appendTo: "body",
        scroll: false,
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
    
    $(".sdt-player-inv").droppable({
        hoverClass: 'item-slot-hoverClass',
        drop: function(event, ui) {
            if (DraggingData["currentContainer"] != "inventory" ) {
                if (modedejeu == "pvp" || modedejeu == "entrainement"){
                    $.post("https://k9-inventory/ItemDrag", JSON.stringify({itemName: DraggingData["itemName"], count: 1, fromType: OtherInventoryType, toType: "inventory"}));
                    let [bool, litem, i] = searchItem("protected", DraggingData["itemName"]);
                    if (bool) {
                        if (litem.count >= 1) {
                            let [bool2, litem2] = searchItem("inventory", DraggingData["itemName"]);
                            if (bool2) {
                                litem2.count += 1;
                                $("#" + litem2.name + "inventory" + " > .item-slot-info > .item-count").html("X" + litem2.count)
                            } else {
                                let newItem = {
                                    name: DraggingData["itemName"],
                                    count: 1,
                                    rarity: "rare",
                                    label: litem.label,
                                    image: litem.image,
                                    weight: 0,
                                };
                                PlayerItems["inventory"].push(newItem);
                                    var append = `
                                        <div class="sdt-item-slot" id="${DraggingData["itemName"] + "inventory"}" data-itemdata=${JSON.stringify({itemName: DraggingData["itemName"], itemCount: 1, currentContainer: "inventory"})}>
                                            <div class="image-bg">
                                                <img src=${litem.image} alt="">
                                            </div>
                                            <div class="item-slot-info">
                                                <h1>${litem.label}</h1>
                                                <p class="item-count">X1</p>
                                            </div>
                                        </div>
                                    `
                                    $(".sdt-player-inv > .sdt-inv-content").append(append);
                                handleDragDrop()

                            }
                            litem.count -= 1;
                            if (litem.count <= 0) {
                                PlayerItems["protected"].splice(i, 1);
                                $("#" + litem.name + "protected").remove()
                            } else {
                                $("#" + litem.name + "protected" + " > .item-slot-info > .item-count").html("X" + litem.count)
                            }

                        }
                    }
                }
                
                
                //DragEvent++;
            }

            //setTimeout(function() {
                //DragEvent--;
            //}, 200);
        },
    });

    $(".sdt-protected-inv").droppable({
        hoverClass: 'item-slot-hoverClass',
        drop: function(event, ui) {
            if(OtherInventoryType && OtherInventoryType != DraggingData["currentContainer"]) {
                if ((combatmode == false) & (modedejeu == "pvp" || modedejeu == "entrainement")){
                    $.post("https://k9-inventory/ItemDrag", JSON.stringify({itemName: DraggingData["itemName"], count: 1, fromType: "inventory", toType: OtherInventoryType}));
                    let [bool, litem, i] = searchItem("inventory", DraggingData["itemName"]);
                    if (bool) {
                        if (litem.count >= 1) {
                            let [bool2, litem2] = searchItem("protected", DraggingData["itemName"]);
                            if (bool2) {
                                litem2.count += 1;
                                $("#" + litem2.name + "protected" + " > .item-slot-info > .item-count").html("X" + litem2.count)
                            } else {
                                let newItem = {
                                    name: DraggingData["itemName"],
                                    count: 1,
                                    rarity: "rare",
                                    label: litem.label,
                                    image: litem.image,
                                    weight: 0,
                                };
                                PlayerItems["protected"].push(newItem);
                                    var append = `
                                    <div class="sdt-item-slot" id="${DraggingData["itemName"] + "protected"}" data-itemdata=${JSON.stringify({itemName: DraggingData["itemName"], itemCount: 1, currentContainer: "protected"})}>
                                        <div class="image-bg">
                                            <img src=${litem.image} alt="">
                                        </div>
                                        <div class="item-slot-info">
                                            <h1>${litem.label}</h1>
                                            <p class="item-count">X1</p>
                                        </div>
                                    </div>
                                    `
                                    $(".sdt-protected-inv > .sdt-inv-content").append(append);
                                handleDragDrop()

                            }
                            litem.count -= 1;
                            if (litem.count <= 0) {
                                PlayerItems["inventory"].splice(i, 1);
                                $("#" + litem.name + "inventory").remove()
                            } else {
                                $("#" + litem.name + "inventory" + " > .item-slot-info > .item-count").html("X" + litem.count)
                            }

                        }
                    }
                }
            }
            //setTimeout(function() {
                //DragEvent--;
            //}, 200);
        }
    });

    $(".sdt-hotbar-inv > .sdt-hotbarinv-content > .sdt-item-slot").droppable({
        hoverClass: 'item-slot-hoverClass',
        drop: function(event, ui) {
            $.post("https://k9-inventory/SetHotbar", JSON.stringify({id: $(this).data("id"), itemName: DraggingData["itemName"]}));
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

$(document).on("contextmenu", ".sdt-item-slot", function(e){
    const itemData = $(this).data("itemdata")
    const isHotbar = $(this).attr("name") == "hotbar"
    if (!isHotbar) {
        if ((combatmode == false || itemData.currentContainer == "protected") & (modedejeu == "pvp" || modedejeu == "entrainement")){
            const count = ShiftOrControlCount(itemData)
        $.post("https://k9-inventory/ItemDrag", JSON.stringify({itemName: itemData["itemName"], count: count, fromType: itemData.currentContainer, toType: OtherInventoryType == itemData.currentContainer ? "inventory" : OtherInventoryType}));
        var fromtype = OtherInventoryType == itemData.currentContainer ? "inventory" : "protected"
        let [bool, litem, i] = searchItem(itemData.currentContainer, itemData["itemName"]);
                if (bool) {
                    if (litem.count >= count) {
                        let [bool2, litem2] = searchItem(fromtype, itemData["itemName"]);
                        if (bool2) {
                            litem2.count += count;
                            $("#" + litem2.name + fromtype + " > .item-slot-info > .item-count").html("X" + litem2.count)
                            $("#" + litem2.name + fromtype).data("itemdata", {itemName: litem2.name, itemCount: litem2.count, currentContainer: fromtype})
                        } else {
                            let newItem = {
                                name: itemData["itemName"],
                                count: count,
                                rarity: "rare",
                                label: litem.label,
                                image: litem.image,
                                weight: 0,
                            };
                            PlayerItems[fromtype].push(newItem);
                            var append = ``
                            if (fromtype == "inventory"){
                                append = `
									<div class="sdt-item-slot" id="${itemData["itemName"] + "inventory"}" data-itemdata=${JSON.stringify({itemName: itemData["itemName"], itemCount: count, currentContainer: "inventory"})}>
                                        <div class="image-bg">
                                            <img src=${litem.image} alt="">
                                        </div>
                                        <div class="item-slot-info">
                                            <h1>${litem.label}</h1>
                                            <p class="item-count">X${count}</p>
                                        </div>
                                    </div>
								`
                                $(".sdt-player-inv > .sdt-inv-content").append(append);
                            } else {
                                append = `
                                <div class="sdt-item-slot" id="${itemData["itemName"] + "protected"}" data-itemdata=${JSON.stringify({itemName: itemData["itemName"], itemCount: count, currentContainer: "protected"})}>
                                    <div class="image-bg">
                                        <img src=${litem.image} alt="">
                                    </div>
                                    <div class="item-slot-info">
                                        <h1>${litem.label}</h1>
                                        <p class="item-count">X${count}</p>
                                    </div>
                                </div>
								`
                                $(".sdt-protected-inv > .sdt-inv-content").append(append);
                            }
                            handleDragDrop()
                        }
                        litem.count -= count;
                        if (litem.count <= 0) {
                            PlayerItems[itemData.currentContainer].splice(i, 1);
                            $("#" + litem.name + itemData.currentContainer).remove()
                        } else {
                            $("#" + litem.name + itemData.currentContainer + " > .item-slot-info > .item-count").html("X" + litem.count)
                            $(this).data("itemdata", {itemName: itemData["itemName"], itemCount: litem.count, currentContainer: itemData.currentContainer})
                        }
                        
                    }
                }
        }
    } else {
        $.post("https://k9-inventory/SetHotbar", JSON.stringify({id: $(this).data("id"), itemName: false}));
    }
})

$(document).on("dblclick", ".sdt-item-slot", function(e){
    const itemData = $(this).data("itemdata")
    const isHotbar = $(this).attr("name") == "hotbar"
    if (!isHotbar) {
        const count = ShiftOrControlCount(itemData)
        $.post("https://k9-inventory/RemoveItem", JSON.stringify({itemName: itemData["itemName"], count: count, fromType: itemData.currentContainer}));
    }
})

$(document).on("keydown", function(e){
    switch (e.which) {
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
    53: 5,
    54: 6,
    55: 7
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
            $.post("https://k9-inventory/SetHotbar", JSON.stringify({id: v, itemName: MouseData.itemName}));
        }
    });
    $.each(Config.CloseKeys, function (k, v) { 
        if (e.key == v) {
            $.post("https://k9-inventory/Close");
        }
    });
})

$(document).on("mouseenter", ".sdt-item-slot", function(){
    const itemData = $(this).data("itemdata")
    console.log("mouse enter item slot")
    MouseData = itemData
})

$(document).on("mouseleave", ".sdt-item-slot", function(){
    MouseData = null
})





function popupopen() {
    $(".popup-create").show()
}

function Cancel() {
    $(".popup-create").hide()
}

function accept() {
    var crewname = document.getElementById('crewnamee').value
    var crewtag = document.getElementById('crewtage').value
    var crewimage = document.getElementById('crewimagee').value
    console.log(crewname, crewtag, crewimage)
    if (crewname != "" & crewtag != "" & crewimage != ""){
        $("<img>", {
            src: crewimage,
            error: function() { console.log("URL invalid") },
            load: function() { 
                $.post("https://k9-inventory/CreateCrew", JSON.stringify({crewname: crewname, crewtag: crewtag, crewimage: crewimage}))
                $(".crew").css("display", "none")
                $(".lecrewzz").fadeIn(500)
                $(".bg").css("background", "#131517")
            }
        });
    } else {
        console.log("Missing information")
    }
    $(".popup-create").hide()
    
}

function popupinvite() {
    $(".popup-invite").show()
}


function popupinviteclose() {
    $(".popup-invite").hide()
}

function statsopen() {
    $(".statscrewint").show()
    $(".crewint-image").hide()
    $(".crewint-info").hide()
}

function returncrew(){
    $(".statscrewint").hide()
    $(".crewint-image").show()
    $(".crewint-info").show()
}

function acceptinvite(name){
    console.log("tu a cliqué accept sur " + name)
    $.post("https://k9-inventory/AccepteInvite", JSON.stringify({crewname: name}))
    $(".popup-invite").hide()
}

function refuseinvite(name){
    console.log("tu a cliqué refuse sur " + name)
    $.post("https://k9-inventory/RefuseInvite", JSON.stringify({crewname: name}))
}

function LeaveCrew(){
    $(".crew").fadeIn(500)
    $(".lecrewzz").css("display", "none")
    $(".bg").css("background", "rgba(13, 15, 17, " + opacity + ")")
    $(".manageplayercrew").css("display", "none")
    $.post("https://k9-inventory/LeaveCrew")
}


$(document).on("mouseenter", ".achieved", function(){
    $(".starterkit").css("background", "linear-gradient(270deg, #79C370 0%, rgba(47, 89, 42, 0.00) 52.08%, #79C370 100%)")
})

$(document).on("mouseenter", ".itemkit", function(){
    if ((this.id == "gold" & gold) || (this.id == "diamond" & diamond) || (this.id != "gold" & this.id != "diamond")){
        if ($("#" + this.id + " > .titleallkit").text() != ""){
            $(".titlestarter").html($("#" + this.id + " > .titleallkit").text())
            $(".titlestarter").css("color", "rgb(255,255,255)")
        } else {
            $(".titlestarter").html("KIT ACHIEVED")
            $(".titlestarter").css("color", "#79C370")
        }
    } else {
        if ($("#" + this.id + " > .titleallkit").text() != ""){
            $(".titlestarter").html("YOU DON'T HAVE " + $("#" + this.id + " > .titleallkit").text())
            $(".titlestarter").css("color", "rgb(255,255,255)")
        } else {
            $(".titlestarter").html("YOU DON'T HAVE " + $("#" + this.id + " > .achieved > .haut > .titleallkit").text())
            $(".titlestarter").css("color", "rgb(255,255,255)")
        }
    }
    console.log()
    if ($("#" + this.id + " > .titleallkit").text() != ""){
        $(".vehicle").attr('src', $("#" + this.id + " > .imagecontenue > .vehiclecontenue").attr('src'))
        $(".weapon").attr('src', $("#" + this.id + " > .imagecontenue > .weaponcontenue").attr('src'))
        $("#labelweapon").html($("#" + this.id + " > .imagecontenue > .weaponcontenue").attr('label'))
        $("#labelvehicle").html($("#" + this.id + " > .imagecontenue > .vehiclecontenue").attr('label'))
    } else {
        $(".vehicle").attr('src', $("#" + this.id + " > .achieved > .imagecontenue > .vehiclecontenue").attr('src'))
        $(".weapon").attr('src', $("#" + this.id + " > .achieved > .imagecontenue > .weaponcontenue").attr('src'))
        $("#labelweapon").html($("#" + this.id + " > .achieved > .imagecontenue > .weaponcontenue").attr('label'))
        $("#labelvehicle").html($("#" + this.id + " > .achieved > .imagecontenue > .vehiclecontenue").attr('label'))
    }
})

$(document).on("mouseleave", ".achieved", function(){
    $(".starterkit").css("background", "linear-gradient(270deg, rgba(29, 29, 27, 0) 0%, #1D1D1B 52.08%, rgba(29, 29, 27, 0) 100%")
})

$(document).on("input", ".recherche > label > input", function(e) {
    const value = $(this).val()
    for (let i = 0; i < $(".itemshop").length; i++) {
        const element = $(".itemshop").eq(i)
        const element2 = $(".itemshop > .infoitem > .nameitem").eq(i)
        var lavalue = value.toUpperCase()
        var valuedeux = element2.html().toUpperCase()
        if (valuedeux.includes(lavalue)) {
            element.css("display", "flex")
        } else {
            element.css("display", "none")
        }
    }
})

function arena(args){
    $.post("https://k9-inventory/Close");
    $.post("https://k9-inventory/GoArena", JSON.stringify({name: args}))
}