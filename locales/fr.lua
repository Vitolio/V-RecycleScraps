local Translations = {  
	menu = {
      header = "Fonderie",
      recycleMaterials = "Fondre ou recycler des matériaux",
      sellMaterials = "Vendre des matériaux ",
      buyMaterials = "Acheter des matériaux ",
      goodBye = "Au revoir",
      noConversion = "Aucune conversion",
      goBackward = "Revenir en arrière",
      convert = "Fondre / Convertir ",
      tradeMaterials= "Echanger matériaux",
      amountToConvert = "Qte à convertir",
      convertTo = "Convertir vers :",
      price = "Prix : ",
      submit = "Valider",
      quantity = "Quantité",
    },
    ped = {
    	talkto = "Parler au recycleur",
    },
    error = {
    	notEnoughMaterials = "Désolé, vous n'offrez pas assez de matériaux",
    	notEnoughMaterialsOnYou = "Désolé, vous n\'avez pas suffisamment de ",
    	notEnoughStock = "Désolé, pas asser de stock pour votre demande",
    	notEnoughMoney ="Vous n\'avez pas asser d\'argent",
    	notEnoughMaterialsOnYouFull = "On dirait que vous n\'avez pas les ressources ?",
    },
    success = {
    	successConvert = "Ok, voilà pour vous !",
    	successBuy = "Merci bien ! Voila pour vous !",
    	successSell = "Merci bien ! Un plaisir de faire affaire !",
    },
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})