-- Survival mechanics core system

-- This function replaces the placeholder in the main file
function SurvivalRP:UpdateSurvivalStats(deltaTime)
    local decayMultiplier = self:GetDecayMultiplier()
    local minuteDelta = deltaTime / 60
    
    -- Update hunger
    if not self.playerData.isResting then
        self.playerData.hunger = math.max(0, self.playerData.hunger - (self.config.hungerDecayRate * decayMultiplier * minuteDelta))
    end
    
    -- Update thirst
    self.playerData.thirst = math.max(0, self.playerData.thirst - (self.config.thirstDecayRate * decayMultiplier * minuteDelta))
    
    -- Update fatigue
    if self.playerData.isResting then
        self.playerData.fatigue = math.min(100, self.playerData.fatigue + (self.config.restoreRate * deltaTime))
    else
        self.playerData.fatigue = math.max(0, self.playerData.fatigue - (self.config.fatigueDecayRate * decayMultiplier * minuteDelta))
    end
    
    -- Update temperature
    if self.UpdateTemperature then
        self:UpdateTemperature()
    end
end

function SurvivalRP:GetDecayMultiplier()
    local multiplier = 1.0
    
    -- Combat increases decay
    if UnitAffectingCombat("player") then
        multiplier = multiplier * 1.5
    end
    
    -- Weather effects
    if self.config.enableWeatherEffects then
        local weatherMultiplier = self:GetWeatherMultiplier()
        multiplier = multiplier * weatherMultiplier
    end
    
    -- Zone effects
    local zoneMultiplier = self:GetZoneMultiplier()
    multiplier = multiplier * zoneMultiplier
    
    return multiplier
end

function SurvivalRP:GetWeatherMultiplier()
    -- Note: GetWeatherType() might not be available in all WoW versions
    -- This is a fallback implementation
    return 1.0
end

function SurvivalRP:GetZoneMultiplier()
    local zone = GetZoneText()
    local desertZones = {
        ["Tanaris"] = 1.3,
        ["Uldum"] = 1.2,
        ["Durotar"] = 1.1
    }
    
    local coldZones = {
        ["Winterspring"] = 1.2,
        ["Icecrown"] = 1.3,
        ["Dragonblight"] = 1.1
    }
    
    return desertZones[zone] or coldZones[zone] or 1.0
end

function SurvivalRP:HandleConsumption(itemType, restoreAmount)
    if itemType == "food" then
        self.playerData.hunger = math.min(100, self.playerData.hunger + restoreAmount)
    elseif itemType == "drink" then
        self.playerData.thirst = math.min(100, self.playerData.thirst + restoreAmount)
    end
end

function SurvivalRP:StartResting()
    if not self.playerData.isResting then
        self.playerData.isResting = true
        DoEmote("sit")
        if self.config.enableEmotes then
            if self.config.chatMode == "ADDON" then
                self:SendAddonMessage("REST_START", "begins to rest, taking a moment to recover.")
            elseif self.config.chatMode == "EMOTE_ONLY" then
                -- Just do the physical /sit emote, no text
            else
                self:SendEmote("begins to rest, taking a moment to recover.")
            end
        end
    end
end

function SurvivalRP:StopResting()
    if self.playerData.isResting then
        self.playerData.isResting = false
        if self.config.enableEmotes then
            if self.config.chatMode == "ADDON" then
                self:SendAddonMessage("REST_STOP", "finishes resting and stands up, feeling refreshed.")
            elseif self.config.chatMode == "EMOTE_ONLY" then
                -- Just stand up, no text
            else
                self:SendEmote("finishes resting and stands up, feeling refreshed.")
            end
        end
    end
end

function SurvivalRP:SendEmote(message)
    local playerName = UnitName("player")
    local emoteText = playerName .. " " .. message
    
    if self.config.chatChannel == "PARTY" and GetNumGroupMembers() > 0 then
        SendChatMessage(emoteText, "PARTY")
    elseif self.config.chatChannel == "GUILD" and IsInGuild() then
        SendChatMessage(emoteText, "GUILD")
    elseif self.config.chatChannel == "SAY" then
        SendChatMessage(emoteText, "SAY")
    else
        SendChatMessage(emoteText, "EMOTE")
    end
end

-- New addon-specific communication system
function SurvivalRP:SendAddonMessage(messageType, message)
    local playerName = UnitName("player")
    local data = {
        type = messageType,
        player = playerName,
        message = message,
        timestamp = GetTime()
    }
    
    local serializedData = self:SerializeData(data)
    
    -- Send to party/raid first, then guild as fallback
    if GetNumGroupMembers() > 0 then
        C_ChatInfo.SendAddonMessage("SurvivalRP", serializedData, "PARTY")
    elseif IsInGuild() then
        C_ChatInfo.SendAddonMessage("SurvivalRP", serializedData, "GUILD")
    end
    
    -- Display locally immediately
    self:DisplayLocalMessage(data)
end

function SurvivalRP:SerializeData(data)
    -- Simple serialization - in a real addon you might want to use a library like LibSerialize
    local result = ""
    for key, value in pairs(data) do
        result = result .. key .. ":" .. tostring(value) .. ";"
    end
    return result
end

function SurvivalRP:DeserializeData(serializedData)
    local data = {}
    for pair in string.gmatch(serializedData, "([^;]+)") do
        local key, value = string.match(pair, "([^:]+):(.+)")
        if key and value then
            data[key] = value
        end
    end
    return data
end

-- This displays messages from OTHER players only (received via addon communication)
function SurvivalRP:DisplayAddonMessage(data)
    local coloredName = "|cff00ff00" .. data.player .. "|r"
    local message = "[SurvivalRP] " .. coloredName .. " " .. data.message
    
    -- Display in a separate chat frame or default chat
    if self.config.useSeperateChannel then
        -- You could create a separate chat tab for SurvivalRP messages
        print(message)
    else
        print(message)
    end
end

-- This displays the local player's own messages (called once immediately)
function SurvivalRP:DisplayLocalMessage(data)
    local coloredName = "|cff00ff00" .. data.player .. "|r"
    local message = "[SurvivalRP] " .. coloredName .. " " .. data.message
    
    -- Display in a separate chat frame or default chat
    if self.config.useSeperateChannel then
        -- You could create a separate chat tab for SurvivalRP messages
        print(message)
    else
        print(message)
    end
end

function SurvivalRP:ResetPlayerData()
    self.playerData = {
        hunger = 100,
        thirst = 100,
        fatigue = 100,
        temperature = 50,
        isResting = false,
        lastUpdate = GetTime(),
        sleepDebt = 0
    }
end