Config = {}
Config.Debug = false
Config.Account = 'gouvernement' -- Account that will receive the money, leave empty if not account
Config.TypeOfPayment = 'cash' -- 'cash' | 'bank'

--Allow everyActions
Config.AllowBuyingMenu = true
Config.AllowSellingMenu = true
Config.AllowConvertMenu = true

Config.pedLocations = { 
    {
        coordinates =vector4(1073.55, -1987.76, 29.91, 234.45),
        npc = 's_m_m_ccrew_01',
        customScenario = true,
        scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY",
        blip = true,
        blipBackground = true,
        proximityBlipOnly = false,
        bliplabel = 'Fonderie',
        blipSprite = 365,
        blipColour = 25,
        blipSize = 1.0,
        blipBackgroundColour = 52,
        blipBackgroundSize = 1.6,
    },    
}

Config.FoundryPrice = { -- Price of the foundry per item, this list must be the same than the one in the db
	["glass"] = {--Must be the same than in your qbcore.shared.items
		playerSell = 3, --Price at wich foundry buy to Player
		playerBuy = 6, --Price at wich the foundry sell to PlayerBuy
	},
	["rubber"] = {
		playerSell = 2,
		playerBuy = 4,
	},
	["plastic"] =  {
		playerSell = 2,
		playerBuy = 4,
	},
	["iron"] = {
		playerSell = 4,
		playerBuy = 8,
	},
	["ironoxide"] =  {
		playerSell = 4,
		playerBuy = 8,
	},
	["steel"] = {
		playerSell = 5,
		playerBuy = 10,
	},
	["aluminum"] = {
		playerSell = 3,
		playerBuy = 6,
	},
	["aluminumoxide"] = {
		playerSell = 4,
		playerBuy = 8,
	},
	["copper"] = {
		playerSell = 4,
		playerBuy = 8,
	},
	["metalscrap"] = {
		playerSell = 3,
		playerBuy = 6,
	},
}

--Items to convert into another list, key is the item you have and every "items" is conversion option for this item
Config.FoundryConversion = {
	["empty_glass_bottle"] = {
		items = {
			["glass"] = { --Must be the same than in your qbcore.shared.items
				qtyReceive = 2 -- it mean : Number of items that the player have to give to receive 1 from this one
			},
		},
	},
	["empty_plastic_bottle"] = {		
		items = {
			["rubber"] ={
				qtyReceive = 3
			},
			["plastic"] ={
				qtyReceive = 2
			},
		},	
	},
	["empty_can"] = {
		items = {
			["iron"] ={
				qtyReceive = 3
			},
			["ironoxide"] ={
				qtyReceive = 2
			},
			["steel"] ={
				qtyReceive = 3
			},
		},	
	},
	["wrapper"] = {
		items = {
			["aluminum"] ={
				qtyReceive = 3
			},
			["aluminumoxide"] ={
				qtyReceive = 2
			},
		},	
	},

	["wire"] = {
		items = {
			["copper"] ={
				qtyReceive = 2
			},
			["metalscrap"] ={
				qtyReceive = 2
			},
		},	
	},
}