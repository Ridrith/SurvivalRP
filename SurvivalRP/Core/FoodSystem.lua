-- Food and drink detection system

SurvivalRP.foodDatabase = {
    -- Basic Food (3-9 restore)
    [117] = {type = "food", restore = 6, name = "Tough Jerky"},
    [414] = {type = "food", restore = 4, name = "Dalaran Sharp"},
    [422] = {type = "food", restore = 5, name = "Dwarven Mild"},
    [1487] = {type = "food", restore = 3, name = "Homemade Cherry Pie"},
    [2070] = {type = "food", restore = 7, name = "Darnassian Bleu"},
    [2287] = {type = "food", restore = 5, name = "Haunch of Meat"},
    [4536] = {type = "food", restore = 4, name = "Shiny Red Apple"},
    [4537] = {type = "food", restore = 4, name = "Tel'Abim Banana"},
    [4538] = {type = "food", restore = 5, name = "Snapvine Watermelon"},
    [4539] = {type = "food", restore = 4, name = "Goldenbark Apple"},
    [4540] = {type = "food", restore = 6, name = "Tough Hunk of Bread"},
    [4541] = {type = "food", restore = 8, name = "Freshly Baked Bread"},
    [4542] = {type = "food", restore = 7, name = "Moist Cornbread"},
    [4544] = {type = "food", restore = 6, name = "Mulgore Spice Bread"},
    [4601] = {type = "food", restore = 5, name = "Soft Banana Bread"},
    [4602] = {type = "food", restore = 6, name = "Moon Harvest Pumpkin"},
    [4604] = {type = "food", restore = 4, name = "Forest Mushroom Cap"},
    [4605] = {type = "food", restore = 5, name = "Red-Speckled Mushroom"},
    [4606] = {type = "food", restore = 6, name = "Spongy Morel"},
    [5066] = {type = "food", restore = 3, name = "Dried Fish"},
    [5095] = {type = "food", restore = 4, name = "Rainbow Fin Albacore"},
    [6290] = {type = "food", restore = 5, name = "Brilliant Smallfish"},
    [6299] = {type = "food", restore = 6, name = "Sickly Looking Fish"},
    [6887] = {type = "food", restore = 4, name = "Spotted Yellowtail"},
    [787] = {type = "food", restore = 3, name = "Slitherskin Mackerel"},
    [4592] = {type = "food", restore = 5, name = "Longjaw Mud Snapper"},
    [8957] = {type = "food", restore = 8, name = "Spinefin Halibut"},
    
    -- Better Food (10-15 restore)
    [8952] = {type = "food", restore = 12, name = "Roasted Quail"},
    [8932] = {type = "food", restore = 11, name = "Barbecued Buzzard Wing"},
    [3726] = {type = "food", restore = 10, name = "Big Bear Steak"},
    [3727] = {type = "food", restore = 11, name = "Hot Lion Chops"},
    [12209] = {type = "food", restore = 13, name = "Lean Wolf Steak"},
    [12210] = {type = "food", restore = 14, name = "Roast Raptor"},
    [13851] = {type = "food", restore = 12, name = "Hot Wolf Ribs"},
    [20074] = {type = "food", restore = 15, name = "Heavy Crocolisk Stew"},
    [17222] = {type = "food", restore = 13, name = "Spider Sausage"},
    [18045] = {type = "food", restore = 14, name = "Tender Wolf Steak"},
    [27635] = {type = "food", restore = 15, name = "Lynx Steak"},
    [27636] = {type = "food", restore = 14, name = "Bat Bites"},
    [33048] = {type = "food", restore = 13, name = "Stewed Trout"},
    [34062] = {type = "food", restore = 12, name = "Conjured Mountain Spring Water"},
    
    -- Basic Drinks (3-9 restore)
    [159] = {type = "drink", restore = 5, name = "Refreshing Spring Water"},
    [1179] = {type = "drink", restore = 6, name = "Ice Cold Milk"},
    [1205] = {type = "drink", restore = 4, name = "Melon Juice"},
    [1708] = {type = "drink", restore = 5, name = "Sweet Nectar"},
    [1645] = {type = "drink", restore = 7, name = "Moonberry Juice"},
    [4791] = {type = "drink", restore = 3, name = "Enchanted Water"},
    [5350] = {type = "drink", restore = 6, name = "Conjured Water"},
    [8077] = {type = "drink", restore = 7, name = "Conjured Sparkling Water"},
    [8078] = {type = "drink", restore = 8, name = "Conjured Crystal Water"},
    [1401] = {type = "drink", restore = 4, name = "Green Tea Leaf"},
    [2136] = {type = "drink", restore = 5, name = "Swiftthistle Tea"},
    [18300] = {type = "drink", restore = 6, name = "Hyjal Nectar"},
    [28399] = {type = "drink", restore = 8, name = "Filtered Draenei Water"},
    [33042] = {type = "drink", restore = 9, name = "Black Coffee"},
    
    -- Better Drinks (10-15 restore)
    [8766] = {type = "drink", restore = 12, name = "Morning Glory Dew"},
    [8079] = {type = "drink", restore = 10, name = "Conjured Mineral Water"},
    [28501] = {type = "drink", restore = 14, name = "Ravencrest's Legacy"},
    [29454] = {type = "drink", restore = 11, name = "Silvermoon City Special Reserve"},
    [32453] = {type = "drink", restore = 15, name = "Star's Lament"},
    [33444] = {type = "drink", restore = 12, name = "Pungent Seal Whey"},
    [33445] = {type = "drink", restore = 13, name = "Honeymint Tea"},
    [35954] = {type = "drink", restore = 14, name = "Sweetened Goat's Milk"},
    
    -- Alcoholic beverages (3-15 restore)
    [1177] = {type = "drink", restore = 4, name = "Oil of Olaf", special = "alcohol"},
    [1942] = {type = "drink", restore = 4, name = "Bottle of Moonshine", special = "alcohol"},
    [2593] = {type = "drink", restore = 6, name = "Flask of Port", special = "alcohol"},
    [2594] = {type = "drink", restore = 7, name = "Flagon of Mead", special = "alcohol"},
    [2595] = {type = "drink", restore = 5, name = "Jug of Badlands Bourbon", special = "alcohol"},
    [2596] = {type = "drink", restore = 8, name = "Skin of Dwarven Stout", special = "alcohol"},
    [3703] = {type = "drink", restore = 6, name = "Southshore Stout", special = "alcohol"},
    [4595] = {type = "drink", restore = 4, name = "Junglevine Wine", special = "alcohol"},
    [8928] = {type = "drink", restore = 9, name = "Dried King Bolete", special = "alcohol"},
    [18269] = {type = "drink", restore = 10, name = "Gordok Green Grog", special = "alcohol"},
    [18284] = {type = "drink", restore = 8, name = "Kreeg's Stout Beatdown", special = "alcohol"},
    [20031] = {type = "drink", restore = 7, name = "Essence Mango", special = "alcohol"},
    [21151] = {type = "drink", restore = 11, name = "Rumsey Rum Black Label", special = "alcohol"},
    [23246] = {type = "drink", restore = 12, name = "Fiery Festival Brew", special = "alcohol"},
    [23585] = {type = "drink", restore = 9, name = "Stormstout", special = "alcohol"},
    [32668] = {type = "drink", restore = 13, name = "Dos Ogris", special = "alcohol"},
    [32722] = {type = "drink", restore = 14, name = "Ichor of Undeath", special = "alcohol"},
    [34832] = {type = "drink", restore = 15, name = "Captain Rumsey's Lager", special = "alcohol"},
    
    -- Rare/Special Food (16-25 restore)
    [5349] = {type = "food", restore = 18, name = "Conjured Muffin"},
    [19696] = {type = "food", restore = 22, name = "Harvest Bread"},
    [20516] = {type = "food", restore = 20, name = "Bobbing Apple"},
    [21023] = {type = "food", restore = 19, name = "Dirge's Kickin' Chimaerok Chops"},
    [21217] = {type = "food", restore = 25, name = "Sagefish Delight"},
    [21552] = {type = "food", restore = 17, name = "Striped Yellowtail"},
    [22019] = {type = "food", restore = 21, name = "Conjured Croissant"},
    [22895] = {type = "food", restore = 23, name = "Conjured Cinnamon Roll"},
    [28486] = {type = "food", restore = 24, name = "Moser's Magnificent Muffin"},
    [29448] = {type = "food", restore = 16, name = "Mag'har Grainbread"},
    [29449] = {type = "food", restore = 18, name = "Bladespire Bagel"},
    [29450] = {type = "food", restore = 20, name = "Telaari Grapes"},
    [29451] = {type = "food", restore = 22, name = "Clefthoof Jerky"},
    [33872] = {type = "food", restore = 25, name = "Spicy Hot Talbuk"},
    [35563] = {type = "food", restore = 24, name = "Charred Bear Kabobs"},
    [35565] = {type = "food", restore = 23, name = "Juicy Bear Burger"},
    [38427] = {type = "food", restore = 21, name = "Pickled Egg"},
    [38428] = {type = "food", restore = 19, name = "Rock-Salted Pretzel"},
    
    -- Rare/Special Drinks (16-25 restore)
    [19299] = {type = "drink", restore = 18, name = "Fizzy Faire Drink"},
    [19300] = {type = "drink", restore = 17, name = "Bottled Winterspring Water"},
    [23161] = {type = "drink", restore = 20, name = "Refreshing Red Apple"},
    [28112] = {type = "drink", restore = 22, name = "Underspore Pod"},
    [29395] = {type = "drink", restore = 19, name = "Etherlium Essence"},
    [32455] = {type = "drink", restore = 24, name = "Star's Tears"},
    [33093] = {type = "drink", restore = 21, name = "Mana Berries"},
    [33096] = {type = "drink", restore = 23, name = "Fizzy Faire Drink 'Classic'"},
    [38429] = {type = "drink", restore = 25, name = "Blackrock Spring Water"},
    [38430] = {type = "drink", restore = 20, name = "Blackrock Mineral Water"},
    
    -- Holiday/Event Items
    [21213] = {type = "food", restore = 15, name = "Gingerbread Cookie"},
    [21215] = {type = "food", restore = 12, name = "Graccu's Mince Meat Fruitcake"},
    [21254] = {type = "drink", restore = 10, name = "Winter Veil Egg Nog"},
    [34068] = {type = "food", restore = 8, name = "Weighted Jack-o'-Lantern"},
    [37604] = {type = "food", restore = 16, name = "Tooth Pick"},
    
    -- Potions that could be considered drinks
    [929] = {type = "drink", restore = 12, name = "Healing Potion"},
    [1710] = {type = "drink", restore = 15, name = "Greater Healing Potion"},
    [3928] = {type = "drink", restore = 18, name = "Superior Healing Potion"},
    [13446] = {type = "drink", restore = 21, name = "Major Healing Potion"},
    [22829] = {type = "drink", restore = 24, name = "Super Healing Potion"}
}

