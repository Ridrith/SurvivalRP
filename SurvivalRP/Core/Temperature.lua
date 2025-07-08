-- Temperature system

-- This function replaces the placeholder in SurvivalMechanics
function SurvivalRP:UpdateTemperature()
    if not self.config.enableTemperature then
        return
    end
    
    local targetTemp = self:GetTargetTemperature()
    local tempDiff = targetTemp - self.playerData.temperature
    
    -- Gradual temperature adjustment
    if math.abs(tempDiff) > 1 then
        local adjustment = tempDiff > 0 and 0.5 or -0.5
        self.playerData.temperature = self.playerData.temperature + adjustment
    end
    
    -- Clamp temperature to new range
    self.playerData.temperature = math.max(-50, math.min(150, self.playerData.temperature))
    
    -- Apply temperature effects
    self:ApplyTemperatureEffects()
end

function SurvivalRP:GetTargetTemperature()
    local baseTemp = 68 -- Normal comfortable temperature
    
    -- Get current zone and subzone
    local zone = GetZoneText()
    local subzone = GetSubZoneText()
    
    -- Extreme Cold Zones (-50 to 19)
    local extremeColdZones = {
        ["Icecrown"] = -40,
        ["Icecrown Glacier"] = -45,
        ["Icecrown Citadel"] = -35,
        ["Dragonblight"] = -20,
        ["Northrend"] = -25,
        ["Winterspring"] = -15,
        ["Alterac Mountains"] = -10,
        ["Coldarra"] = -50,
        ["The Nexus"] = -30,
        ["Storm Peaks"] = -35,
        ["Sholazar Basin"] = 5, -- Warmer due to being protected
        ["Borean Tundra"] = -25,
        ["Howling Fjord"] = -15,
        ["Grizzly Hills"] = 10,
        ["Crystalsong Forest"] = -5,
        ["Zul'Drak"] = -10,
        ["The Undercity"] = 15, -- Underground but still cold
        ["Tirisfal Glades"] = 20, -- Dead lands, perpetually cool
    }
    
    -- Cold Zones (20 to 59)
    local coldZones = {
        ["Dun Morogh"] = 25,
        ["Ironforge"] = 45, -- Warmer due to forges
        ["Loch Modan"] = 35,
        ["Wetlands"] = 40,
        ["Arathi Highlands"] = 50,
        ["Hillsbrad Foothills"] = 45,
        ["Silverpine Forest"] = 35,
        ["Darkshore"] = 40,
        ["Ashenvale"] = 55,
        ["Felwood"] = 30, -- Corrupted and cold
        ["Azshara"] = 50,
        ["Teldrassil"] = 55,
        ["Darnassus"] = 60, -- Protected by World Tree
        ["Moonglade"] = 58,
        ["Desolace"] = 45, -- Barren and cool
        ["Thousand Needles"] = 55, -- Desert but elevated
    }
    
    -- Temperate Zones (60 to 78)
    local temperateZones = {
        ["Elwynn Forest"] = 70,
        ["Stormwind City"] = 72,
        ["Westfall"] = 68,
        ["Redridge Mountains"] = 65,
        ["Duskwood"] = 62,
        ["Stranglethorn Vale"] = 75,
        ["Booty Bay"] = 78,
        ["The Barrens"] = 72,
        ["Orgrimmar"] = 75,
        ["Mulgore"] = 70,
        ["Thunder Bluff"] = 68,
        ["Dustwallow Marsh"] = 74,
        ["Feralas"] = 72,
        ["Un'Goro Crater"] = 76, -- Warm but not extreme due to vegetation
        ["Silithus"] = 65, -- Desert but cooler due to silithid influence
        ["Gadgetzan"] = 75,
        ["Theramore"] = 74,
        ["Goldshire"] = 71,
        ["Lakeshire"] = 66,
        ["Darkshire"] = 60,
        ["Sentinel Hill"] = 69,
    }
    
    -- Warm Zones (79 to 98)
    local warmZones = {
        ["Tanaris"] = 85,
        ["Uldum"] = 88,
        ["Badlands"] = 82,
        ["Searing Gorge"] = 90,
        ["Burning Steppes"] = 85,
        ["Eastern Plaguelands"] = 80, -- Unnatural heat from corruption
        ["Western Plaguelands"] = 79,
        ["Hellfire Peninsula"] = 95,
        ["Zangarmarsh"] = 82, -- Humid and warm
        ["Nagrand"] = 80,
        ["Blade's Edge Mountains"] = 85,
        ["Netherstorm"] = 88, -- Arcane energy creates heat
        ["Shadowmoon Valley"] = 92,
        ["Terokkar Forest"] = 83,
        ["Shattrath City"] = 81,
    }
    
    -- Extreme Heat Zones (99 to 150)
    local extremeHeatZones = {
        ["Blackrock Mountain"] = 130,
        ["Blackrock Depths"] = 145,
        ["Blackwing Lair"] = 135,
        ["Molten Core"] = 150,
        ["Blackrock Spire"] = 125,
        ["The Slag Pit"] = 140,
        ["Firelands"] = 150,
        ["Mount Hyjal"] = 110, -- Fire-scarred but recovering
        ["Felwood"] = 105, -- In corrupted areas
        ["The Tainted Scar"] = 120,
        ["Magtheridon's Lair"] = 145,
        ["Gruul's Lair"] = 115,
    }
    
    -- Check for temperature matches
    if extremeColdZones[zone] then
        baseTemp = extremeColdZones[zone]
    elseif extremeColdZones[subzone] then
        baseTemp = extremeColdZones[subzone]
    elseif coldZones[zone] then
        baseTemp = coldZones[zone]
    elseif coldZones[subzone] then
        baseTemp = coldZones[subzone]
    elseif temperateZones[zone] then
        baseTemp = temperateZones[zone]
    elseif temperateZones[subzone] then
        baseTemp = temperateZones[subzone]
    elseif warmZones[zone] then
        baseTemp = warmZones[zone]
    elseif warmZones[subzone] then
        baseTemp = warmZones[subzone]
    elseif extremeHeatZones[zone] then
        baseTemp = extremeHeatZones[zone]
    elseif extremeHeatZones[subzone] then
        baseTemp = extremeHeatZones[subzone]
    end
    
    -- Special subzone adjustments
    local subzoneAdjustments = {
        -- Inns and taverns (warmer)
        ["The Prancing Pony"] = 15,
        ["Lion's Pride Inn"] = 15,
        ["The Slaughtered Lamb"] = 12,
        ["Thunderbrew Distillery"] = 20, -- Extra warm from brewing
        ["The Blue Recluse"] = 10,
        ["Pig and Whistle Tavern"] = 15,
        ["Deeprun Tram"] = 10,
        
        -- Caves and underground areas
        ["The Stockade"] = 8,
        ["Gnomeregan"] = 5,
        ["Deadmines"] = 10,
        ["Shadowfang Keep"] = -5,
        ["The Wailing Caverns"] = 12,
        ["Ragefire Chasm"] = 25,
        ["Razorfen Kraul"] = 8,
        ["Razorfen Downs"] = 5,
        ["Uldaman"] = 15,
        ["Zul'Farrak"] = 20,
        ["Maraudon"] = 12,
        ["Temple of Atal'Hakkar"] = 18,
        ["Stratholme"] = -8, -- Undead influence
        ["Scholomance"] = -10, -- Necromantic energies
        ["Dire Maul"] = 8,
        
        -- Specific hot areas
        ["The Cauldron"] = 25, -- In Searing Gorge
        ["Lava Pool"] = 35,
        ["The Furnace"] = 40,
        ["Thorium Point"] = 20,
        ["Kargath"] = 18,
        ["Flame Crest"] = 30,
        
        -- Specific cold areas
        ["Frostwhisper Gorge"] = -15,
        ["Lake Mereldar"] = -8,
        ["Chillwind Camp"] = -10,
        ["Everlook"] = -5,
        ["Frostsaber Rock"] = -12,
        ["Ice Thistle Hills"] = -18,
        
        -- Water areas (cooling effect)
        ["Mystral Lake"] = -5,
        ["Crystal Lake"] = -8,
        ["Lordamere Lake"] = -3,
        ["Darrowmere Lake"] = -5,
        ["The Great Sea"] = -10,
        ["Menethil Harbor"] = -3,
        
        -- Magical areas
        ["Dalaran"] = 5, -- Magically climate controlled
        ["Violet Citadel"] = 8,
        ["Karazhan"] = -5, -- Arcane energies create cold
        ["Tempest Keep"] = 10,
        ["Silvermoon City"] = 12, -- Magical warmth
        ["Exodar"] = 8, -- Climate controlled
    }
    
    -- Apply subzone adjustments
    if subzoneAdjustments[subzone] then
        baseTemp = baseTemp + subzoneAdjustments[subzone]
    end
    
    -- Indoor vs outdoor adjustments
    if IsIndoors() then
        if string.find(subzone, "Inn") or string.find(subzone, "Tavern") then
            baseTemp = baseTemp + 20 -- Inns are much warmer
        elseif string.find(subzone, "Forge") or string.find(subzone, "Smithy") then
            baseTemp = baseTemp + 25 -- Forges are very hot
        elseif string.find(subzone, "Mine") or string.find(subzone, "Cave") then
            baseTemp = baseTemp + 5 -- Underground is slightly warmer
        else
            baseTemp = baseTemp + 10 -- General indoor warmth
        end
    end
    
    -- Time of day adjustments (if available)
    local hour = tonumber(date("%H"))
    if hour then
        if hour >= 22 or hour <= 6 then
            baseTemp = baseTemp - 8 -- Nighttime is cooler
        elseif hour >= 12 and hour <= 16 then
            baseTemp = baseTemp + 5 -- Midday is warmer
        end
    end
    
    -- Weather adjustments (if you have weather detection)
    -- This would require additional weather detection code
    
    -- Clamp to our new temperature range
    return math.max(-50, math.min(150, baseTemp))
