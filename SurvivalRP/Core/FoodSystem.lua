-- Food and drink detection system

SurvivalRP.foodDatabase = {
    -- Bread
    [117] = {type = "food", restore = 15, name = "Tough Jerky"},
    [2070] = {type = "food", restore = 20, name = "Darnassian Bleu"},
    [4541] = {type = "food", restore = 25, name = "Freshly Baked Bread"},
    [8952] = {type = "food", restore = 30, name = "Roasted Quail"},
    
    -- Drinks
    [159] = {type = "drink", restore = 15, name = "Refreshing Spring Water"},
    [1179] = {type = "drink", restore = 20, name = "Ice Cold Milk"},
    [1645] = {type = "drink", restore = 25, name = "Moonberry Juice"},
    [8766] = {type = "drink", restore = 30, name = "Morning Glory Dew"},
    
    -- Alcoholic beverages
    [2593] = {type = "drink", restore = 10, name = "Flask of Port", special = "alcohol"},
    [2594] = {type = "drink", restore = 12, name = "Flagon of Mead", special = "alcohol"},
    
    -- Conjured items
    [5349] = {type = "food", restore = 20, name = "Conjured Muffin"},
    [8075] = {type = "drink", restore = 20, name = "Conjured Water"}
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
        self:HandleConsumption("food", 20)
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
        self:HandleConsumption("drink", 25)
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