-- Comprehensive spell IDs for eating and drinking across WoW versions
SurvivalRP.consumableSpells = {
    -- Classic/Basic eating spells
    eating = {
        430, 433, 5004, 5005, 5006, 5007, -- Basic food spells
        24005, 24869, 25660, 25661, 25693, 25894, -- Conjured food spells
        433, 1133, 1137, 2639, 18124, 18141, -- More food spells
        29073, 35270, 35271, 35272, 35273, 35274, -- Burning Crusade food
        42207, 42308, 42309, 42310, 42311, 42312, -- Wrath food spells
        61827, 61828, 61829, 61830, 61831, -- Cataclysm food
        104961, 104962, 104963, 104964, 104965, -- MoP food
        174461, 174462, 174463, 174464, 174465, -- WoD food
        201336, 201337, 201338, 201339, 201340, -- Legion food
        257406, 257407, 257408, 257409, 257410, -- BFA food
        308433, 308434, 308435, 308436, 308437 -- Shadowlands food
    },
    -- Classic/Basic drinking spells
    drinking = {
        430, 432, 1131, 1135, 5004, 5005, -- Basic drink spells
        24355, 25693, 25894, 25895, 26654, -- Conjured water spells
        432, 1131, 1135, 18233, 18234, 24355, -- More drink spells
        34291, 34292, 34293, 34294, 34295, -- Burning Crusade drinks
        43182, 43183, 43706, 46755, 57073, -- Wrath drink spells
        92799, 92800, 92803, 92805, 105230, -- Cataclysm drinks
        167152, 167153, 167154, 167155, 167156, -- WoD drinks
        201430, 201431, 201432, 201433, 201434, -- Legion drinks
        259409, 259410, 259411, 259412, 259413, -- BFA drinks
        308434, 308435, 308436, 308437, 308438 -- Shadowlands drinks
    }
}

