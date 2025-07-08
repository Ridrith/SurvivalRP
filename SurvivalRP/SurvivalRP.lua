-- SurvivalRP Core Addon
-- Main addon file

local addonName, SurvivalRP = ...
_G.SurvivalRP = SurvivalRP -- Make it globally accessible
SurvivalRP.version = "1.0.0"

-- Core variables
SurvivalRP.playerData = {
    hunger = 100,
    thirst = 100,
    fatigue = 100,
    temperature = 50,
    isResting = false,
    lastUpdate = GetTime(),
    sleepDebt = 0
}

SurvivalRP.config = {
    hungerDecayRate = 0.5, -- per minute
    thirstDecayRate = 0.7, -- per minute
    fatigueDecayRate = 0.3, -- per minute
    restoreRate = 2.0, -- per second when resting
    showVisualEffects = true,
    enableSounds = true,
    enableEmotes = true,
    chatChannel = "PARTY", -- PARTY, GUILD, SAY, EMOTE
    chatMode = "ADDON", -- ADDON, NORMAL, EMOTE_ONLY
    enableWeatherEffects = true,
    enableTemperature = true,
    useSeperateChannel = false,
    enableDebugLogging = false -- Add debug logging option
}

-- Initialize addon
function SurvivalRP:Initialize()
    self:LoadPlayerData()
    self:RegisterAddonComm()
    self:CreateUI()
    self:RegisterEvents()
    self:InitializeFoodSystem()
    self:StartUpdateTimer()
    print("|cff00ff00SurvivalRP|r v" .. self.version .. " loaded successfully!")
end

-- Initialize food system components
function SurvivalRP:InitializeFoodSystem()
    -- Initialize tracking variables
    if not self.bagContents then
        self.bagContents = {}
    end
    if not self.currentConsumption then
        self.currentConsumption = {
            lastItemUsed = nil,
            lastItemType = nil,
            consumptionTime = 0
        }
    end
    
    -- Perform initial bag scan
    self:CheckForConsumables()
    self:DebugLog("Food system initialized")
end

-- Register addon communication
function SurvivalRP:RegisterAddonComm()
    C_ChatInfo.RegisterAddonMessagePrefix("SurvivalRP")
    
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("CHAT_MSG_ADDON")
    frame:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
        if prefix == "SurvivalRP" then
            SurvivalRP:OnAddonMessage(message, channel, sender)
        end
    end)
end

-- Fixed addon message handling to prevent duplicates
function SurvivalRP:OnAddonMessage(message, channel, sender)
    local playerName = UnitName("player")
    local playerNameWithRealm = UnitName("player") .. "-" .. GetRealmName():gsub("%s+", "")
    
    -- Handle both cases: sender might be "Name" or "Name-Realm"
    local senderBase = sender:match("^([^-]+)") or sender -- Get name part before the dash
    
    -- Don't process our own messages to prevent duplicates
    if sender == playerName or sender == playerNameWithRealm or senderBase == playerName then
        return
    end
    
    local data = self:DeserializeData(message)
    if data and data.type and data.player and data.message then
        -- Only display messages from other players
        self:DisplayAddonMessage(data)
    end
end

