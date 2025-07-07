-- Data persistence system

-- This function replaces the placeholder in the main file
function SurvivalRP:LoadPlayerData()
    local playerName = UnitName("player")
    local realmName = GetRealmName()
    local characterKey = playerName .. "-" .. realmName
    
    if SurvivalRPData and SurvivalRPData[characterKey] then
        local savedData = SurvivalRPData[characterKey]
        for key, value in pairs(savedData) do
            if self.playerData[key] ~= nil then
                self.playerData[key] = value
            end
        end
    end
    
    -- Load settings
    self:LoadSettings()
end

-- This function replaces the placeholder in the main file
function SurvivalRP:SavePlayerData()
    local playerName = UnitName("player")
    local realmName = GetRealmName()
    local characterKey = playerName .. "-" .. realmName
    
    if not SurvivalRPData then
        SurvivalRPData = {}
    end
    
    SurvivalRPData[characterKey] = {}
    for key, value in pairs(self.playerData) do
        SurvivalRPData[characterKey][key] = value
    end
    
    -- Save settings
    self:SaveSettings()
end

function SurvivalRP:LoadSettings()
    if SurvivalRPSettings then
        for key, value in pairs(SurvivalRPSettings) do
            if self.config[key] ~= nil then
                self.config[key] = value
            end
        end
    end
end

function SurvivalRP:SaveSettings()
    SurvivalRPSettings = {}
    for key, value in pairs(self.config) do
        SurvivalRPSettings[key] = value
    end
end