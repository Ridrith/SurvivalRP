-- Weather System Module
-- Handles weather effects and temperature modifications

-- Initialize weather system
function SurvivalRP:InitializeWeatherSystem()
    if not self.playerData.weatherData then
        self.playerData.weatherData = {
            currentWeather = "clear",
            weatherIntensity = 0.5, -- 0-1 scale
            weatherDuration = 0,
            nextWeatherChange = GetTime() + math.random(600, 1800), -- 10-30 minutes
            lastWeatherUpdate = GetTime(),
            seasonalModifier = 0,
            windSpeed = 0, -- 0-100 scale
            humidity = 50, -- 0-100 scale
            precipitation = 0, -- 0-100 scale
            visibility = 100, -- 0-100 scale (100 = clear)
            weatherHistory = {} -- Track recent weather patterns
        }
    end
end

-- Main weather update function
function SurvivalRP:UpdateWeatherSystem(deltaTime)
    if not self.playerData.weatherData then
        self:InitializeWeatherSystem()
    end
    
    local weatherData = self.playerData.weatherData
    local currentTime = GetTime()
    
    -- Update weather duration
    weatherData.weatherDuration = weatherData.weatherDuration + deltaTime
    
    -- Check if it's time for weather change
    if currentTime >= weatherData.nextWeatherChange then
        self:GenerateNewWeather()
    end
    
    -- Update weather intensity (natural fluctuation)
    self:UpdateWeatherIntensity(deltaTime)
    
    -- Update seasonal effects
    self:UpdateSeasonalEffects()
    
    -- Apply weather effects to temperature
    self.currentWeatherTempModifier = self:CalculateWeatherTemperatureModifier()
    
    -- Show weather messages occasionally
    if math.random(1, 2000) <= 1 then -- Very rare
        self:ShowWeatherMessage()
    end
end

function SurvivalRP:GenerateNewWeather()
    local weatherData = self.playerData.weatherData
    local zone = GetZoneText()
    
    -- Get zone weather tendencies
    local zoneTendencies = self:GetZoneWeatherTendencies(zone)
    
    -- Consider current weather for transitions
    local currentWeather = weatherData.currentWeather
    local possibleWeathers = self:GetPossibleWeatherTransitions(currentWeather, zoneTendencies)
    
    -- Select new weather
    local newWeather = self:SelectWeatherFromProbabilities(possibleWeathers)
    
    -- Set new weather
    weatherData.currentWeather = newWeather
    weatherData.weatherIntensity = math.random(30, 80) / 100 -- Start with moderate intensity
    weatherData.weatherDuration = 0
    weatherData.nextWeatherChange = GetTime() + self:GetWeatherDuration(newWeather)
    
    -- Update weather parameters
    self:UpdateWeatherParameters(newWeather)
    
    -- Store in history
    table.insert(weatherData.weatherHistory, {
        weather = newWeather,
        startTime = GetTime(),
        zone = zone
    })
    
    -- Keep history manageable
    if #weatherData.weatherHistory > 10 then
        table.remove(weatherData.weatherHistory, 1)
    end
    
    -- Show weather change message
    self:ShowWeatherChangeMessage(newWeather)
end

function SurvivalRP:GetZoneWeatherTendencies(zone)
    -- Define weather probabilities by zone type
    local weatherTendencies = {
        -- Desert zones - hot, dry, occasional sandstorms
        desert = {
            clear = 40,
            sunny = 30,
            hot = 20,
            sandstorm = 8,
            dusty = 2
        },
        
        -- Cold zones - snow, blizzards, cold weather
        arctic = {
            clear = 20,
            overcast = 25,
            snow = 25,
            blizzard = 15,
            fog = 10,
            freezing = 5
        },
        
        -- Temperate zones - varied weather
        temperate = {
            clear = 25,
            sunny = 20,
            overcast = 20,
            rain = 15,
            drizzle = 10,
            fog = 5,
            windy = 5
        },
        
        -- Tropical zones - humid, rainy
        tropical = {
            clear = 20,
            sunny = 15,
            humid = 20,
            rain = 20,
            storm = 10,
            overcast = 10,
            drizzle = 5
        },
        
        -- Magical zones - unpredictable
        magical = {
            clear = 15,
            arcane_storm = 20,
            magical_mist = 15,
            overcast = 15,
            rain = 10,
            snow = 10,
            sunny = 10,
            weird = 5
        },
        
        -- Underground/cave zones
        underground = {
            clear = 50,
            humid = 20,
            foggy = 15,
            damp = 10,
            musty = 5
        }
    }
    
    -- Map zones to weather types
    local zoneTypes = {
        -- Desert zones
        ["Tanaris"] = "desert",
        ["Uldum"] = "desert",
        ["Silithus"] = "desert",
        ["Thousand Needles"] = "desert",
        ["Badlands"] = "desert",
        
        -- Arctic zones
        ["Winterspring"] = "arctic",
        ["Icecrown"] = "arctic",
        ["Dragonblight"] = "arctic",
        ["Storm Peaks"] = "arctic",
        ["Borean Tundra"] = "arctic",
        ["Howling Fjord"] = "arctic",
        ["Dun Morogh"] = "arctic",
        ["Alterac Mountains"] = "arctic",
        
        -- Tropical zones
        ["Stranglethorn Vale"] = "tropical",
        ["Un'Goro Crater"] = "tropical",
        ["Zangarmarsh"] = "tropical",
        ["Sholazar Basin"] = "tropical",
        
        -- Magical zones
        ["Dalaran"] = "magical",
        ["Netherstorm"] = "magical",
        ["Crystalsong Forest"] = "magical",
        ["Karazhan"] = "magical",
        ["Hellfire Peninsula"] = "magical",
        
        -- Default to temperate for most zones
    }
    
    local zoneType = zoneTypes[zone] or "temperate"
    return weatherTendencies[zoneType]
