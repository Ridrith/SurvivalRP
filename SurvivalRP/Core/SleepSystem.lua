-- Sleep System Module
-- Handles sleep mechanics, sleep debt, and sleep quality

-- Initialize sleep-related data
function SurvivalRP:InitializeSleepSystem()
    if not self.playerData.sleepData then
        self.playerData.sleepData = {
            sleepDebt = 0,          -- Hours of sleep debt (0-24)
            lastSleepTime = GetTime(),
            isSleeping = false,
            sleepLocation = nil,    -- "bed", "tent", "ground", etc.
            sleepQuality = 1.0,     -- Multiplier for sleep effectiveness (0.5-2.0)
            timeSlept = 0,          -- Current sleep session duration
            totalSleepTime = 0,     -- Total time slept today
            dreamState = nil,       -- For future dream/nightmare system
            sleepStartTime = 0,     -- When current sleep session started
            wakeReason = nil        -- Why the player woke up
        }
    end
end

-- Main sleep update function (called from main update loop)
function SurvivalRP:UpdateSleepSystem(deltaTime)
    if not self.playerData.sleepData then
        self:InitializeSleepSystem()
    end
    
    local sleepData = self.playerData.sleepData
    
    if sleepData.isSleeping then
        self:ProcessSleeping(deltaTime)
    else
        -- Accumulate sleep debt while awake
        -- Normal rate: 1 hour of debt per 24 hours awake
        -- Accelerated for gameplay: 1 hour debt per 2 real hours
        local debtRate = 0.5 -- hours of debt per real hour
        sleepData.sleepDebt = math.min(24, sleepData.sleepDebt + (debtRate * (deltaTime / 3600)))
        
        -- Apply sleep debt effects
        self:ApplySleepDebtEffects()
    end
end

function SurvivalRP:ProcessSleeping(deltaTime)
    local sleepData = self.playerData.sleepData
    sleepData.timeSlept = sleepData.timeSlept + deltaTime
    sleepData.totalSleepTime = sleepData.totalSleepTime + deltaTime
    
    -- Calculate sleep effectiveness based on quality and location
    local sleepEffectiveness = sleepData.sleepQuality
    
    -- Restore fatigue faster when sleeping
    local sleepRestoreRate = self.config.restoreRate * 3 * sleepEffectiveness
    self.playerData.fatigue = math.min(100, self.playerData.fatigue + (sleepRestoreRate * deltaTime))
    
    -- Reduce sleep debt
    local debtReduction = sleepEffectiveness * (deltaTime / 3600) -- 1 hour of good sleep = 1 hour debt reduction
    sleepData.sleepDebt = math.max(0, sleepData.sleepDebt - debtReduction)
    
    -- Check for sleep interruptions
    self:CheckSleepInterruptions()
    
    -- Show occasional sleep messages
    if math.random(1, 1000) <= 1 and sleepData.timeSlept > 60 then -- Very rare
        self:ShowSleepDream()
    end
end

function SurvivalRP:StartSleeping(location)
    if not self.playerData.sleepData then
        self:InitializeSleepSystem()
    end
    
    local sleepData = self.playerData.sleepData
    
    if sleepData.isSleeping then
        self:ShowMessage("You are already sleeping.", "WARNING")
        return
    end
    
    -- Check if player can sleep
    if UnitAffectingCombat("player") then
        self:ShowMessage("You cannot sleep while in combat!", "WARNING")
        return
    end
    
    -- Determine sleep location and quality
    location = location or self:DetectSleepLocation()
    sleepData.sleepLocation = location
    sleepData.sleepQuality = self:CalculateSleepQuality(location)
    sleepData.isSleeping = true
    sleepData.timeSlept = 0
    sleepData.sleepStartTime = GetTime()
    sleepData.wakeReason = nil
    
    -- Physical emote
    DoEmote("sleep")
    
    -- Send appropriate message
    local locationText = self:GetSleepLocationText(location)
    local message = "lies down " .. locationText .. " and begins to sleep."
    
    if self.config.enableEmotes then
        if self.config.chatMode == "ADDON" then
            self:SendAddonMessage("SLEEP_START", message)
        elseif self.config.chatMode == "EMOTE_ONLY" then
            -- Just do the physical emote
        else
            self:SendEmote(message)
        end
    end
    
    -- Show sleep quality feedback
    local qualityText = self:GetSleepQualityText(sleepData.sleepQuality)
    self:ShowMessage("Sleep quality: " .. qualityText .. " (" .. math.floor(sleepData.sleepQuality * 100) .. "%)", "SYSTEM")
    
    -- Temperature helps determine if sleep will be restful
    local tempStatus = self:GetTemperatureStatus()
    if tempStatus == "Comfortable" then
        self:ShowMessage("The temperature is perfect for sleeping.", "SYSTEM")
    elseif tempStatus == "Cold" or tempStatus == "Very Cold" then
        self:ShowMessage("It's quite cold for sleeping. You might want to find warmth.", "WARNING")
    elseif tempStatus == "Hot" or tempStatus == "Very Hot" then
        self:ShowMessage("It's rather warm for comfortable sleep.", "WARNING")
    end