-- Spell names for fallback detection (case-insensitive)
SurvivalRP.consumableSpellNames = {
    eating = {
        "food", "eat", "feast", "meal", "bread", "fish", "meat", "conjured.*food",
        "refreshment", "muffin", "cookie", "cake", "cheese", "apple", "banana"
    },
    drinking = {
        "drink", "water", "juice", "milk", "wine", "ale", "beer", "conjured.*water",
        "potion", "elixir", "tea", "coffee", "nectar", "mead"
    }
}

-- Debug mode configuration
SurvivalRP.debugMode = false

-- Current consumption tracking
SurvivalRP.currentConsumption = {
    itemId = nil,
    itemType = nil,
    startTime = nil,
    spellId = nil,
    lastConsumptionTime = 0,
    consumptionCooldown = 2 -- seconds between consumptions
}

-- WoW API compatibility functions
local function GetBagItemInfo(bag, slot)
    -- Handle different WoW versions
    if GetContainerItemInfo then
        return GetContainerItemInfo(bag, slot)
    elseif C_Container and C_Container.GetContainerItemInfo then
        local info = C_Container.GetContainerItemInfo(bag, slot)
        return info and info.stackCount, info.hasNoValue, info.itemLink, info.quality, info.hasLoot, info.hyperlink
    end
    return nil