end

function SurvivalRP:GetPossibleWeatherTransitions(currentWeather, zoneTendencies)
    -- Define logical weather transitions
    local transitions = {
        clear = {clear = 30, sunny = 25, overcast = 20, windy = 15, fog = 10},
        sunny = {sunny = 35, clear = 25, hot = 20, overcast = 15, windy = 5},
        overcast = {overcast = 30, rain = 25, drizzle = 20, clear = 15, fog = 10},
        rain = {rain = 30, overcast = 25, drizzle = 20, storm = 15, clear = 10},
        drizzle = {drizzle = 35, rain = 25, overcast = 20, fog = 15, clear = 5},
        storm = {storm = 25, rain = 30, overcast = 25, clear = 20},
        snow = {snow = 35, blizzard = 20, overcast = 20, clear = 15, fog = 10},
        blizzard = {blizzard = 20, snow = 40, overcast = 25, clear = 15},
        fog = {fog = 30, overcast = 25, drizzle = 20, clear = 25},
        windy = {windy = 30, clear = 25, overcast = 20, dusty = 15, sunny = 10},
        hot = {hot = 35, sunny = 30, clear = 20, dusty = 15},
        sandstorm = {sandstorm = 25, dusty = 30, windy = 25, clear = 20},
        dusty = {dusty = 30, windy = 25, clear = 20, sandstorm = 15, sunny = 10}
    }
    
    local baseTransitions = transitions[currentWeather] or transitions.clear
    
    -- Blend with zone tendencies
    local blendedWeather = {}
    for weather, prob in pairs(baseTransitions) do
        local zoneProb = zoneTendencies[weather] or 0
        -- Weight 70% transition logic, 30% zone tendency
        blendedWeather[weather] = (prob * 0.7) + (zoneProb * 0.3)
    end
    
    return blendedWeather
end

function SurvivalRP:SelectWeatherFromProbabilities(weatherProbs)
    local totalWeight = 0
    for _, weight in pairs(weatherProbs) do
        totalWeight = totalWeight + weight
    end
    
    local random = math.random() * totalWeight
    local current = 0
    
    for weather, weight in pairs(weatherProbs) do
        current = current + weight
        if random <= current then
            return weather
        end
    end
    
    return "clear" -- Fallback
end

function SurvivalRP:GetWeatherDuration(weather)
    -- Different weather types have different duration ranges (in seconds)
    local durations = {
        clear = {600, 2400},      -- 10-40 minutes
        sunny = {900, 3600},      -- 15-60 minutes
        overcast = {300, 1800},   -- 5-30 minutes
        rain = {180, 900},        -- 3-15 minutes
        drizzle = {300, 1200},    -- 5-20 minutes
        storm = {120, 600},       -- 2-10 minutes
        snow = {300, 1800},       -- 5-30 minutes
        blizzard = {120, 480},    -- 2-8 minutes
        fog = {600, 1800},        -- 10-30 minutes
        windy = {300, 1200},      -- 5-20 minutes
        hot = {1200, 3600},       -- 20-60 minutes
        sandstorm = {180, 600},   -- 3-10 minutes
        dusty = {300, 900}        -- 5-15 minutes
    }
    
    local range = durations[weather] or durations.clear
    return math.random(range[1], range[2])
end

