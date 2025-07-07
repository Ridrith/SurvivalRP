-- Visual effects system for survival states

function SurvivalRP:CreateVisualEffectsFrame()
    if not self.ui then
        self.ui = {}
    end
    
    self.ui.effectsFrame = CreateFrame("Frame", "SurvivalRPEffectsFrame", UIParent)
    self.ui.effectsFrame:SetAllPoints(UIParent)
    self.ui.effectsFrame:SetFrameStrata("BACKGROUND")
    self.ui.effectsFrame:SetFrameLevel(0)
    
    -- Create overlay textures for each effect
    -- Hunger effect (red overlay)
    self.ui.hungerEffect = self.ui.effectsFrame:CreateTexture(nil, "OVERLAY")
    self.ui.hungerEffect:SetAllPoints(UIParent)
    self.ui.hungerEffect:SetTexture("Interface\\FullScreenTextures\\LowHealth")
    self.ui.hungerEffect:SetVertexColor(1, 0, 0, 0) -- Red, start invisible
    self.ui.hungerEffect:SetBlendMode("ADD")
    
    -- Thirst effect (blue overlay)
    self.ui.thirstEffect = self.ui.effectsFrame:CreateTexture(nil, "OVERLAY")
    self.ui.thirstEffect:SetAllPoints(UIParent)
    self.ui.thirstEffect:SetTexture("Interface\\FullScreenTextures\\LowHealth")
    self.ui.thirstEffect:SetVertexColor(0, 0.5, 1, 0) -- Blue, start invisible
    self.ui.thirstEffect:SetBlendMode("ADD")
    
    -- Fatigue effect (purple overlay)
    self.ui.fatigueEffect = self.ui.effectsFrame:CreateTexture(nil, "OVERLAY")
    self.ui.fatigueEffect:SetAllPoints(UIParent)
    self.ui.fatigueEffect:SetTexture("Interface\\FullScreenTextures\\LowHealth")
    self.ui.fatigueEffect:SetVertexColor(0.5, 0, 0.5, 0) -- Purple, start invisible
    self.ui.fatigueEffect:SetBlendMode("ADD")
    
    -- Temperature effects
    self.ui.coldEffect = self.ui.effectsFrame:CreateTexture(nil, "OVERLAY")
    self.ui.coldEffect:SetAllPoints(UIParent)
    self.ui.coldEffect:SetTexture("Interface\\FullScreenTextures\\LowHealth")
    self.ui.coldEffect:SetVertexColor(0.5, 0.5, 1, 0) -- Light blue, start invisible
    self.ui.coldEffect:SetBlendMode("ADD")
    
    self.ui.hotEffect = self.ui.effectsFrame:CreateTexture(nil, "OVERLAY")
    self.ui.hotEffect:SetAllPoints(UIParent)
    self.ui.hotEffect:SetTexture("Interface\\FullScreenTextures\\LowHealth")
    self.ui.hotEffect:SetVertexColor(1, 0.5, 0, 0) -- Orange, start invisible
    self.ui.hotEffect:SetBlendMode("ADD")
    
    print("|cff00ff00SurvivalRP|r Visual effects frame created successfully!")
end

function SurvivalRP:UpdateVisualEffects()
    if not self.config.showVisualEffects or not self.ui or not self.ui.effectsFrame then
        return
    end
    
    -- Debug: Show current values
    -- print("Updating visual effects - Hunger:", self.playerData.hunger, "Thirst:", self.playerData.thirst, "Fatigue:", self.playerData.fatigue)
    
    -- Hunger effects (red tint when low)
    local hungerAlpha = 0
    if self.playerData.hunger < 50 then
        hungerAlpha = math.min(0.4, (50 - self.playerData.hunger) / 50 * 0.4)
    end
    if self.ui.hungerEffect then
        self.ui.hungerEffect:SetAlpha(hungerAlpha)
    end
    
    -- Thirst effects (blue tint when low)
    local thirstAlpha = 0
    if self.playerData.thirst < 50 then
        thirstAlpha = math.min(0.4, (50 - self.playerData.thirst) / 50 * 0.4)
    end
    if self.ui.thirstEffect then
        self.ui.thirstEffect:SetAlpha(thirstAlpha)
    end
    
    -- Fatigue effects (purple tint when low)
    local fatigueAlpha = 0
    if self.playerData.fatigue < 50 then
        fatigueAlpha = math.min(0.4, (50 - self.playerData.fatigue) / 50 * 0.4)
    end
    if self.ui.fatigueEffect then
        self.ui.fatigueEffect:SetAlpha(fatigueAlpha)
    end
    
    -- Temperature effects
    local coldAlpha = 0
    local hotAlpha = 0
    if self.playerData.temperature < 30 then
        coldAlpha = math.min(0.3, (30 - self.playerData.temperature) / 30 * 0.3)
    elseif self.playerData.temperature > 70 then
        hotAlpha = math.min(0.3, (self.playerData.temperature - 70) / 30 * 0.3)
    end
    
    if self.ui.coldEffect then
        self.ui.coldEffect:SetAlpha(coldAlpha)
    end
    if self.ui.hotEffect then
        self.ui.hotEffect:SetAlpha(hotAlpha)
    end
