-- Configuration and settings system

function SurvivalRP:CreateSettingsPanel()
    local panel = CreateFrame("Frame", "SurvivalRPSettingsPanel", UIParent)
    panel.name = "SurvivalRP"
    panel:SetSize(400, 650)
    panel:Hide() -- Start hidden
    
    -- Make it draggable
    panel:EnableMouse(true)
    panel:SetMovable(true)
    panel:RegisterForDrag("LeftButton")
    panel:SetScript("OnDragStart", function(self) self:StartMoving() end)
    panel:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    
    -- Set position
    panel:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    
    -- Add backdrop
    if panel.SetBackdrop then
        panel:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32,
            insets = {left = 8, right = 8, top = 8, bottom = 8}
        })
        panel:SetBackdropColor(0, 0, 0, 0.9)
    end
    
    -- Close button
    local closeButton = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function() panel:Hide() end)
    
    -- Title
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("SurvivalRP Settings")
    
    -- Chat Mode Section
    local chatModeSection = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    chatModeSection:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20)
    chatModeSection:SetText("Emote Mode")
    
    -- Chat Mode Radio Buttons
    local chatModeButtons = {}
    local chatModes = {
        {key = "ADDON", label = "Addon Channel Only (Others with addon see it)"},
        {key = "EMOTE_ONLY", label = "Physical Emotes Only (No text)"},
        {key = "NORMAL", label = "Normal Chat (Everyone sees it)"}
    }
    
    for i, mode in ipairs(chatModes) do
        local button = CreateFrame("CheckButton", nil, panel, "ChatConfigCheckButtonTemplate")
        button:SetPoint("TOPLEFT", chatModeSection, "BOTTOMLEFT", 0, -20 - (i-1) * 25)
        button:SetChecked(SurvivalRP.config.chatMode == mode.key)
        
        local label = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        label:SetPoint("LEFT", button, "RIGHT", 5, 0)
        label:SetText(mode.label)
        
        button:SetScript("OnClick", function(self)
            if self:GetChecked() then
                SurvivalRP.config.chatMode = mode.key
                -- Uncheck other buttons
                for _, otherButton in pairs(chatModeButtons) do
                    if otherButton ~= self then
                        otherButton:SetChecked(false)
                    end
                end
            else
                -- Don't allow unchecking - at least one must be selected
                self:SetChecked(true)
            end
        end)
        
        chatModeButtons[i] = button
    end
    
    -- Decay rates section
    local decaySection = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    decaySection:SetPoint("TOPLEFT", chatModeSection, "BOTTOMLEFT", 0, -100)
    decaySection:SetText("Decay Rates (per minute)")
    
    -- Hunger decay rate slider
    local hungerSlider = CreateFrame("Slider", "SurvivalRPHungerSlider", panel, "OptionsSliderTemplate")
    hungerSlider:SetPoint("TOPLEFT", decaySection, "BOTTOMLEFT", 0, -20)
    hungerSlider:SetMinMaxValues(0.1, 2.0)
    hungerSlider:SetValue(SurvivalRP.config.hungerDecayRate)
    hungerSlider:SetValueStep(0.1)
    hungerSlider:SetWidth(200)
    
    -- Set slider labels
    hungerSlider.Low = hungerSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    hungerSlider.Low:SetPoint("TOPLEFT", hungerSlider, "BOTTOMLEFT", 0, -5)
    hungerSlider.Low:SetText("0.1")
    
    hungerSlider.High = hungerSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    hungerSlider.High:SetPoint("TOPRIGHT", hungerSlider, "BOTTOMRIGHT", 0, -5)
    hungerSlider.High:SetText("2.0")
    
    hungerSlider.Text = hungerSlider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    hungerSlider.Text:SetPoint("BOTTOM", hungerSlider, "TOP", 0, 5)
    hungerSlider.Text:SetText("Hunger: " .. SurvivalRP.config.hungerDecayRate)
    
    hungerSlider:SetScript("OnValueChanged", function(self, value)
        SurvivalRP.config.hungerDecayRate = value
        self.Text:SetText("Hunger: " .. string.format("%.1f", value))
    end)
    
    -- Thirst decay rate slider
    local thirstSlider = CreateFrame("Slider", "SurvivalRPThirstSlider", panel, "OptionsSliderTemplate")
    thirstSlider:SetPoint("TOPLEFT", hungerSlider, "BOTTOMLEFT", 0, -40)
    thirstSlider:SetMinMaxValues(0.1, 2.0)
    thirstSlider:SetValue(SurvivalRP.config.thirstDecayRate)
    thirstSlider:SetValueStep(0.1)
    thirstSlider:SetWidth(200)
    
    thirstSlider.Low = thirstSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    thirstSlider.Low:SetPoint("TOPLEFT", thirstSlider, "BOTTOMLEFT", 0, -5)
    thirstSlider.Low:SetText("0.1")
    
    thirstSlider.High = thirstSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    thirstSlider.High:SetPoint("TOPRIGHT", thirstSlider, "BOTTOMRIGHT", 0, -5)
    thirstSlider.High:SetText("2.0")
    
    thirstSlider.Text = thirstSlider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    thirstSlider.Text:SetPoint("BOTTOM", thirstSlider, "TOP", 0, 5)
    thirstSlider.Text:SetText("Thirst: " .. SurvivalRP.config.thirstDecayRate)
    
    thirstSlider:SetScript("OnValueChanged", function(self, value)
        SurvivalRP.config.thirstDecayRate = value
        self.Text:SetText("Thirst: " .. string.format("%.1f", value))
    end)
    
    -- Fatigue decay rate slider
    local fatigueSlider = CreateFrame("Slider", "SurvivalRPFatigueSlider", panel, "OptionsSliderTemplate")
    fatigueSlider:SetPoint("TOPLEFT", thirstSlider, "BOTTOMLEFT", 0, -40)
    fatigueSlider:SetMinMaxValues(0.1, 2.0)
    fatigueSlider:SetValue(SurvivalRP.config.fatigueDecayRate)
    fatigueSlider:SetValueStep(0.1)
    fatigueSlider:SetWidth(200)
    
    fatigueSlider.Low = fatigueSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    fatigueSlider.Low:SetPoint("TOPLEFT", fatigueSlider, "BOTTOMLEFT", 0, -5)
    fatigueSlider.Low:SetText("0.1")
    
    fatigueSlider.High = fatigueSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    fatigueSlider.High:SetPoint("TOPRIGHT", fatigueSlider, "BOTTOMRIGHT", 0, -5)
    fatigueSlider.High:SetText("2.0")
    
    fatigueSlider.Text = fatigueSlider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fatigueSlider.Text:SetPoint("BOTTOM", fatigueSlider, "TOP", 0, 5)
    fatigueSlider.Text:SetText("Fatigue: " .. SurvivalRP.config.fatigueDecayRate)
    
    fatigueSlider:SetScript("OnValueChanged", function(self, value)
        SurvivalRP.config.fatigueDecayRate = value
        self.Text:SetText("Fatigue: " .. string.format("%.1f", value))
    end)
    
    -- Visual effects checkbox
    local visualEffectsCheck = CreateFrame("CheckButton", "SurvivalRPVisualEffectsCheck", panel, "ChatConfigCheckButtonTemplate")
    visualEffectsCheck:SetPoint("TOPLEFT", fatigueSlider, "BOTTOMLEFT", 0, -40)
    visualEffectsCheck:SetChecked(SurvivalRP.config.showVisualEffects)
    
    local visualEffectsLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    visualEffectsLabel:SetPoint("LEFT", visualEffectsCheck, "RIGHT", 5, 0)
    visualEffectsLabel:SetText("Show Visual Effects")
    
    visualEffectsCheck:SetScript("OnClick", function(self)
        SurvivalRP.config.showVisualEffects = self:GetChecked()
    end)
    
    -- Enable sounds checkbox
    local soundsCheck = CreateFrame("CheckButton", "SurvivalRPSoundsCheck", panel, "ChatConfigCheckButtonTemplate")
    soundsCheck:SetPoint("TOPLEFT", visualEffectsCheck, "BOTTOMLEFT", 0, -5)
    soundsCheck:SetChecked(SurvivalRP.config.enableSounds)
    
    local soundsLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    soundsLabel:SetPoint("LEFT", soundsCheck, "RIGHT", 5, 0)
    soundsLabel:SetText("Enable Warning Sounds")
    
    soundsCheck:SetScript("OnClick", function(self)
        SurvivalRP.config.enableSounds = self:GetChecked()
    end)
    
    -- Enable emotes checkbox
    local emotesCheck = CreateFrame("CheckButton", "SurvivalRPEmotesCheck", panel, "ChatConfigCheckButtonTemplate")
    emotesCheck:SetPoint("TOPLEFT", soundsCheck, "BOTTOMLEFT", 0, -5)
    emotesCheck:SetChecked(SurvivalRP.config.enableEmotes)
    
    local emotesLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    emotesLabel:SetPoint("LEFT", emotesCheck, "RIGHT", 5, 0)
    emotesLabel:SetText("Enable Emotes")
    
    emotesCheck:SetScript("OnClick", function(self)
        SurvivalRP.config.enableEmotes = self:GetChecked()
    end)
    
    -- Reset button
    local resetButton = CreateFrame("Button", "SurvivalRPResetButton", panel, "UIPanelButtonTemplate")
    resetButton:SetSize(100, 25)
    resetButton:SetPoint("BOTTOM", panel, "BOTTOM", -60, 20)
    resetButton:SetText("Reset Stats")
    resetButton:SetScript("OnClick", function()
        SurvivalRP:ResetPlayerData()
        SurvivalRP:ShowMessage("Survival stats reset!", "SYSTEM")
    end)
    
    -- Save button
    local saveButton = CreateFrame("Button", "SurvivalRPSaveButton", panel, "UIPanelButtonTemplate")
    saveButton:SetSize(100, 25)
    saveButton:SetPoint("BOTTOM", panel, "BOTTOM", 60, 20)
    saveButton:SetText("Save Settings")
    saveButton:SetScript("OnClick", function()
        SurvivalRP:SaveSettings()
        SurvivalRP:ShowMessage("Settings saved!", "SYSTEM")
    end)
    
    -- Try to register with the new settings system
    if Settings and Settings.RegisterCanvasLayoutCategory then
        -- New settings system (10.0+)
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        if category then
            Settings.RegisterAddOnCategory(category)
            SurvivalRP.settingsCategory = category
        end
    elseif InterfaceOptions_AddCategory then
        -- Old settings system
        InterfaceOptions_AddCategory(panel)
    end
    
    return panel
end

-- Auto-create settings panel when this file loads
SurvivalRP.settingsPanel = SurvivalRP:CreateSettingsPanel()