end

local function GetBagItemLink(bag, slot)
    if GetContainerItemLink then
        return GetContainerItemLink(bag, slot)
    elseif C_Container and C_Container.GetContainerItemLink then
        return C_Container.GetContainerItemLink(bag, slot)
    end
    return nil
end

local function GetBagNumSlots(bag)
    if GetContainerNumSlots then
        return GetContainerNumSlots(bag)
    elseif C_Container and C_Container.GetContainerNumSlots then
        return C_Container.GetContainerNumSlots(bag)
    end
    return 0
end

-- This function replaces the placeholder in the main file
function SurvivalRP:CheckForConsumables()
    -- Scan bags for consumable items to build current inventory
    local consumables = {food = {}, drink = {}}
    
    for bag = 0, 4 do
        local slots = GetBagNumSlots(bag)
        if slots and slots > 0 then
            for slot = 1, slots do
                local itemLink = GetBagItemLink(bag, slot)
                if itemLink then
                    local itemId = GetItemInfoFromHyperlink(itemLink)
                    if itemId and self.foodDatabase[itemId] then
                        local itemData = self.foodDatabase[itemId]
                        local _, count = GetBagItemInfo(bag, slot)
                        if itemData.type == "food" then
                            consumables.food[itemId] = {count = count or 1, data = itemData}
                        elseif itemData.type == "drink" then
                            consumables.drink[itemId] = {count = count or 1, data = itemData}
                        end
                    end
                end
            end
        end
    end
    
    -- Store consumables for later reference
    self.playerConsumables = consumables
    
    if self.debugMode then
        local foodCount = 0
        local drinkCount = 0
        for _ in pairs(consumables.food) do foodCount = foodCount + 1 end
        for _ in pairs(consumables.drink) do drinkCount = drinkCount + 1 end
        self:DebugPrint("Bag scan found " .. foodCount .. " food types and " .. drinkCount .. " drink types")
    end
