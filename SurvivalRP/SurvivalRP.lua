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
    useSeperateChannel = false
}

-- Initialize addon
function SurvivalRP:Initialize()
    self:LoadPlayerData()
    self:RegisterAddonComm()
    self:CreateUI()
    self:RegisterEvents()
    self:StartUpdateTimer()
    
    -- Initialize food system
    self:InitializeFoodSystem()
    
    print("|cff00ff00SurvivalRP|r v" .. self.version .. " loaded successfully!")
end

-- Initialize food system
function SurvivalRP:InitializeFoodSystem()
    -- Initialize consumable tracking
    if not self.currentConsumption then
        self.currentConsumption = {
            itemId = nil,
            itemType = nil,
            startTime = nil,
            spellId = nil
        }
    end
    
    -- Initialize player consumables cache
    if not self.playerConsumables then
        self.playerConsumables = {food = {}, drink = {}}
    end
    
    -- Validate food database on startup
    if self.ValidateFoodDatabase then
        local isValid = self:ValidateFoodDatabase()
        if not isValid and self.debugMode then
            self:DebugPrint("Food database validation failed during initialization")
        end
    end
    
    -- Perform initial bag scan
    if self.CheckForConsumables then
        self:CheckForConsumables()
    end
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
    frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
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
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, _, spellId = ...
        if unit == "player" then
            self:HandleSpellcast(spellId)
        end
    elseif event == "UNIT_SPELLCAST_INTERRUPTED" or event == "UNIT_SPELLCAST_FAILED" then
        local unit = ...
        if unit == "player" then
            self:HandleSpellcastInterrupted()
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

function SurvivalRP:HandleSpellcastInterrupted()
    -- Handle interrupted eating/drinking
    if self.currentConsumption and self.currentConsumption.spellId then
        if self.debugMode then
            self:DebugPrint("Consumption interrupted for spell ID: " .. (self.currentConsumption.spellId or "nil"))
        end
        
        -- Clear the consumption tracking
        if self.ClearConsumptionTracking then
            self:ClearConsumptionTracking()
        end
    end
end

function SurvivalRP:CheckForConsumables()
    -- Call the food system implementation with error handling
    if self.CheckForConsumables then
        local success, err = pcall(function()
            -- Call the actual implementation in FoodSystem.lua
            return self:CheckForConsumables()
        end)
        if not success then
            self:ShowMessage("Error checking consumables: " .. (err or "Unknown error"), "WARNING")
        end
    end
end

function SurvivalRP:HandleSpellcast(spellId)
    -- Enhanced spell detection with error handling
    if not spellId then
        return
    end
    
    local success, err = pcall(function()
        -- Try the food system implementation first
        if self.HandleSpellcast then
            self:HandleSpellcast(spellId)
            return
        end
        
        -- Fallback implementation with basic spell detection
        local spellName = GetSpellInfo(spellId)
        if spellName then
            local lowerName = string.lower(spellName)
            
            -- Enhanced spell name detection
            local isEating = false
            local isDrinking = false
            
            -- Food patterns
            if string.find(lowerName, "food") or string.find(lowerName, "eat") or 
               string.find(lowerName, "bread") or string.find(lowerName, "meat") or
               string.find(lowerName, "fish") or string.find(lowerName, "meal") then
                isEating = true
            end
            
            -- Drink patterns
            if string.find(lowerName, "drink") or string.find(lowerName, "water") or 
               string.find(lowerName, "juice") or string.find(lowerName, "milk") or
               string.find(lowerName, "potion") then
                isDrinking = true
            end
            
            if isEating and self.HandleEating then
                self:HandleEating()
            elseif isDrinking and self.HandleDrinking then
                self:HandleDrinking()
            end
        end
        
        -- Basic fallback for known spell IDs
        if spellId == 430 or spellId == 432 or spellId == 1131 or spellId == 1135 then -- Drink spells
            if self.HandleDrinking then
                self:HandleDrinking()
            else
                self:HandleConsumption("drink", 6)
            end
        elseif spellId == 433 or spellId == 1133 or spellId == 1137 then -- Food spells
            if self.HandleEating then
                self:HandleEating()
            else
                self:HandleConsumption("food", 8)
            end
        end
    end)
    
    if not success then
        self:ShowMessage("Error handling spell cast: " .. (err or "Unknown error"), "WARNING")
    end
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

-- Test food system functionality
function SurvivalRP:TestFoodSystem()
    self:ShowMessage("Testing food system...", "SYSTEM")
    
    -- Test 1: Validate database
    if self.ValidateFoodDatabase then
        local isValid = self:ValidateFoodDatabase()
        self:ShowMessage("Database validation: " .. (isValid and "PASSED" or "FAILED"), isValid and "SYSTEM" or "WARNING")
    end
    
    -- Test 2: Test spell detection
    local testSpells = {430, 433, 432, 1131, 1133, 5004, 18124, 24005}
    for _, spellId in ipairs(testSpells) do
        local spellName = GetSpellInfo(spellId)
        if spellName then
            self:ShowMessage("Testing spell: " .. spellName .. " (ID: " .. spellId .. ")", "SYSTEM")
            self:HandleSpellcast(spellId)
        end
    end
    
    -- Test 3: Test generic consumption
    self:ShowMessage("Testing generic food consumption", "SYSTEM")
    if self.HandleEating then
        self:HandleEating()
    end
    
    self:ShowMessage("Testing generic drink consumption", "SYSTEM")
    if self.HandleDrinking then
        self:HandleDrinking()
    end
    
    -- Test 4: Bag scanning
    if self.CheckForConsumables then
        self:CheckForConsumables()
    end
    
    self:ShowMessage("Food system test completed", "SYSTEM")