-- Event handling
function SurvivalRP:RegisterEvents()
    local frame = CreateFrame("Frame", "SurvivalRPEventFrame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:RegisterEvent("PLAYER_LOGOUT")
    frame:RegisterEvent("BAG_UPDATE")
    frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    frame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Combat start
    frame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Combat end
    frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    
    frame:SetScript("OnEvent", function(self, event, ...)
        SurvivalRP:OnEvent(event, ...)
    end)
end

function SurvivalRP:OnEvent(event, ...)
    if event == "ADDON_LOADED" then
        local addonLoaded = ...
        if addonLoaded == addonName then
            -- Already initialized
        end
    elseif event == "PLAYER_LOGOUT" then
        self:SavePlayerData()
    elseif event == "BAG_UPDATE" then
        self:CheckForConsumables()
        -- Also track bag changes for consumption detection
        if self.OnBagContentsChanged then
            self:OnBagContentsChanged()
        end
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, _, spellId = ...
        if unit == "player" then
            self:HandleSpellcast(spellId)
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        self:OnCombatStart()
    elseif event == "PLAYER_REGEN_ENABLED" then
        self:OnCombatEnd()
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        self:UpdateEnvironmentalEffects()
    end
end

function SurvivalRP:OnCombatStart()
    -- Combat effects will be handled in UpdateSurvivalStats
end

function SurvivalRP:OnCombatEnd()
    -- Combat effects will be handled in UpdateSurvivalStats
end

function SurvivalRP:UpdateEnvironmentalEffects()
    -- This will be implemented in temperature system
end

function SurvivalRP:CheckForConsumables()
    -- Implementation provided by FoodSystem.lua
end

function SurvivalRP:HandleSpellcast(spellId)
    -- Implementation provided by FoodSystem.lua  
end

-- Main update loop
function SurvivalRP:StartUpdateTimer()
    self.updateTimer = C_Timer.NewTicker(1, function()
        self:Update()
    end)
end

function SurvivalRP:Update()
    local currentTime = GetTime()
    local deltaTime = currentTime - self.playerData.lastUpdate
    self.playerData.lastUpdate = currentTime
    
    -- Update survival stats
    self:UpdateSurvivalStats(deltaTime)
    
    -- Update UI
    if self.UpdateUI then
        self:UpdateUI()
    end
    
    -- Update visual effects
    if self.UpdateVisualEffects then
        self:UpdateVisualEffects()
    end
    
    -- Check for critical states
    if self.CheckCriticalStates then
        self:CheckCriticalStates()
    end
end

-- Placeholder functions that will be replaced by other files
function SurvivalRP:UpdateSurvivalStats(deltaTime)
    -- Will be implemented in SurvivalMechanics.lua
end

function SurvivalRP:CreateUI()
    -- Will be implemented in SurvivalUI.lua
end

function SurvivalRP:LoadPlayerData()
    -- Will be implemented in SaveData.lua
end

function SurvivalRP:SavePlayerData()
    -- Will be implemented in SaveData.lua
end

function SurvivalRP:ShowMessage(message, type)
    if type == "WARNING" then
        print("|cffff0000[SurvivalRP Warning]|r " .. message)
    elseif type == "SYSTEM" then
        print("|cff00ff00[SurvivalRP]|r " .. message)
    else
        print("|cffcccccc[SurvivalRP]|r " .. message)
    end
end

-- Debug logging function
function SurvivalRP:DebugLog(message)
    if self.config.enableDebugLogging then
        print("|cff808080[SurvivalRP Debug]|r " .. message)
    end
end

-- Function to open settings panel (compatible with new and old systems)
function SurvivalRP:OpenSettingsPanel()
    if Settings and Settings.OpenToCategory then
        -- New settings system (10.0+)
        if self.settingsCategory then
            Settings.OpenToCategory(self.settingsCategory)
        else
            -- Fallback: just show the panel directly
            if self.settingsPanel then
                self.settingsPanel:Show()
            end
        end
    elseif InterfaceOptionsFrame_OpenToCategory then
        -- Old settings system
        InterfaceOptionsFrame_OpenToCategory(self.settingsPanel)
    else
        -- Direct panel show as fallback
        if self.settingsPanel then
            self.settingsPanel:Show()
        else
            self:ShowMessage("Settings panel not available. Try /reload to reinitialize.", "WARNING")
        end
    end
end

-- Slash commands
SLASH_SURVIVALRP1 = "/survivalrp"
SLASH_SURVIVALRP2 = "/srp"
function SlashCmdList.SURVIVALRP(msg)
    local command = string.lower(msg or "")
    
    if command == "reset" then
        SurvivalRP:ResetPlayerData()
        SurvivalRP:ShowMessage("Survival stats reset!", "SYSTEM")
    elseif command == "config" then
        SurvivalRP:OpenSettingsPanel()
    elseif command == "toggle" then
        if SurvivalRP.ui and SurvivalRP.ui.mainFrame then
            if SurvivalRP.ui.mainFrame:IsShown() then
                SurvivalRP.ui.mainFrame:Hide()
                SurvivalRP:ShowMessage("UI hidden", "SYSTEM")
            else
                SurvivalRP.ui.mainFrame:Show()
                SurvivalRP:ShowMessage("UI shown", "SYSTEM")
            end
        end
    elseif command == "test" then
        SurvivalRP:TestVisualEffects()
    elseif command == "debug" then
        SurvivalRP.config.enableDebugLogging = not SurvivalRP.config.enableDebugLogging
        SurvivalRP:ShowMessage("Debug logging " .. (SurvivalRP.config.enableDebugLogging and "enabled" or "disabled"), "SYSTEM")
    elseif command == "foodtest" then
        -- Test food system detection
        SurvivalRP:ShowMessage("Testing food system...", "SYSTEM")
        SurvivalRP:CheckForConsumables()
        local foodCount = 0
        local drinkCount = 0
        for itemId, count in pairs(SurvivalRP.bagContents or {}) do
            if SurvivalRP.foodDatabase[itemId] then
                if SurvivalRP.foodDatabase[itemId].type == "food" then
                    foodCount = foodCount + count
                elseif SurvivalRP.foodDatabase[itemId].type == "drink" then
                    drinkCount = drinkCount + count
                end
            end
        end
        SurvivalRP:ShowMessage("Found " .. foodCount .. " food items and " .. drinkCount .. " drink items in bags", "SYSTEM")
    elseif command == "help" then
        SurvivalRP:ShowMessage("Available commands:", "SYSTEM")
        print("  /srp - Show current stats")
        print("  /srp reset - Reset all stats to 100%")
        print("  /srp config - Open settings panel")
        print("  /srp toggle - Hide/show UI")
        print("  /srp test - Test visual effects")
        print("  /srp debug - Toggle debug logging")
        print("  /srp foodtest - Test food system detection")
        print("  /rest - Begin resting")
        print("  /rest stop - Stop resting")
        print("  /sleep - Begin sleeping")
        print("  /sleep stop - Stop sleeping")
        print("  /sleep status - Show sleep information")
        print("  /weather - Show current weather status")
    else
        -- Enhanced stats display with sleep and weather info
        local sleepInfo = ""
        if SurvivalRP.playerData.sleepData then
            sleepInfo = string.format(" | Sleep Debt: %.1fh", SurvivalRP.playerData.sleepData.sleepDebt)
        end
        
        local tempInfo = ""
        if SurvivalRP.playerData.temperature then
            local tempStatus = SurvivalRP:GetTemperatureStatus()
            tempInfo = string.format(" | Temp: %s (%.0f°F)", tempStatus, SurvivalRP.playerData.temperature)
        end
        
        SurvivalRP:ShowMessage("Current stats - Hunger: " .. math.floor(SurvivalRP.playerData.hunger) .. 
                              "%, Thirst: " .. math.floor(SurvivalRP.playerData.thirst) .. 
                              "%, Fatigue: " .. math.floor(SurvivalRP.playerData.fatigue) .. "%" .. sleepInfo .. tempInfo, "SYSTEM")
    end
end

SLASH_REST1 = "/rest"
function SlashCmdList.REST(msg)
    local command = string.lower(msg or "")
    
    if command == "stop" then
        SurvivalRP:StopResting()
    else
        SurvivalRP:StartResting()
    end
end

-- Sleep system commands
SLASH_SLEEP1 = "/sleep"
function SlashCmdList.SLEEP(msg)
    local command = string.lower(msg or "")
    
    if command == "stop" or command == "wake" then
        if SurvivalRP.HandleSleepCommand then
            SurvivalRP:HandleSleepCommand("stop")
        else
            SurvivalRP:ShowMessage("Sleep system not loaded yet. Try /reload.", "WARNING")
        end
    elseif command == "status" or command == "info" then
        if SurvivalRP.HandleSleepCommand then
            SurvivalRP:HandleSleepCommand("status")
        else
            SurvivalRP:ShowMessage("Sleep system not loaded yet. Try /reload.", "WARNING")
        end
    elseif command == "help" then
        SurvivalRP:ShowMessage("Sleep Commands:", "SYSTEM")
        print("  /sleep - Begin sleeping")
        print("  /sleep stop - Stop sleeping")
        print("  /sleep wake - Stop sleeping")
        print("  /sleep status - Show sleep information")
    else
        if SurvivalRP.HandleSleepCommand then
            SurvivalRP:HandleSleepCommand("")
        else
            SurvivalRP:ShowMessage("Sleep system not loaded yet. Try /reload.", "WARNING")
        end
    end
end

-- Weather system commands
SLASH_WEATHER1 = "/weather"
SLASH_WEATHER2 = "/srp_weather"
function SlashCmdList.WEATHER(msg)
    local command = string.lower(msg or "")
    
    if command == "help" then
        SurvivalRP:ShowMessage("Weather Commands:", "SYSTEM")
        print("  /weather - Show current weather status")
        print("  /weather help - Show this help")
    else
        if SurvivalRP.ShowWeatherStatus then
            SurvivalRP:ShowWeatherStatus()
        else
            SurvivalRP:ShowMessage("Weather system not loaded yet. Try /reload.", "WARNING")
        end
    end
end

-- Temperature commands (bonus command)
SLASH_TEMP1 = "/temp"
SLASH_TEMP2 = "/temperature"
function SlashCmdList.TEMP(msg)
    local command = string.lower(msg or "")
    
    if command == "help" then
        SurvivalRP:ShowMessage("Temperature Commands:", "SYSTEM")
        print("  /temp - Show current temperature status")
        print("  /temp detailed - Show detailed temperature information")
    elseif command == "detailed" or command == "detail" then
        if SurvivalRP.playerData.temperature then
            local temp = SurvivalRP.playerData.temperature
            local tempStatus, color = SurvivalRP:GetTemperatureStatus()
            
            SurvivalRP:ShowMessage(string.format("Temperature: %.1f°F (%s)", temp, tempStatus), "SYSTEM")
            
            -- Show clothing and shelter info if available
            if SurvivalRP.playerData.temperatureData then
                local tempData = SurvivalRP.playerData.temperatureData
                SurvivalRP:ShowMessage(string.format("Clothing Warmth: %d | Shelter Bonus: %+d | Heat Sources: %+d", 
                                                   tempData.clothingWarmth or 0, 
                                                   tempData.shelterBonus or 0, 
                                                   tempData.heatSourceBonus or 0), "SYSTEM")
            end
            
            -- Show weather effect if available
            if SurvivalRP.currentWeatherTempModifier then
                SurvivalRP:ShowMessage(string.format("Weather Effect: %+.1f°F", SurvivalRP.currentWeatherTempModifier), "SYSTEM")
            end
        else
            SurvivalRP:ShowMessage("Temperature system not initialized.", "WARNING")
        end
    else
        if SurvivalRP.playerData.temperature then
            local temp = SurvivalRP.playerData.temperature
            local tempStatus = SurvivalRP:GetTemperatureStatus()
            SurvivalRP:ShowMessage(string.format("Current Temperature: %.1f°F (%s)", temp, tempStatus), "SYSTEM")
        else
            SurvivalRP:ShowMessage("Temperature system not initialized.", "WARNING")
        end
    end
end

-- Load addon when ready
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:SetScript("OnEvent", function(self, event, addonLoaded)
    if addonLoaded == addonName then
        SurvivalRP:Initialize()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)