end

-- Enhanced spell detection function
function SurvivalRP:HandleSpellcast(spellId)
    -- Cooldown check to prevent spam
    local currentTime = GetTime()
    if currentTime - (self.currentConsumption.lastConsumptionTime or 0) < (self.currentConsumption.consumptionCooldown or 2) then
        if self.debugMode then
            self:DebugPrint("Consumption on cooldown, ignoring spell: " .. spellId)
        end
        return
    end
    
    -- Check if this is a known eating spell
    local isEating = false
    local isDrinking = false
    
    for _, eatSpellId in ipairs(self.consumableSpells.eating) do
        if spellId == eatSpellId then
            isEating = true
            break
        end
    end
    
    if not isEating then
        for _, drinkSpellId in ipairs(self.consumableSpells.drinking) do
            if spellId == drinkSpellId then
                isDrinking = true
                break
            end
        end
    end
    
    -- Fallback: try spell name detection
    if not isEating and not isDrinking then
        local spellName = GetSpellInfo(spellId)
        if spellName then
            local lowerName = string.lower(spellName)
            
            -- Check eating patterns
            for _, pattern in ipairs(self.consumableSpellNames.eating) do
                if string.find(lowerName, pattern) then
                    isEating = true
                    break
                end
            end
            
            -- Check drinking patterns if not eating
            if not isEating then
                for _, pattern in ipairs(self.consumableSpellNames.drinking) do
                    if string.find(lowerName, pattern) then
                        isDrinking = true
                        break
                    end
                end
            end
        end
    end
    
    -- Track consumption start
    if isEating or isDrinking then
        self.currentConsumption.spellId = spellId
        self.currentConsumption.itemType = isEating and "food" or "drink"
        self.currentConsumption.startTime = currentTime
        self.currentConsumption.lastConsumptionTime = currentTime
        
        if self.debugMode then
            local spellName = GetSpellInfo(spellId) or "Unknown"
            self:DebugPrint("Detected " .. self.currentConsumption.itemType .. " consumption: " .. spellName .. " (ID: " .. spellId .. ")")
        end
        
        -- Handle the consumption
        if isEating then
            self:HandleEating()
        elseif isDrinking then
            self:HandleDrinking()
        end
    end
end

function SurvivalRP:HandleEating()
    -- Find what food item the player is consuming
    local itemId = self:GetCurrentConsumableItem("food")
    
    if self.debugMode then
        self:DebugPrint("HandleEating called, detected item ID: " .. (itemId or "nil"))
    end
    
    if itemId and self.foodDatabase[itemId] then
        local foodData = self.foodDatabase[itemId]
        
        -- Validate the food data
        if not foodData.restore or foodData.restore <= 0 then
            if self.debugMode then
                self:DebugPrint("Warning: Invalid restore value for " .. (foodData.name or "Unknown") .. ": " .. (foodData.restore or "nil"))
            end
            foodData.restore = 8 -- Default fallback
        end
        
        self:HandleConsumption("food", foodData.restore)
        
        if self.debugMode then
            self:DebugPrint("Consumed " .. foodData.name .. " (restored " .. foodData.restore .. " hunger)")
        end
        
        if self.config.enableEmotes then
            local message = "eats " .. foodData.name .. " and feels nourished."
            if self.config.chatMode == "ADDON" then
                self:SendAddonMessage("EAT", message)
            elseif self.config.chatMode == "EMOTE_ONLY" then
                -- Just do the eating animation/sound, no text
            else
                self:SendEmote(message)
            end
        end
    else
        -- Generic food consumption
        local defaultRestore = 8
        self:HandleConsumption("food", defaultRestore)
        
        if self.debugMode then
            self:DebugPrint("Generic food consumption (restored " .. defaultRestore .. " hunger)")
        end
        
        if self.config.enableEmotes then
            local message = "eats some food and feels less hungry."
            if self.config.chatMode == "ADDON" then
                self:SendAddonMessage("EAT", message)
            elseif self.config.chatMode == "EMOTE_ONLY" then
                -- Just do the eating animation/sound, no text
            else
                self:SendEmote(message)
            end
        end
    end
    
    -- Clear consumption tracking
    self:ClearConsumptionTracking()