end

function SurvivalRP:ApplyTemperatureEffects()
    local temp = self.playerData.temperature
    
    -- Extreme cold effects (below 20)
    if temp < 20 then
        if temp < -20 then
            -- Severe hypothermia effects
            -- Could add health drain, movement speed reduction, etc.
        elseif temp < 0 then
            -- Moderate hypothermia effects
            -- Increase fatigue decay, slight movement penalty
        else
            -- Mild cold effects
            -- Slight fatigue increase
        end
    end
    
    -- Extreme heat effects (above 99)
    if temp > 99 then
        if temp > 130 then
            -- Severe hyperthermia effects
            -- Could add health drain, faster thirst decay
        elseif temp > 115 then
            -- Moderate hyperthermia effects
            -- Significant thirst increase
        else
            -- Mild heat effects
            -- Increased thirst decay
        end
    end
    
    -- Comfortable range (60-78) - no negative effects
    if temp >= 60 and temp <= 78 then
        -- Optimal temperature range
        -- Could provide small bonuses or just no penalties
    end
end

-- Helper function to get temperature status text
function SurvivalRP:GetTemperatureStatus()
    local temp = self.playerData.temperature
    
    if temp < -30 then
        return "Freezing", {r = 0.2, g = 0.6, b = 1.0}
    elseif temp < 0 then
        return "Very Cold", {r = 0.4, g = 0.8, b = 1.0}
    elseif temp < 20 then
        return "Cold", {r = 0.6, g = 0.9, b = 1.0}
    elseif temp < 40 then
        return "Cool", {r = 0.8, g = 0.95, b = 1.0}
    elseif temp < 60 then
        return "Mild", {r = 1.0, g = 1.0, b = 0.9}
    elseif temp <= 78 then
        return "Comfortable", {r = 0.9, g = 1.0, b = 0.9}
    elseif temp < 90 then
        return "Warm", {r = 1.0, g = 1.0, b = 0.7}
    elseif temp < 99 then
        return "Hot", {r = 1.0, g = 0.9, b = 0.5}
    elseif temp < 115 then
        return "Very Hot", {r = 1.0, g = 0.7, b = 0.3}
    elseif temp < 130 then
        return "Scorching", {r = 1.0, g = 0.5, b = 0.2}
    else
        return "Infernal", {r = 1.0, g = 0.2, b = 0.1}
    end
end