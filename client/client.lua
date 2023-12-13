local QBCore = exports['qb-core']:GetCoreObject()

local function configureBlip()
  for k, v in pairs(Config.pedLocations) do
    if v.blip then
        if v.blipBackground then
            local blipR2 = AddBlipForCoord(v.coordinates.x, v.coordinates.y, v.coordinates.z)

            SetBlipColour(blipR2,v.blipBackgroundColour)
            SetBlipSprite(blipR2, 1)
            SetBlipScale(blipR2, v.blipBackgroundSize)
            SetBlipAsFriendly(blipR2, true)
            if v.proximityBlipOnly then
              SetBlipDisplay(blipR2, 9)         
            else
              SetBlipDisplay(blipR2, 6)
            end
            SetBlipAsShortRange(blipR2, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.bliplabel)
            EndTextCommandSetBlipName(blipR2)
        end
        local blipR = AddBlipForCoord(v.coordinates.x, v.coordinates.y, v.coordinates.z)
        SetBlipColour(blipR,v.blipColour)
        SetBlipSprite(blipR, v.blipSprite)
        SetBlipScale(blipR, v.blipSize)
        SetBlipAsFriendly(blipR, true)
        if v.proximityBlipOnly then
          SetBlipDisplay(blipR, 9)         
        else
          SetBlipDisplay(blipR, 6)
        end
        SetBlipAsShortRange(blipR, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.bliplabel)
        EndTextCommandSetBlipName(blipR)
    end
  end
end

-- Display pnj Blips
Citizen.CreateThread(function()
    configureBlip()
    while true do
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    local i = 0

    for k, v in pairs(Config.pedLocations) do  
        i += 1
        --Make the ped appear
        RequestModel(GetHashKey(v.npc))
        while not HasModelLoaded(GetHashKey(v.npc)) do
            Wait(1)
        end
        ped =  CreatePed(4, v.npc, v.coordinates[1], v.coordinates[2], v.coordinates[3], v.coordinates[4], false, true)
        SetEntityHeading(ped, v.coordinates[4])
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        if v.customScenario == true  then   
            TaskStartScenarioInPlace(ped, v.scenario, 0, true)
        else
            TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        end

        local options = {}

        --Insert the option to talk to the ped
        local option = {
            type = "client",
            event = "v-recyclescraps:client:showFoundryMenu",
            icon = "fas fa-recycle",
            label = Lang:t("ped.talkto"),
        }
        table.insert(options,option) 

        --Create the zone for talking to him
        exports["qb-target"]:AddBoxZone("foundery"..i, vector3(v.coordinates[1], v.coordinates[2], v.coordinates[3]), 1.2, 1.5, {
            name = "foundery"..i,
            heading = v.coordinates[4],
            debugPoly = Config.Debug,
            minZ = v.coordinates[3]-2,
            maxZ = v.coordinates[3]+2,
        }, {
            options = options,
        distance = 2.5
        })
    end
end)

RegisterNetEvent('v-recyclescraps:client:showFoundryMenu',function()
  local optionMenu = 
    {
        {
          header = Lang:t("menu.header"),
          isMenuHeader = true,  
        },
    }
    if Config.AllowConvertMenu then
        local convrtMenu =  {
            header = Lang:t("menu.recycleMaterials"),
            icon = 'fa-solid fa-cloud-meatball',
            txt = '',
            params = {
              event = 'v-recyclescraps:client:showListMenuToConvert',
            }
        }
        table.insert(optionMenu,convrtMenu)
    end

    if Config.AllowBuyingMenu then
        local buyingMenu =    
        {
            header = Lang:t("menu.buyMaterials"),
            icon = 'fa-solid fa-comments-dollar',
            txt ='',
            params = {
              event = 'v-recyclescraps:client:showListMenuToBuySell',
              args = {
                typeofEvent = 'Buy'
              }
            }
        }
        table.insert(optionMenu,buyingMenu)
    end
    if Config.AllowSellingMenu then
        local sellingMenu =  
        {
            header = Lang:t("menu.sellMaterials"),
            icon = 'fa-solid fa-comments-dollar',
            txt = '',
            params = {
              event = 'v-recyclescraps:client:showListMenuToBuySell',
            args = {
                typeofEvent = 'Sell'
              }
            }
        } 
        table.insert(optionMenu,sellingMenu)
    end
    local footerMenu = 
    {
        header = Lang:t("menu.goodBye"),
        icon = 'fa-solid fa-cancel',
        txt = '',
        params = {
            event = exports['qb-menu']:closeMenu(),
        }
    }
    table.insert(optionMenu,footerMenu)
    exports['qb-menu']:openMenu(optionMenu)
end)

RegisterNetEvent('v-recyclescraps:client:showListMenuToConvert',function()
    local optionMenuConvert = {
        {
          header = Lang:t("menu.recycleMaterials"),
          isMenuHeader = true,  
        },
    }

    for k, v in pairs(Config.FoundryConversion) do

        local listOfConvertibleItems = ''
        for subk, subv in pairs(v.items) do
            local itemLabel = QBCore.Shared.Items[subk]["label"]
            listOfConvertibleItems = listOfConvertibleItems..', '..itemLabel
        end

        --if there is no conversion
        if listOfConvertibleItems == '' then
            listOfConvertibleItems = Lang:t("menu.noConversion")
        end
       
        local optionConvert = {    
            
            header = QBCore.Shared.Items[k]["label"],
            icon = 'fa-solid fa-beacon',
            txt ="Conversion : "..listOfConvertibleItems,
            params = {        
                event = 'v-recyclescraps:client:showConvertMenu',
                args = {
                    itemToConvert = k,
                }
            }
            
        }
        table.insert(optionMenuConvert,optionConvert)
    end

    local footerMenuConvert = {
        
        header = Lang:t("menu.goBackward"),
        icon = 'fa-solid fa-backward',
        txt = '',
        params = {
            event = "v-recyclescraps:client:showFoundryMenu",
        }
        
    }

    table.insert(optionMenuConvert,footerMenuConvert)
    exports['qb-menu']:openMenu(optionMenuConvert)
end)