end

function SurvivalRP:CheckCriticalStates()
    -- Check for critical hunger
    if self.playerData.hunger <= 10 and not self.criticalHunger then
        self.criticalHunger = true
        self:ShowMessage("You are starving! Find food immediately!", "WARNING")
        self:CreateScreenPulse(1, 0, 0) -- Red pulse
        if self.config.enableSounds then
            PlaySound(8959, "Master") -- Warning sound with channel
        end
    elseif self.playerData.hunger > 10 then
        self.criticalHunger = false
    end
    
    -- Check for critical thirst
    if self.playerData.thirst <= 10 and not self.criticalThirst then
        self.criticalThirst = true
        self:ShowMessage("You are severely dehydrated! Find water immediately!", "WARNING")
        self:CreateScreenPulse(0, 0.5, 1) -- Blue pulse
        if self.config.enableSounds then
            PlaySound(8959, "Master") -- Warning sound with channel
        end
    elseif self.playerData.thirst > 10 then
        self.criticalThirst = false
    end
    
    -- Check for critical fatigue
    if self.playerData.fatigue <= 10 and not self.criticalFatigue then
        self.criticalFatigue = true
        self:ShowMessage("You are exhausted! You need to rest!", "WARNING")
        self:CreateScreenPulse(0.5, 0, 0.5) -- Purple pulse
        if self.config.enableSounds then
            PlaySound(8959, "Master") -- Warning sound with channel
        end
    elseif self.playerData.fatigue > 10 then
        self.criticalFatigue = false
    end
end

-- Add a screen pulse effect for critical states
function SurvivalRP:CreateScreenPulse(r, g, b)
    if not self.ui or not self.ui.effectsFrame then
        return
    end
    
    -- Create temporary pulse effect
    local pulseTexture = self.ui.effectsFrame:CreateTexture(nil, "OVERLAY")
    pulseTexture:SetAllPoints(UIParent)
    pulseTexture:SetTexture("Interface\\FullScreenTextures\\LowHealth")
    pulseTexture:SetVertexColor(r, g, b, 0.6)
    pulseTexture:SetBlendMode("ADD")
    
    -- Animate the pulse
    local animationGroup = pulseTexture:CreateAnimationGroup()
    
    -- Fade in
    local fadeIn = animationGroup:CreateAnimation("Alpha")
    fadeIn:SetFromAlpha(0.6)
    fadeIn:SetToAlpha(0.8)
    fadeIn:SetDuration(0.3)
    fadeIn:SetOrder(1)
    
    -- Fade out
    local fadeOut = animationGroup:CreateAnimation("Alpha")
    fadeOut:SetFromAlpha(0.8)
    fadeOut:SetToAlpha(0)
    fadeOut:SetDuration(0.7)
    fadeOut:SetOrder(2)
    
    -- Clean up when animation finishes
    animationGroup:SetScript("OnFinished", function()
        pulseTexture:Hide()
        pulseTexture:SetParent(nil)
        pulseTexture = nil
    end)
    
    animationGroup:Play()
end

-- Add a test command to check visual effects
function SurvivalRP:TestVisualEffects()
    print("Testing visual effects...")
    
    -- Temporarily set low values to trigger effects
    local originalHunger = self.playerData.hunger
    local originalThirst = self.playerData.thirst
    local originalFatigue = self.playerData.fatigue
    
    self.playerData.hunger = 20
    self.playerData.thirst = 15
    self.playerData.fatigue = 10
    
    self:UpdateVisualEffects()
    
    -- Create a timer to restore original values
    C_Timer.After(5, function()
        self.playerData.hunger = originalHunger
        self.playerData.thirst = originalThirst
        self.playerData.fatigue = originalFatigue
        self:UpdateVisualEffects()
        print("Visual effects test completed - values restored.")
    end)
    
    print("Visual effects should be visible for 5 seconds...")
end