end

-- Debug logging function (also available in main file)
function SurvivalRP:DebugPrint(message)
    if self.debugMode then
        print("|cffffcc00[SurvivalRP Debug]|r " .. message)
    end
end

-- Show food system status
function SurvivalRP:ShowFoodSystemStatus()
    self:ShowMessage("=== Food System Status ===", "SYSTEM")
    
    -- Debug mode status
    self:ShowMessage("Debug Mode: " .. (self.debugMode and "ON" or "OFF"), "SYSTEM")
    
    -- Database status
    if self.foodDatabase then
        local foodCount = 0
        local drinkCount = 0
        for _, item in pairs(self.foodDatabase) do
            if item.type == "food" then
                foodCount = foodCount + 1
            elseif item.type == "drink" then
                drinkCount = drinkCount + 1
            end
        end
        self:ShowMessage("Database: " .. foodCount .. " foods, " .. drinkCount .. " drinks", "SYSTEM")
    else
        self:ShowMessage("Database: NOT LOADED", "WARNING")
    end
    
    -- Spell detection status
    if self.consumableSpells then
        local eatSpells = #self.consumableSpells.eating
        local drinkSpells = #self.consumableSpells.drinking
        self:ShowMessage("Spell Detection: " .. eatSpells .. " eating, " .. drinkSpells .. " drinking", "SYSTEM")
    else
        self:ShowMessage("Spell Detection: NOT LOADED", "WARNING")
    end
    
    -- Current consumption status
    if self.currentConsumption then
        local consuming = self.currentConsumption.spellId and "YES" or "NO"
        self:ShowMessage("Currently Consuming: " .. consuming, "SYSTEM")
        if self.currentConsumption.spellId then
            self:ShowMessage("  Type: " .. (self.currentConsumption.itemType or "Unknown"), "SYSTEM")
            self:ShowMessage("  Spell ID: " .. (self.currentConsumption.spellId or "Unknown"), "SYSTEM")
        end
    end
    
    -- Bag scan status
    if self.playerConsumables then
        local foodTypes = 0
        local drinkTypes = 0
        for _ in pairs(self.playerConsumables.food or {}) do foodTypes = foodTypes + 1 end
        for _ in pairs(self.playerConsumables.drink or {}) do drinkTypes = drinkTypes + 1 end
        self:ShowMessage("In Bags: " .. foodTypes .. " food types, " .. drinkTypes .. " drink types", "SYSTEM")
    else
        self:ShowMessage("Bag Scan: NOT PERFORMED", "WARNING")
    end
    
    -- Function availability
    local functions = {
        "HandleSpellcast", "CheckForConsumables", "HandleEating", "HandleDrinking",
        "GetCurrentConsumableItem", "ValidateFoodDatabase", "DebugPrint"
    }
    
    local available = {}
    local missing = {}
    for _, func in ipairs(functions) do
        if self[func] then
            table.insert(available, func)
        else
            table.insert(missing, func)
        end
    end
    
    if #available > 0 then
        self:ShowMessage("Available Functions: " .. table.concat(available, ", "), "SYSTEM")
    end
    
    if #missing > 0 then
        self:ShowMessage("Missing Functions: " .. table.concat(missing, ", "), "WARNING")
    end
    
    self:ShowMessage("=========================", "SYSTEM")
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
        SurvivalRP.debugMode = not SurvivalRP.debugMode
        SurvivalRP:ShowMessage("Debug mode " .. (SurvivalRP.debugMode and "enabled" or "disabled"), "SYSTEM")
    elseif command == "testfood" then
        SurvivalRP:TestFoodSystem()
    elseif command == "validatefood" then
        if SurvivalRP.ValidateFoodDatabase then
            SurvivalRP:ValidateFoodDatabase()
        else
            SurvivalRP:ShowMessage("Food validation not available", "WARNING")
        end
    elseif command == "scanfood" then
        if SurvivalRP.CheckForConsumables then
            SurvivalRP:CheckForConsumables()
            SurvivalRP:ShowMessage("Bag scan completed", "SYSTEM")
        else
            SurvivalRP:ShowMessage("Bag scanning not available", "WARNING")
        end
    elseif command == "foodstatus" then
        SurvivalRP:ShowFoodSystemStatus()
    elseif command == "help" then
        SurvivalRP:ShowMessage("Available commands:", "SYSTEM")
        print("  /srp - Show current stats")
        print("  /srp reset - Reset all stats to 100%")
        print("  /srp config - Open settings panel")
        print("  /srp toggle - Hide/show UI")
        print("  /srp test - Test visual effects")
        print("  /srp debug - Toggle debug mode")
        print("  /srp testfood - Test food system")
        print("  /srp validatefood - Validate food database")
        print("  /srp scanfood - Scan bags for consumables")
        print("  /srp foodstatus - Show food system status")
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