local QBCore = exports['qb-core']:GetCoreObject()

local function FetchOneProduct(productName)
    return MySQL.Sync.fetchAll("SELECT * FROM foundry_items WHERE name = @productName", {['@productName'] = productName})
end

local function UpdateProduct(productName, amount)
    local result = MySQL.update('UPDATE foundry_items SET stock = @amount WHERE name = @productName', {['@productName'] = productName,['@amount'] = amount})
end

local function fetchAllProducts()
    return MySQL.Sync.fetchAll("SELECT * FROM foundry_items")
end

RegisterServerEvent('v-recyclescraps:server:convertElements',function( qteToConvert, objectInInventory, convertObjectInto ) 
    local Player = QBCore.Functions.GetPlayer(source)

    local quantityPerTranche = Config.FoundryConversion[objectInInventory].items[convertObjectInto].qtyReceive
    local numberOfItemToGive = math.floor(qteToConvert / quantityPerTranche)
    local numberOfItemToTake = numberOfItemToGive * quantityPerTranche

    if not Player.Functions.RemoveItem(objectInInventory, numberOfItemToTake) then
        TriggerClientEvent('QBCore:Notify',source, Lang:t("error.notEnoughMaterialsOnYou")..QBCore.Shared.Items[objectInInventory]["label"], 'error')
        return
    end
    TriggerClientEvent('QBCore:Notify',source,Lang:t("success.successConvert"), 'success')

    Player.Functions.AddItem(convertObjectInto, numberOfItemToGive)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[convertObjectInto], "add")
end)

RegisterServerEvent('v-recyclescraps:server:BuyElements',function(item, amount) 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local money = Player.PlayerData.money[Config.TypeOfPayment]
    local priceToPay = Config.FoundryPrice[item].playerBuy * amount
    local product = FetchOneProduct(item)
    local amountToNumber = tonumber(amount)
    if product[1].stock <= amountToNumber then
        TriggerClientEvent('QBCore:Notify',src,Lang:t("error.notEnoughStock"), 'error')
    else
        if(money >= priceToPay) then
            TriggerClientEvent('QBCore:Notify',src,Lang:t("success.successBuy"), 'success')
            Player.Functions.AddItem(item, amountToNumber)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")

            local newStock = product[1].stock - amountToNumber
            UpdateProduct(item,newStock)

            if not Config.Account == '' then
                exports['qb-management']:AddMoney(Config.Account, priceToPay)
            end
           
            Player.Functions.RemoveMoney(Config.TypeOfPayment, priceToPay , Lang:t("menu.header"))
        else
            TriggerClientEvent('QBCore:Notify',src,Lang:t("error.notEnoughMoney"), 'error')
        end    
    end
end)

RegisterServerEvent('v-recyclescraps:server:SellElements',function(item, amount) 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local priceToPay = Config.FoundryPrice[item].playerSell * amount
    local amountToNumber = tonumber(amount)
    local product = FetchOneProduct(item)
    if not Player.Functions.RemoveItem(item, amountToNumber) then
        TriggerClientEvent('QBCore:Notify',src,Lang:t("error.notEnoughMaterialsOnYouFull"), 'error')
        return
    end
    TriggerClientEvent('QBCore:Notify',src,Lang:t("success.successSell"), 'success')
    Player.Functions.AddMoney(Config.TypeOfPayment, priceToPay , Lang:t("menu.header"))
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
    local newStock = product[1].stock + amountToNumber
    UpdateProduct(item,newStock)
end)

QBCore.Functions.CreateCallback('v-recyclescraps:server:listOfProducts', function(source,cb)
    local allProducts = fetchAllProducts()
    cb(allProducts)
end)