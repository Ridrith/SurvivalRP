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
    print("|cff00ff00SurvivalRP|r v" .. self.version .. " loaded successfully!")
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
    -- This will be implemented in food system
end

function SurvivalRP:HandleSpellcast(spellId)
    -- This will be implemented in food system
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
    elseif command == "help" then
        SurvivalRP:ShowMessage("Available commands:", "SYSTEM")
        print("  /srp - Show current stats")
        print("  /srp reset - Reset all stats to 100%")
        print("  /srp config - Open settings panel")
        print("  /srp toggle - Hide/show UI")
        print("  /srp test - Test visual effects")
        print("  /rest - Begin resting")
        print("  /rest stop - Stop resting")
    else
        SurvivalRP:ShowMessage("Current stats - Hunger: " .. math.floor(SurvivalRP.playerData.hunger) .. 
                              "%, Thirst: " .. math.floor(SurvivalRP.playerData.thirst) .. 
                              "%, Fatigue: " .. math.floor(SurvivalRP.playerData.fatigue) .. "%", "SYSTEM")
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

-- Load addon when ready
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:SetScript("OnEvent", function(self, event, addonLoaded)
    if addonLoaded == addonName then
        SurvivalRP:Initialize()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)