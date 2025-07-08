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
    [21552] = {type = "food", restore = 7, name = "Striped Yellowtail"},
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
    [8080] = {type = "drink", restore = 13, name = "Conjured Fresh Water"},
    [28501] = {type = "drink", restore = 14, name = "Ravencrest's Legacy"},
    [29454] = {type = "drink", restore = 11, name = "Silvermoon City Special Reserve"},
    [32453] = {type = "drink", restore = 15, name = "Star's Lament"},
    [33444] = {type = "drink", restore = 12, name = "Pungent Seal Whey"},
    [33445] = {type = "drink", restore = 13, name = "Honeymint Tea"},
    [35954] = {type = "drink", restore = 14, name = "Sweetened Goat's Milk"},
    
    -- Alcoholic beverages (3-15 restore)
    [2723] = {type = "drink", restore = 3, name = "Mead Basted Caribou", special = "alcohol"},
    [1177] = {type = "drink", restore = 4, name = "Oil of Olaf", special = "alcohol"},
    [2137] = {type = "drink", restore = 5, name = "Alcoholic Wine", special = "alcohol"},
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
    [8075] = {type = "drink", restore = 20, name = "Conjured Water"},
    [19696] = {type = "food", restore = 22, name = "Harvest Bread"},
    [20516] = {type = "food", restore = 20, name = "Bobbing Apple"},
    [21023] = {type = "food", restore = 19, name = "Dirge's Kickin' Chimaerok Chops"},
    [21217] = {type = "food", restore = 25, name = "Sagefish Delight"},
    [8959] = {type = "food", restore = 17, name = "Raw Rockscale Cod"},
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

-- Food and drink spell IDs for different WoW versions
SurvivalRP.consumableSpells = {
    -- Drinking spells
    drink = {
        430, 431, 432, 1133, 1135, 1137, 10250, 22734, 22731, 25696, 26891, 26898,
        27089, 29007, 34291, 61830, 92682, 92683, 92688, 92736, 105230, 167152
    },
    -- Food spells  
    food = {
        433, 434, 435, 1127, 1129, 1131, 10256, 22730, 25697, 26890, 26899,
        27090, 29008, 34290, 61827, 92681, 92679, 92687, 92681, 105271, 167153
    }
}

-- Track currently consumed items
SurvivalRP.currentConsumption = {
    lastItemUsed = nil,
    lastItemType = nil,
    consumptionTime = 0
}

-- Track consumables in bags
SurvivalRP.bagContents = {}

-- Debug logging
function SurvivalRP:DebugLog(message)
    if self.config.enableDebugLogging then
        print("|cff808080[SurvivalRP Debug]|r " .. message)
    end
end

-- This function replaces the placeholder in the main file
function SurvivalRP:CheckForConsumables()
    -- Scan bags for consumable items
    self.bagContents = {}
    
    for bag = 0, 4 do
        local numSlots = C_Container and C_Container.GetContainerNumSlots(bag) or GetContainerNumSlots(bag)
        if numSlots then
            for slot = 1, numSlots do
                local itemInfo = C_Container and C_Container.GetContainerItemInfo(bag, slot) or {}
                local itemID = itemInfo.itemID or select(10, GetContainerItemInfo(bag, slot))
                
                if itemID and self.foodDatabase[itemID] then
                    local stackCount = itemInfo.stackCount or select(2, GetContainerItemInfo(bag, slot)) or 1
                    self.bagContents[itemID] = (self.bagContents[itemID] or 0) + stackCount
                    self:DebugLog("Found consumable: " .. (self.foodDatabase[itemID].name or "Unknown") .. " (ID: " .. itemID .. ") x" .. stackCount)
                end
            end
        end
    end
end

-- This function replaces the placeholder in the main file
function SurvivalRP:HandleSpellcast(spellId)
    self:DebugLog("Spell cast detected: " .. (spellId or "nil"))
    
    -- Check if it's a drinking spell
    for _, drinkSpellId in ipairs(self.consumableSpells.drink) do
        if spellId == drinkSpellId then
            self:DebugLog("Drinking spell detected: " .. spellId)
            self:HandleDrinking()
            return
        end
    end
    
    -- Check if it's a food spell
    for _, foodSpellId in ipairs(self.consumableSpells.food) do
        if spellId == foodSpellId then
            self:DebugLog("Eating spell detected: " .. spellId)
            self:HandleEating()
            return
        end
    end
    
    -- Fallback: Try to detect by spell name if spell ID detection fails
    local spellName = GetSpellInfo(spellId)
    if spellName then
        self:DebugLog("Checking spell name: " .. spellName)
        if self:IsConsumableSpellByName(spellName) then
            local spellType = self:GetSpellTypeByName(spellName)
            if spellType == "drink" then
                self:DebugLog("Drinking detected by spell name: " .. spellName)
                self:HandleDrinking()
            elseif spellType == "food" then
                self:DebugLog("Eating detected by spell name: " .. spellName)
                self:HandleEating()
            end
        end
    end
end