end

function SurvivalRP:StopSleeping(reason)
    if not self.playerData.sleepData then
        return
    end
    
    local sleepData = self.playerData.sleepData
    
    if not sleepData.isSleeping then
        return
    end
    
    sleepData.isSleeping = false
    sleepData.wakeReason = reason
    local sleepDuration = sleepData.timeSlept
    
    -- Send wake up message
    local wakeMessage = self:GetWakeUpMessage(reason, sleepDuration)
    
    if self.config.enableEmotes then
        if self.config.chatMode == "ADDON" then
            self:SendAddonMessage("SLEEP_STOP", wakeMessage)
        elseif self.config.chatMode == "EMOTE_ONLY" then
            -- Just stand up
        else
            self:SendEmote(wakeMessage)
        end
    end
    
    -- Show sleep summary
    self:ShowSleepSummary(sleepDuration)
end

function SurvivalRP:DetectSleepLocation()
    -- Check if player is in an inn
    if IsResting() then
        return "inn"
    end
    
    -- Check for active tent/shelter
    if self:HasActiveShelter() then
        return "tent"
    end
    
    -- Check current zone for safe sleeping areas
    local zone = GetZoneText()
    local safeCities = {
        ["Stormwind City"] = "city",
        ["Orgrimmar"] = "city",
        ["Ironforge"] = "city",
        ["Thunder Bluff"] = "city",
        ["Undercity"] = "city",
        ["Darnassus"] = "city",
        ["Shattrath City"] = "city",
        ["Dalaran"] = "city"
    }
    
    if safeCities[zone] then
        return "city"
    end
    
    -- Check if indoors
    if IsIndoors() then
        return "shelter"
    end
    
    -- Default to ground sleeping
    return "ground"
end

function SurvivalRP:CalculateSleepQuality(location)
    local baseQuality = {
        ["inn"] = 1.8,
        ["city"] = 1.5,
        ["tent"] = 1.3,
        ["shelter"] = 1.0,
        ["ground"] = 0.6
    }
    
    local quality = baseQuality[location] or 0.6
    
    -- Modify based on temperature
    local temp = self.playerData.temperature or 70
    if temp < 20 or temp > 99 then
        quality = quality * 0.5 -- Very poor sleep in extreme temperatures
    elseif temp < 40 or temp > 90 then
        quality = quality * 0.7 -- Poor sleep in uncomfortable temperatures
    elseif temp >= 60 and temp <= 78 then
        quality = quality * 1.2 -- Great sleep in comfortable temperatures
    end
    
    -- Modify based on current fatigue
    if self.playerData.fatigue < 20 then
        quality = quality * 1.3 -- Sleep better when very tired
    elseif self.playerData.fatigue > 80 then
        quality = quality * 0.8 -- Harder to sleep when not tired
    end
    
    -- Modify based on current sleep debt
    if self.playerData.sleepData.sleepDebt > 12 then
        quality = quality * 1.2 -- Sleep better when very sleep deprived
    end
    
    return math.max(0.3, math.min(2.0, quality))
end

function SurvivalRP:ApplySleepDebtEffects()
    local sleepDebt = self.playerData.sleepData.sleepDebt
    
    -- No effects if sleep debt is low
    if sleepDebt < 2 then
        self.sleepDebtMultiplier = 1.0
        return
    end
    
    -- Calculate penalty multiplier based on sleep debt
    local penaltyMultiplier = 1 + (sleepDebt * 0.08) -- 8% penalty per hour of debt
    
    -- Apply penalties to decay rates (make hunger/thirst/fatigue decay faster)
    self.sleepDebtMultiplier = penaltyMultiplier
    
    -- Show warnings for severe sleep debt
    if sleepDebt >= 8 and math.random(1, 100) <= 1 then -- 1% chance per update
        self:ShowMessage("You feel exhausted from lack of sleep.", "WARNING")
    elseif sleepDebt >= 16 and math.random(1, 100) <= 2 then -- 2% chance per update
        self:ShowMessage("You're barely able to stay awake! You need to sleep soon.", "WARNING")
    elseif sleepDebt >= 20 and math.random(1, 100) <= 3 then -- 3% chance per update
        self:ShowMessage("You're dangerously sleep deprived! Find a place to rest immediately!", "WARNING")
    end
end

function SurvivalRP:GetSleepLocationText(location)
    local locationTexts = {
        ["inn"] = "in a comfortable inn bed",
        ["city"] = "in a safe city location",
        ["tent"] = "in their tent",
        ["shelter"] = "in a makeshift shelter",
        ["ground"] = "on the hard ground"
    }
    return locationTexts[location] or "somewhere"