function SurvivalRP:UpdateWeatherParameters(weather)
    local weatherData = self.playerData.weatherData
    
    -- Set weather-specific parameters
    local parameters = {
        clear = {wind = 10, humidity = 40, precipitation = 0, visibility = 100},
        sunny = {wind = 5, humidity = 30, precipitation = 0, visibility = 100},
        overcast = {wind = 15, humidity = 60, precipitation = 0, visibility = 80},
        rain = {wind = 20, humidity = 90, precipitation = 70, visibility = 60},
        drizzle = {wind = 10, humidity = 80, precipitation = 30, visibility = 70},
        storm = {wind = 60, humidity = 95, precipitation = 90, visibility = 30},
        snow = {wind = 25, humidity = 70, precipitation = 60, visibility = 50},
        blizzard = {wind = 80, humidity = 85, precipitation = 80, visibility = 20},
        fog = {wind = 5, humidity = 95, precipitation = 10, visibility = 25},
        windy = {wind = 50, humidity = 40, precipitation = 0, visibility = 85},
        hot = {wind = 8, humidity = 20, precipitation = 0, visibility = 90},
        sandstorm = {wind = 70, humidity = 10, precipitation = 0, visibility = 15},
        dusty = {wind = 30, humidity = 25, precipitation = 0, visibility = 60}
    }
    
    local params = parameters[weather] or parameters.clear
    weatherData.windSpeed = params.wind + math.random(-10, 10)
    weatherData.humidity = math.max(0, math.min(100, params.humidity + math.random(-15, 15)))
    weatherData.precipitation = math.max(0, math.min(100, params.precipitation + math.random(-10, 10)))
    weatherData.visibility = math.max(0, math.min(100, params.visibility + math.random(-10, 10)))
end

function SurvivalRP:UpdateWeatherIntensity(deltaTime)
    local weatherData = self.playerData.weatherData
    
    -- Natural fluctuation in weather intensity
    local change = (math.random() - 0.5) * 0.1 * (deltaTime / 60) -- Small changes over time
    weatherData.weatherIntensity = math.max(0.1, math.min(1.0, weatherData.weatherIntensity + change))
end

function SurvivalRP:UpdateSeasonalEffects()
    local weatherData = self.playerData.weatherData
    
    -- Simple seasonal system based on current month
    local month = tonumber(date("%m"))
    local seasonalMods = {
        [12] = -8, [1] = -10, [2] = -8,  -- Winter
        [3] = -2, [4] = 2, [5] = 5,      -- Spring
        [6] = 8, [7] = 10, [8] = 8,      -- Summer
        [9] = 2, [10] = -2, [11] = -5    -- Fall
    }
    
    weatherData.seasonalModifier = seasonalMods[month] or 0
end

function SurvivalRP:CalculateWeatherTemperatureModifier()
    if not self.playerData.weatherData then
        return 0
    end
    
    local weatherData = self.playerData.weatherData
    local weather = weatherData.currentWeather
    local intensity = weatherData.weatherIntensity
    
    -- Base temperature modifiers for different weather types
    local baseModifiers = {
        clear = 0,
        sunny = 8,
        overcast = -3,
        rain = -8,
        drizzle = -5,
        storm = -12,
        snow = -15,
        blizzard = -25,
        fog = -5,
        windy = -6,
        hot = 15,
        sandstorm = -5, -- Hot but blocks sun
        dusty = -3,
        
        -- Magical weather
        arcane_storm = -10,
        magical_mist = -8,
        weird = math.random(-15, 15) -- Chaotic!
    }
    
    local baseMod = baseModifiers[weather] or 0
    
    -- Scale by intensity
    local intensityMod = baseMod * intensity
    
    -- Wind chill effect
    local windChill = 0
    if weatherData.windSpeed > 20 then
        windChill = -(weatherData.windSpeed - 20) * 0.3
    end
    
    -- Humidity effects
    local humidityMod = 0
    if weatherData.humidity > 70 and self.playerData.temperature > 80 then
        -- High humidity makes heat feel worse
        humidityMod = (weatherData.humidity - 70) * 0.2
    elseif weatherData.humidity < 30 and self.playerData.temperature < 40 then
        -- Low humidity makes cold feel worse
        humidityMod = -(30 - weatherData.humidity) * 0.1
    end
    
    -- Seasonal modifier
    local seasonalMod = weatherData.seasonalModifier or 0
    
    return intensityMod + windChill + humidityMod + seasonalMod
end