-- Check if spell name indicates consumable use
function SurvivalRP:IsConsumableSpellByName(spellName)
    if not spellName then return false end
    
    local lowerName = string.lower(spellName)
    local consumableKeywords = {
        "drink", "drinking", "eat", "eating", "consume", "consuming",
        "food", "beverage", "meal", "snack", "refreshment"
    }
    
    for _, keyword in ipairs(consumableKeywords) do
        if string.find(lowerName, keyword) then
            return true
        end
    end
    
    return false
end

-- Determine spell type by name
function SurvivalRP:GetSpellTypeByName(spellName)
    if not spellName then return nil end
    
    local lowerName = string.lower(spellName)
    
    -- Check for drink keywords
    local drinkKeywords = {"drink", "drinking", "beverage", "water", "juice", "milk", "tea", "coffee"}
    for _, keyword in ipairs(drinkKeywords) do
        if string.find(lowerName, keyword) then
            return "drink"
        end
    end
    
    -- Check for food keywords
    local foodKeywords = {"eat", "eating", "food", "meal", "bread", "meat", "fish", "fruit"}
    for _, keyword in ipairs(foodKeywords) do
        if string.find(lowerName, keyword) then
            return "food"
        end
    end
    
    return "food" -- Default to food if consumable but type unclear
end

function SurvivalRP:HandleEating()
    -- Find what food item the player is consuming
    local itemId = self:GetCurrentConsumableItem("food")
    if itemId and self.foodDatabase[itemId] then
        local foodData = self.foodDatabase[itemId]
        self:HandleConsumption("food", foodData.restore)
        
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
        self:HandleConsumption("food", 8) -- Lowered from 20
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
end

function SurvivalRP:HandleDrinking()
    -- Find what drink item the player is consuming
    local itemId = self:GetCurrentConsumableItem("drink")
    if itemId and self.foodDatabase[itemId] then
        local drinkData = self.foodDatabase[itemId]
        self:HandleConsumption("drink", drinkData.restore)
        
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
        self:HandleConsumption("drink", 6) -- Lowered from 25
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
end

function SurvivalRP:GetCurrentConsumableItem(type)
    -- Try to detect the item being consumed based on recent bag changes and timing
    local currentTime = GetTime()
    
    -- If we recently detected consumption, use that data
    if self.currentConsumption.lastItemUsed and 
       self.currentConsumption.lastItemType == type and
       (currentTime - self.currentConsumption.consumptionTime) < 2 then
        return self.currentConsumption.lastItemUsed
    end
    
    -- Alternative approach: Look for the most likely consumable being used
    -- This is based on what consumables the player has and common usage patterns
    local bestMatch = nil
    local bestScore = 0
    
    for itemId, count in pairs(self.bagContents) do
        if count > 0 and self.foodDatabase[itemId] and self.foodDatabase[itemId].type == type then
            local itemData = self.foodDatabase[itemId]
            local score = 1
            
            -- Prefer items with moderate restore values (more likely to be used regularly)
            if itemData.restore >= 8 and itemData.restore <= 15 then
                score = score + 2
            elseif itemData.restore >= 5 and itemData.restore <= 20 then
                score = score + 1
            end
            
            -- Prefer conjured items (commonly used)
            if string.find(string.lower(itemData.name), "conjured") then
                score = score + 1
            end
            
            -- Prefer items with higher stack counts (more likely in active use)
            if count > 10 then
                score = score + 1
            elseif count > 5 then
                score = score + 0.5
            end
            
            if score > bestScore then
                bestScore = score
                bestMatch = itemId
            end
        end
    end
    
    if bestMatch then
        self:DebugLog("Best guess for consumed " .. type .. ": " .. (self.foodDatabase[bestMatch].name or "Unknown") .. " (ID: " .. bestMatch .. ")")
        
        -- Update consumption tracking
        self.currentConsumption.lastItemUsed = bestMatch
        self.currentConsumption.lastItemType = type
        self.currentConsumption.consumptionTime = currentTime
        
        return bestMatch
    end
    
    self:DebugLog("Could not identify consumed " .. type .. " item")
    return nil
end

-- Track item usage when bag contents change
function SurvivalRP:OnBagContentsChanged()
    local oldContents = {}
    for k, v in pairs(self.bagContents) do
        oldContents[k] = v
    end
    
    -- Refresh bag contents
    self:CheckForConsumables()
    
    -- Detect consumption by looking for decreased item counts
    for itemId, oldCount in pairs(oldContents) do
        local newCount = self.bagContents[itemId] or 0
        if newCount < oldCount and self.foodDatabase[itemId] then
            local itemData = self.foodDatabase[itemId]
            self:DebugLog("Detected consumption: " .. (itemData.name or "Unknown") .. " (ID: " .. itemId .. ") - Count changed from " .. oldCount .. " to " .. newCount)
            
            -- Track this as the most recently used item
            self.currentConsumption.lastItemUsed = itemId
            self.currentConsumption.lastItemType = itemData.type
            self.currentConsumption.consumptionTime = GetTime()
        end
    end
end