-- Survival mechanics core system

-- This function replaces the placeholder in the main file
function SurvivalRP:UpdateSurvivalStats(deltaTime)
    -- Initialize systems if needed (with safe checks)
    if not self.playerData.sleepData and self.InitializeSleepSystem then
        self:InitializeSleepSystem()
    end
    if not self.playerData.temperatureData and self.InitializeTemperatureData then
        self:InitializeTemperatureData()
    end
    
    local decayMultiplier = self:GetDecayMultiplier()
    local minuteDelta = deltaTime / 60
    
    -- Update hunger (don't decay while sleeping)
    if not self.playerData.isResting and not (self.playerData.sleepData and self.playerData.sleepData.isSleeping) then
        self.playerData.hunger = math.max(0, self.playerData.hunger - (self.config.hungerDecayRate * decayMultiplier * minuteDelta))
    end
    
    -- Update thirst (always decays, but slower while sleeping)
    local thirstMultiplier = (self.playerData.sleepData and self.playerData.sleepData.isSleeping) and 0.3 or 1.0
    self.playerData.thirst = math.max(0, self.playerData.thirst - (self.config.thirstDecayRate * decayMultiplier * thirstMultiplier * minuteDelta))
    
    -- Update fatigue
    if self.playerData.isResting then
        self.playerData.fatigue = math.min(100, self.playerData.fatigue + (self.config.restoreRate * deltaTime))
    elseif self.playerData.sleepData and self.playerData.sleepData.isSleeping then
        -- Fatigue is handled in sleep system with better restore rates
    else
        self.playerData.fatigue = math.max(0, self.playerData.fatigue - (self.config.fatigueDecayRate * decayMultiplier * minuteDelta))
    end
    
    -- Update temperature system (with safe check)
    if self.UpdateTemperature then
        self:UpdateTemperature(deltaTime)
    end
    
    -- Update sleep system (with safe check)
    if self.UpdateSleepSystem then
        self:UpdateSleepSystem(deltaTime)
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
    
    -- Temperature effects
    if self.temperatureMultiplier then
        multiplier = multiplier * self.temperatureMultiplier
    end
    
    -- Sleep debt effects
    if self.sleepDebtMultiplier then
        multiplier = multiplier * self.sleepDebtMultiplier
    end
    
    return multiplier
end

function SurvivalRP:GetWeatherMultiplier()
    -- Enhanced weather multiplier if weather system is loaded
    if self.playerData.weatherData and self.GetWeatherMultiplier then
        return self:GetWeatherMultiplier()
    end
    
    -- Fallback implementation
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
    -- Validate inputs
    if not itemType or (itemType ~= "food" and itemType ~= "drink") then
        self:ShowMessage("Invalid consumption type: " .. (itemType or "nil"), "WARNING")
        return
    end
    
    if not restoreAmount or type(restoreAmount) ~= "number" or restoreAmount <= 0 then
        self:ShowMessage("Invalid restore amount: " .. (restoreAmount or "nil"), "WARNING")
        restoreAmount = itemType == "food" and 8 or 6 -- Default fallback
    end
    
    -- Ensure player data exists
    if not self.playerData then
        self:ShowMessage("Player data not initialized", "WARNING")
        return
    end
    
    if itemType == "food" then
        local oldHunger = self.playerData.hunger or 0
        self.playerData.hunger = math.min(100, oldHunger + restoreAmount)
        local actualRestore = self.playerData.hunger - oldHunger
        
        if self.debugMode then
            self:DebugPrint("Hunger: " .. oldHunger .. " -> " .. self.playerData.hunger .. " (+" .. actualRestore .. ")")
        end
        
        self:ShowMessage("You feel less hungry.", "SYSTEM")
    elseif itemType == "drink" then
        local oldThirst = self.playerData.thirst or 0
        self.playerData.thirst = math.min(100, oldThirst + restoreAmount)
        local actualRestore = self.playerData.thirst - oldThirst
        
        if self.debugMode then
            self:DebugPrint("Thirst: " .. oldThirst .. " -> " .. self.playerData.thirst .. " (+" .. actualRestore .. ")")
        end
        
        self:ShowMessage("You feel refreshed.", "SYSTEM")
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

function SurvivalRP:DisplayLocalMessage(data)
    if self.config.chatMode == "EMOTE_ONLY" then
        return -- Don't display text in emote-only mode
    end
    
    local playerName = UnitName("player")
    local message = data.player .. " " .. data.message
    
    -- Display in appropriate channel
    if self.config.chatChannel == "SAY" then
        print("|cffcccccc[RP]|r " .. message)
    else
        print("|cff00ff88[SurvivalRP]|r " .. message)
    end
end

function SurvivalRP:DisplayAddonMessage(data)
    if self.config.chatMode == "EMOTE_ONLY" then
        return -- Don't display text in emote-only mode
    end
    
    local message = data.player .. " " .. data.message
    
    -- Display messages from other players
    if self.config.chatChannel == "SAY" then
        print("|cffcccccc[RP]|r " .. message)
    else
        print("|cff00ff88[SurvivalRP]|r " .. message)
    end
end