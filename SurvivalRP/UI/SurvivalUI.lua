-- User Interface for survival bars and indicators

-- This function replaces the placeholder in the main file
function SurvivalRP:CreateUI()
    -- Main survival frame
    self.ui = {}
    self.ui.mainFrame = CreateFrame("Frame", "SurvivalRPMainFrame", UIParent, "BackdropTemplate")
    self.ui.mainFrame:SetSize(200, 120)
    self.ui.mainFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -20, -100)
    
    -- Set backdrop using the new system
    self.ui.mainFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = {left = 8, right = 8, top = 8, bottom = 8}
    })
    self.ui.mainFrame:SetBackdropColor(0, 0, 0, 0.8)
    
    self.ui.mainFrame:EnableMouse(true)
    self.ui.mainFrame:SetMovable(true)
    self.ui.mainFrame:RegisterForDrag("LeftButton")
    self.ui.mainFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    self.ui.mainFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    
    -- Title
    self.ui.title = self.ui.mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    self.ui.title:SetPoint("TOP", self.ui.mainFrame, "TOP", 0, -12)
    self.ui.title:SetText("Survival Status")
    
    -- Hunger bar
    self.ui.hungerBar = self:CreateStatusBar(self.ui.mainFrame, "Hunger", 0, -25, 1, 0.5, 0)
    
    -- Thirst bar
    self.ui.thirstBar = self:CreateStatusBar(self.ui.mainFrame, "Thirst", 0, -45, 0, 0.5, 1)
    
    -- Fatigue bar
    self.ui.fatigueBar = self:CreateStatusBar(self.ui.mainFrame, "Fatigue", 0, -65, 0.8, 0.8, 0)
    
    -- Temperature bar
    self.ui.temperatureBar = self:CreateStatusBar(self.ui.mainFrame, "Temperature", 0, -85, 0.5, 0.5, 0.5)
    
    -- Rest indicator
    self.ui.restIndicator = self.ui.mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    self.ui.restIndicator:SetPoint("BOTTOM", self.ui.mainFrame, "BOTTOM", 0, 12)
    self.ui.restIndicator:SetTextColor(0, 1, 0)
    self.ui.restIndicator:SetText("")
    
    -- Create visual effects frame AFTER the main UI is created
    self:CreateVisualEffectsFrame()
    
    print("|cff00ff00SurvivalRP|r UI created successfully!")
end

function SurvivalRP:CreateStatusBar(parent, name, x, y, r, g, b)
    local bar = CreateFrame("StatusBar", nil, parent)
    bar:SetSize(160, 12)
    bar:SetPoint("TOP", parent, "TOP", x, y)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(r, g, b)
    bar:SetMinMaxValues(0, 100)
    bar:SetValue(100)
    
    -- Background
    local bg = bar:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(bar)
    bg:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bg:SetVertexColor(r * 0.3, g * 0.3, b * 0.3, 0.8)
    
    -- Border using a simple frame instead of backdrop
    local border = CreateFrame("Frame", nil, bar)
    border:SetAllPoints(bar)
    border:SetFrameLevel(bar:GetFrameLevel() + 1)
    
    -- Create border textures manually
    local borderSize = 1
    local borderColor = {0, 0, 0, 1}
    
    -- Top border
    local topBorder = border:CreateTexture(nil, "OVERLAY")
    topBorder:SetColorTexture(unpack(borderColor))
    topBorder:SetPoint("TOPLEFT", border, "TOPLEFT", 0, 0)
    topBorder:SetPoint("TOPRIGHT", border, "TOPRIGHT", 0, 0)
    topBorder:SetHeight(borderSize)
    
    -- Bottom border
    local bottomBorder = border:CreateTexture(nil, "OVERLAY")
    bottomBorder:SetColorTexture(unpack(borderColor))
    bottomBorder:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT", 0, 0)
    bottomBorder:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT", 0, 0)
    bottomBorder:SetHeight(borderSize)
    
    -- Left border
    local leftBorder = border:CreateTexture(nil, "OVERLAY")
    leftBorder:SetColorTexture(unpack(borderColor))
    leftBorder:SetPoint("TOPLEFT", border, "TOPLEFT", 0, 0)
    leftBorder:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT", 0, 0)
    leftBorder:SetWidth(borderSize)
    
    -- Right border
    local rightBorder = border:CreateTexture(nil, "OVERLAY")
    rightBorder:SetColorTexture(unpack(borderColor))
    rightBorder:SetPoint("TOPRIGHT", border, "TOPRIGHT", 0, 0)
    rightBorder:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT", 0, 0)
    rightBorder:SetWidth(borderSize)
    
    -- Text
    local text = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    text:SetPoint("CENTER", bar, "CENTER", 0, 0)
    text:SetText(name .. ": 100%")
    bar.text = text
    
    return bar