RegisterNetEvent('v-recyclescraps:client:showConvertMenu',function(data)
    local materialChoice = {}
     for k, v in pairs(Config.FoundryConversion[data.itemToConvert].items) do    
        local optMaterial = {value = k, text= QBCore.Shared.Items[k]["label"]..'(Minimum : '..v.qtyReceive..')',}
        table.insert(materialChoice,optMaterial)       
    end
    local dialogFoundry = exports['qb-input']:ShowInput({
        header = Lang:t("menu.convert")..QBCore.Shared.Items[data.itemToConvert]["label"],
        submitText = Lang:t("menu.submit"),
        inputs = {
            {
                text = Lang:t("menu.amountToConvert"),
                name = "amountMaterialforCreation", 
                type = "number",
                isRequired = true,
            },
            {
                text = Lang:t("menu.convertTo"),
                name = "materialConvertInto", 
                type = "radio",
                isRequired = true,
                options = materialChoice
            },
        },
    })


    if dialogFoundry ~= nil then
        local Player =  QBCore.Functions.GetPlayerData()
        local itemToTransformInto = Config.FoundryConversion[data.itemToConvert].items[dialogFoundry.materialConvertInto]
        local qteGiven = tonumber(dialogFoundry.amountMaterialforCreation)
        if qteGiven < tonumber(itemToTransformInto.qtyReceive) then
            QBCore.Functions.Notify(Lang:t("error.notEnoughMaterials"),'error') 
            return
        end
        TriggerServerEvent("v-recyclescraps:server:convertElements", qteGiven, data.itemToConvert, dialogFoundry.materialConvertInto)
    end
end)

RegisterNetEvent('v-recyclescraps:client:showListMenuToBuySell',function(data)
    local header = ''
    if data.typeofEvent == 'Buy' then
        header = Lang:t("menu.buyMaterials")
    else
        header = Lang:t("menu.sellMaterials")
    end

    local optionMenuSellBuy = {
        {
          header = header,
          isMenuHeader = true,  
        },
    }

    
    QBCore.Functions.TriggerCallback('v-recyclescraps:server:listOfProducts', function(resultStock)
        local orderedStock = {}
        for k, v in pairs(resultStock) do
            orderedStock[v.name] = v.stock
        end
        for k, v in pairs(Config.FoundryPrice) do
            local priceTexte =  v.foundry
            if data.typeofEvent == 'Buy' then
                priceTexte = v.playerBuy
            else
                priceTexte = v.playerSell
            end
            local optMenuToSellBuy = {     
                header = QBCore.Shared.Items[k]["label"],
                icon = 'fa-dollar-sign',
                txt = Lang:t("menu.price")..priceTexte..'$ // Stock : '..orderedStock[k],
                params = {        
                    event = 'v-recyclescraps:client:showQteMenu',
                    args = {
                        itm = k,
                        typeofEvent = data.typeofEvent
                    }
                }                
            }
            table.insert(optionMenuSellBuy,optMenuToSellBuy)
        end
        local footerMenuSellBuy = {           
            header = Lang:t("menu.goBackward"),
            icon = 'fa-solid fa-backward',
            txt = '',
            params = {
                event = "v-recyclescraps:client:showFoundryMenu",
            }       
        }
        table.insert(optionMenuSellBuy,footerMenuSellBuy)
        exports['qb-menu']:openMenu(optionMenuSellBuy)
    end) 
end)

RegisterNetEvent('v-recyclescraps:client:showQteMenu',function(data)
    local headerQteMenu = ''
    if data.typeofEvent == 'Buy' then
        headerQteMenu = Lang:t("menu.buyMaterials")
    else
        headerQteMenu = Lang:t("menu.sellMaterials")
    end
    local dialogBuySell = exports['qb-input']:ShowInput({

        header = headerQteMenu..QBCore.Shared.Items[data.itm]["label"],
        submitText = Lang:t("menu.submit"),
        inputs = {
            {
                text = Lang:t("menu.quantity"),
                name = "amountToBuySell", 
                type = "number",
                isRequired = true,
            },
        },
    })

    if dialogBuySell ~= nil then
        local Player =  QBCore.Functions.GetPlayerData()

        if data.typeofEvent == 'Buy' then
            TriggerServerEvent("v-recyclescraps:server:BuyElements", data.itm , dialogBuySell.amountToBuySell)
        else
            TriggerServerEvent("v-recyclescraps:server:SellElements", data.itm , dialogBuySell.amountToBuySell)
        end
       
    end
end)

RegisterNetEvent('v-recyclescraps:client:convertElements',function(qteToConvert, objectInInventory, convertObjectInto)

    QBCore.Functions.TriggerCallback('v-recyclescraps:server:convertElements', function(result,qteToConvert, objectInInventory, convertObjectInto)

    end,qteToConvert, objectInInventory, convertObjectInto)
end)