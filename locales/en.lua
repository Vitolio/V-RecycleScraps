local Translations = {	
    menu = {
		header = "Foundry",
		recycleMaterials = "Melt or recycle materials",
		sellMaterials = "Sell materials",
		buyMaterials = "Buy materials",
		goodBye = "Goodbye",
		noConversion = "No conversion",
		goBackward = "Go back",
		convert = "Melter / Convert: ",
		tradeMaterials= "Exchange materials",
		amountToConvert = "Quantity to convert",
		convertTo = "Convert to:",
		price = "Price: ",
		submit = "Validate",
		quantity = "Quantity",
    },
    ped = {
    	talkto = "Talk to the recycler",
    },
    error = {
    	notEnoughMaterials = "Sorry, you don't offer enough materials",
	    notEnoughMaterialsOnYou = "Sorry, you don\'t have enough",
	    notEnoughStock = "Sorry, not enough stock for your request",
	    notEnoughMoney ="You don\'t have enough money",
	    notEnoughMaterialsOnYouFull = "Looks like you don't have the resources?",
    },
    success = {
    	successConvert = "Ok, here's it for you!",
	    successBuy = "Thank you! That's it for you!",
	    successSell = "Thank you! A pleasure to do some business with you!",
    },
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})