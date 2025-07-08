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
    [22829] = {type = "drink", restore = 13, name = "Super Healing Potion"},
    [28501] = {type = "drink", restore = 14, name = "Ravencrest's Legacy"},
    [29454] = {type = "drink", restore = 11, name = "Silvermoon City Special Reserve"},
    [32453] = {type = "drink", restore = 15, name = "Star's Lament"},
    [33444] = {type = "drink", restore = 12, name = "Pungent Seal Whey"},
    [33445] = {type = "drink", restore = 13, name = "Honeymint Tea"},
    [35954] = {type = "drink", restore = 14, name = "Sweetened Goat's Milk"},
    
    -- Alcoholic beverages (3-15 restore)
    [159] = {type = "drink", restore = 3, name = "Mead Basted Caribou", special = "alcohol"},
    [1177] = {type = "drink", restore = 4, name = "Oil of Olaf", special = "alcohol"},
    [1179] = {type = "drink", restore = 5, name = "Ice Cold Milk", special = "alcohol"},
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

-- This function replaces the placeholder in the main file
function SurvivalRP:CheckForConsumables()
    -- This function is called when bag contents change
    -- We'll track item usage through spell casting instead
end

-- This function replaces the placeholder in the main file
function SurvivalRP:HandleSpellcast(spellId)
    -- Handle eating and drinking spells
    if spellId == 430 then -- Drink
        self:HandleDrinking()
    elseif spellId == 433 then -- Food
        self:HandleEating()
    end
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
    -- This is a simplified version - in a real implementation,
    -- you'd need to track what item the player is currently using
    return nil
end