end

function SurvivalRP:HandleDrinking()
    -- Find what drink item the player is consuming
    local itemId = self:GetCurrentConsumableItem("drink")
    
    if self.debugMode then
        self:DebugPrint("HandleDrinking called, detected item ID: " .. (itemId or "nil"))
    end
    
    if itemId and self.foodDatabase[itemId] then
        local drinkData = self.foodDatabase[itemId]
        
        -- Validate the drink data
        if not drinkData.restore or drinkData.restore <= 0 then
            if self.debugMode then
                self:DebugPrint("Warning: Invalid restore value for " .. (drinkData.name or "Unknown") .. ": " .. (drinkData.restore or "nil"))
            end
            drinkData.restore = 6 -- Default fallback
        end
        
        self:HandleConsumption("drink", drinkData.restore)
        
        if self.debugMode then
            self:DebugPrint("Consumed " .. drinkData.name .. " (restored " .. drinkData.restore .. " thirst)")
        end
        
        if self.config.enableEmotes then
            local message = "drinks " .. drinkData.name .. " and feels refreshed."
            if self.config.chatMode == "ADDON" then
                self:SendAddonMessage("DRINK", message)
            elseif self.config.chatMode == "EMOTE_ONLY" then
                -- Just do the drinking animation/sound, no text
            else
                self:SendEmote(message)
            end
        end
    else
        -- Generic drink consumption
        local defaultRestore = 6
        self:HandleConsumption("drink", defaultRestore)
        
        if self.debugMode then
            self:DebugPrint("Generic drink consumption (restored " .. defaultRestore .. " thirst)")
        end
        
        if self.config.enableEmotes then
            local message = "drinks something and feels less thirsty."
            if self.config.chatMode == "ADDON" then
                self:SendAddonMessage("DRINK", message)
            elseif self.config.chatMode == "EMOTE_ONLY" then
                -- Just do the drinking animation/sound, no text
            else
                self:SendEmote(message)
            end
        end
    end
    
    -- Clear consumption tracking
    self:ClearConsumptionTracking()
end

-- Debug logging function
function SurvivalRP:DebugPrint(message)
    if self.debugMode then
        print("|cffffcc00[SurvivalRP Debug]|r " .. message)
    end
end

-- Clear consumption tracking
function SurvivalRP:ClearConsumptionTracking()
    self.currentConsumption.itemId = nil
    self.currentConsumption.itemType = nil
    self.currentConsumption.startTime = nil
    self.currentConsumption.spellId = nil
end

-- Validate food database entries
function SurvivalRP:ValidateFoodDatabase()
    local issues = {}
    local duplicates = {}
    local seenIds = {}
    
    for itemId, itemData in pairs(self.foodDatabase) do
        -- Check for duplicates
        if seenIds[itemId] then
            table.insert(duplicates, itemId)
        else
            seenIds[itemId] = true
        end
        
        -- Validate data structure
        if not itemData.type or (itemData.type ~= "food" and itemData.type ~= "drink") then
            table.insert(issues, "Item " .. itemId .. ": Invalid or missing type")
        end
        
        if not itemData.restore or type(itemData.restore) ~= "number" or itemData.restore <= 0 then
            table.insert(issues, "Item " .. itemId .. ": Invalid restore value")
        end
        
        if not itemData.name or type(itemData.name) ~= "string" or itemData.name == "" then
            table.insert(issues, "Item " .. itemId .. ": Invalid or missing name")
        end
    end
    
    if #duplicates > 0 then
        self:DebugPrint("Duplicate item IDs found: " .. table.concat(duplicates, ", "))
    end
    
    if #issues > 0 then
        self:DebugPrint("Database validation issues:")
        for _, issue in ipairs(issues) do
            self:DebugPrint("  " .. issue)
        end
    else
        self:DebugPrint("Food database validation passed")
    end
    
    return #issues == 0 and #duplicates == 0