-- Enhanced GetWeatherMultiplier for survival mechanics
function SurvivalRP:GetWeatherMultiplier()
    if not self.playerData.weatherData then
        return 1.0
    end
    
    local weatherData = self.playerData.weatherData
    local weather = weatherData.currentWeather
    local intensity = weatherData.weatherIntensity
    
    -- Weather affects survival needs differently
    local weatherEffects = {
        clear = 1.0,
        sunny = 1.1,        -- Slightly increased thirst
        overcast = 1.0,
        rain = 0.9,         -- Rain helps with thirst but makes travel harder
        drizzle = 0.95,
        storm = 1.3,        -- Stressful conditions
        snow = 1.2,         -- Cold increases caloric needs
        blizzard = 1.5,     -- Extreme survival conditions
        fog = 1.1,          -- Slightly disorienting
        windy = 1.1,        -- Increases caloric needs
        hot = 1.4,          -- High heat increases all needs
        sandstorm = 1.6,    -- Extreme conditions
        dusty = 1.2
    }
    
    local baseMult = weatherEffects[weather] or 1.0
    
    -- Scale effect by intensity
    local finalMult = 1.0 + ((baseMult - 1.0) * intensity)
    
    return finalMult
end

function SurvivalRP:ShowWeatherChangeMessage(newWeather)
    if not self.config.enableWeatherEffects then
        return
    end
    
    local messages = {
        clear = "The sky clears up, revealing blue skies above.",
        sunny = "The sun breaks through the clouds, warming the air.",
        overcast = "Clouds gather overhead, casting the area in shadow.",
        rain = "Rain begins to fall from the darkening sky.",
        drizzle = "A light drizzle starts to mist the air.",
        storm = "A fierce storm rolls in with thunder and lightning!",
        snow = "Snowflakes begin to drift down from gray clouds.",
        blizzard = "A howling blizzard engulfs the area!",
        fog = "A thick fog rolls in, reducing visibility.",
        windy = "The wind picks up, whistling through the area.",
        hot = "The temperature rises as the sun beats down intensely.",
        sandstorm = "A massive sandstorm approaches on the horizon!",
        dusty = "Dust kicks up in the air, creating a hazy atmosphere.",
        
        -- Magical weather
        arcane_storm = "Arcane energies crackle in the air as a magical storm forms!",
        magical_mist = "An otherworldly mist begins to swirl around the area.",
        weird = "The very air seems to shimmer with strange, chaotic energy..."
    }
    
    local message = messages[newWeather] or "The weather changes."
    self:ShowMessage(message, "SYSTEM")
end

function SurvivalRP:ShowWeatherMessage()
    if not self.playerData.weatherData then
        return
    end
    
    local weatherData = self.playerData.weatherData
    local weather = weatherData.currentWeather
    local intensity = weatherData.weatherIntensity
    
    local intensityMessages = {
        rain = {
            [0.3] = "Light raindrops patter softly around you.",
            [0.7] = "Steady rain falls, soaking the ground.",
            [1.0] = "Heavy rain pounds down relentlessly."
        },
        wind = {
            [0.3] = "A gentle breeze stirs the air.",
            [0.7] = "Strong winds howl through the area.",
            [1.0] = "Fierce gales threaten to knock you off balance!"
        },
        snow = {
            [0.3] = "Light snow dusts the landscape.",
            [0.7] = "Steady snowfall blankets everything in white.",
            [1.0] = "Heavy snow falls in thick, blinding sheets."
        }
    }
    
    -- Show intensity-based messages for certain weather types
    if intensityMessages[weather] then
        local messages = intensityMessages[weather]
        local threshold = intensity <= 0.4 and 0.3 or (intensity <= 0.8 and 0.7 or 1.0)
        local message = messages[threshold]
        if message then
            self:ShowMessage(message, "SYSTEM")
        end
    end
end

-- Get current weather info for UI/commands
function SurvivalRP:GetWeatherInfo()
    if not self.playerData.weatherData then
        self:InitializeWeatherSystem()
    end
    
    local weatherData = self.playerData.weatherData
    local weather = weatherData.currentWeather
    local intensity = math.floor(weatherData.intensity * 100)
    local tempMod = self.currentWeatherTempModifier or 0
    
    return {
        weather = weather,
        intensity = intensity,
        temperatureModifier = tempMod,
        windSpeed = weatherData.windSpeed,
        humidity = weatherData.humidity,
        visibility = weatherData.visibility
    }
end

-- Command to check weather
function SurvivalRP:ShowWeatherStatus()
    local info = self:GetWeatherInfo()
    local weather = info.weather:gsub("_", " "):gsub("(%a)([%w_']*)", function(first, rest) return first:upper()..rest end)
    
    self:ShowMessage(string.format("Weather: %s (%d%% intensity) | Temp Effect: %+.1f°F", 
                                 weather, info.intensity, info.temperatureModifier), "SYSTEM")
    self:ShowMessage(string.format("Wind: %d mph | Humidity: %d%% | Visibility: %d%%", 
                                 math.floor(info.windSpeed), math.floor(info.humidity), math.floor(info.visibility)), "SYSTEM")
end