end

function SurvivalRP:GetSleepQualityText(quality)
    if quality >= 1.6 then
        return "Excellent"
    elseif quality >= 1.3 then
        return "Good"
    elseif quality >= 1.0 then
        return "Fair"
    elseif quality >= 0.7 then
        return "Poor"
    else
        return "Terrible"
    end
end

function SurvivalRP:GetWakeUpMessage(reason, duration)
    local hours = math.floor(duration / 3600)
    local minutes = math.floor((duration % 3600) / 60)
    
    local timeText = ""
    if hours > 0 then
        timeText = hours .. " hour" .. (hours > 1 and "s" or "")
        if minutes > 0 then
            timeText = timeText .. " and " .. minutes .. " minute" .. (minutes > 1 and "s" or "")
        end
    else
        timeText = minutes .. " minute" .. (minutes > 1 and "s" or "")
    end
    
    local reasonTexts = {
        ["manual"] = "wakes up after sleeping for " .. timeText .. ".",
        ["combat"] = "is jolted awake by danger!",
        ["movement"] = "wakes up from movement.",
        ["damage"] = "wakes up from pain!",
        ["natural"] = "wakes up naturally after " .. timeText .. ".",
        ["interrupted"] = "is woken up by something."
    }
    
    return reasonTexts[reason] or reasonTexts["manual"]
end

function SurvivalRP:ShowSleepSummary(duration)
    local sleepData = self.playerData.sleepData
    local hours = duration / 3600
    local qualityText = self:GetSleepQualityText(sleepData.sleepQuality)
    
    self:ShowMessage(string.format("Sleep Summary: %.1f hours of %s sleep. Sleep debt: %.1f hours remaining", 
                                 hours, qualityText:lower(), sleepData.sleepDebt), "SYSTEM")
                                 
    -- Show how rested the player feels
    if sleepData.sleepDebt < 2 then
        self:ShowMessage("You feel well-rested and refreshed.", "SYSTEM")
    elseif sleepData.sleepDebt < 6 then
        self:ShowMessage("You feel fairly rested.", "SYSTEM")
    elseif sleepData.sleepDebt < 12 then
        self:ShowMessage("You still feel somewhat tired.", "WARNING")
    else
        self:ShowMessage("You still feel very tired and need more sleep.", "WARNING")
    end
end

function SurvivalRP:CheckSleepInterruptions()
    -- Check for combat
    if UnitAffectingCombat("player") then
        self:StopSleeping("combat")
        return
    end
    
    -- Random chance of nightmares or disturbances in unsafe areas
    if self.playerData.sleepData.sleepLocation == "ground" and math.random(1, 10000) <= 1 then
        self:StopSleeping("interrupted")
        self:ShowMessage("You were woken by strange sounds in the distance.", "WARNING")
        return
    end
end

function SurvivalRP:ShowSleepDream()
    local dreams = {
        "dreams of peaceful meadows and warm sunshine.",
        "has a vivid dream about flying over vast landscapes.",
        "dreams of a hearty meal shared with friends.",
        "experiences a peaceful dream about calm waters.",
        "dreams of home and familiar faces.",
        "has a strange dream about glowing crystals.",
        "dreams of exploring ancient ruins.",
        "experiences a dream filled with beautiful music."
    }
    
    local nightmares = {
        "tosses and turns from a troubling nightmare.",
        "mumbles anxiously in their sleep.",
        "appears to be having an unsettling dream.",
        "shifts restlessly, caught in a dark dream."
    }
    
    local messages = self.playerData.sleepData.sleepLocation == "ground" and nightmares or dreams
    local message = messages[math.random(#messages)]
    
    if self.config.enableEmotes then
        if self.config.chatMode == "ADDON" then
            self:SendAddonMessage("SLEEP_DREAM", message)
        elseif self.config.chatMode ~= "EMOTE_ONLY" then
            self:SendEmote(message)
        end
    end
end

-- Placeholder for tent/shelter system integration
function SurvivalRP:HasActiveShelter()
    -- This will check for active tents or shelters
    if self.playerData.temperatureData and self.playerData.temperatureData.activeTents then
        for tentId, tentData in pairs(self.playerData.temperatureData.activeTents) do
            if tentData.active then
                return true
            end
        end
    end
    return false
end

-- Command to start sleeping
function SurvivalRP:HandleSleepCommand(args)
    if not self.playerData.sleepData then
        self:InitializeSleepSystem()
    end
    
    if args == "stop" or args == "wake" then
        self:StopSleeping("manual")
    elseif args == "status" or args == "info" then
        local sleepData = self.playerData.sleepData
        self:ShowMessage(string.format("Sleep Status - Debt: %.1f hours | Currently sleeping: %s", 
                                     sleepData.sleepDebt, sleepData.isSleeping and "Yes" or "No"), "SYSTEM")
    else
        self:StartSleeping()
    end
end