end

function SurvivalRP:GetCurrentConsumableItem(type)
    -- Try to determine what item the player is currently consuming
    
    -- Method 1: Check cursor item (if player clicked to use an item)
    local cursorType, cursorId = GetCursorInfo()
    if cursorType == "item" and cursorId then
        local itemId = cursorId
        if self.foodDatabase[itemId] and self.foodDatabase[itemId].type == type then
            if self.debugMode then
                self:DebugPrint("Found cursor item: " .. (self.foodDatabase[itemId].name or "Unknown") .. " (ID: " .. itemId .. ")")
            end
            return itemId
        end
    end
    
    -- Method 2: Check recently used items in bags (look for items that decreased in count)
    if self.playerConsumables then
        local currentConsumables = type == "food" and self.playerConsumables.food or self.playerConsumables.drink
        
        for bag = 0, 4 do
            local slots = GetBagNumSlots(bag)
            if slots and slots > 0 then
                for slot = 1, slots do
                    local itemLink = GetBagItemLink(bag, slot)
                    if itemLink then
                        local itemId = GetItemInfoFromHyperlink(itemLink)
                        if itemId and self.foodDatabase[itemId] and self.foodDatabase[itemId].type == type then
                            local _, currentCount = GetBagItemInfo(bag, slot)
                            local storedCount = currentConsumables[itemId] and currentConsumables[itemId].count or 0
                            
                            -- If count decreased, this might be what we're consuming
                            if currentCount and currentCount < storedCount then
                                if self.debugMode then
                                    self:DebugPrint("Detected consumption via count decrease: " .. (self.foodDatabase[itemId].name or "Unknown") .. " (ID: " .. itemId .. ")")
                                end
                                return itemId
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- Method 3: Use spell context if available
    if self.currentConsumption.spellId then
        local spellName = GetSpellInfo(self.currentConsumption.spellId)
        if spellName then
            local lowerName = string.lower(spellName)
            
            -- Try to match spell name to items in database
            for itemId, itemData in pairs(self.foodDatabase) do
                if itemData.type == type then
                    local lowerItemName = string.lower(itemData.name)
                    -- Check if spell name contains item name or vice versa
                    if string.find(lowerName, lowerItemName) or string.find(lowerItemName, lowerName) then
                        if self.debugMode then
                            self:DebugPrint("Matched via spell name: " .. itemData.name .. " (ID: " .. itemId .. ")")
                        end
                        return itemId
                    end
                end
            end
        end
    end
    
    -- Method 4: Heuristic based on typical items in bags
    if self.playerConsumables then
        local availableItems = type == "food" and self.playerConsumables.food or self.playerConsumables.drink
        local bestGuess = nil
        local highestRestore = 0
        
        -- Prefer items with moderate restoration values (more likely to be consumed)
        for itemId, itemInfo in pairs(availableItems) do
            local restore = itemInfo.data.restore
            if restore >= 5 and restore <= 15 and restore > highestRestore then
                highestRestore = restore
                bestGuess = itemId
            end
        end
        
        if bestGuess then
            if self.debugMode then
                self:DebugPrint("Best guess based on restoration value: " .. (self.foodDatabase[bestGuess].name or "Unknown") .. " (ID: " .. bestGuess .. ")")
            end
            return bestGuess
        end
    end
    
    if self.debugMode then
        self:DebugPrint("Could not determine specific " .. type .. " item being consumed")
    end
    
    return nil
end