end

function SurvivalRP:UpdateUI()
    if not self.ui or not self.ui.mainFrame then
        return
    end
    
    -- Update bars
    self.ui.hungerBar:SetValue(self.playerData.hunger)
    self.ui.hungerBar.text:SetText(string.format("Hunger: %d%%", math.floor(self.playerData.hunger)))
    
    self.ui.thirstBar:SetValue(self.playerData.thirst)
    self.ui.thirstBar.text:SetText(string.format("Thirst: %d%%", math.floor(self.playerData.thirst)))
    
    self.ui.fatigueBar:SetValue(self.playerData.fatigue)
    self.ui.fatigueBar.text:SetText(string.format("Fatigue: %d%%", math.floor(self.playerData.fatigue)))
    
    self.ui.temperatureBar:SetValue(self.playerData.temperature)
    self.ui.temperatureBar.text:SetText(string.format("Temp: %d°", math.floor(self.playerData.temperature)))
    
    -- Update rest indicator
    if self.playerData.isResting then
        self.ui.restIndicator:SetText("Resting...")
    else
        self.ui.restIndicator:SetText("")
    end
    
    -- Update bar colors based on values
    self:UpdateBarColors()
end

function SurvivalRP:UpdateBarColors()
    if not self.ui then
        return
    end
    
    -- Hunger bar color
    if self.playerData.hunger < 20 then
        self.ui.hungerBar:SetStatusBarColor(1, 0, 0) -- Red
    elseif self.playerData.hunger < 50 then
        self.ui.hungerBar:SetStatusBarColor(1, 0.5, 0) -- Orange
    else
        self.ui.hungerBar:SetStatusBarColor(1, 1, 0) -- Yellow
    end
    
    -- Thirst bar color
    if self.playerData.thirst < 20 then
        self.ui.thirstBar:SetStatusBarColor(1, 0, 0) -- Red
    elseif self.playerData.thirst < 50 then
        self.ui.thirstBar:SetStatusBarColor(0, 0.5, 1) -- Light blue
    else
        self.ui.thirstBar:SetStatusBarColor(0, 0.5, 1) -- Blue
    end
    
    -- Fatigue bar color
    if self.playerData.fatigue < 20 then
        self.ui.fatigueBar:SetStatusBarColor(0.5, 0, 0.5) -- Purple
    elseif self.playerData.fatigue < 50 then
        self.ui.fatigueBar:SetStatusBarColor(0.8, 0.4, 0) -- Brown
    else
        self.ui.fatigueBar:SetStatusBarColor(0.8, 0.8, 0) -- Yellow
    end
    
    -- Temperature bar color
    if self.playerData.temperature < 30 then
        self.ui.temperatureBar:SetStatusBarColor(0.5, 0.5, 1) -- Cold blue
    elseif self.playerData.temperature > 70 then
        self.ui.temperatureBar:SetStatusBarColor(1, 0.5, 0) -- Hot orange
    else
        self.ui.temperatureBar:SetStatusBarColor(0.5, 0.5, 0.5) -- Normal gray
    end
end