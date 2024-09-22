local RandomStoreSet = require("Setting.RandomStoreSet")
local HuntSet = require("Setting.HuntSet")

local SettingMgr = {}
SettingMgr.Settings = {
    ["RandomStoreSet"] = RandomStoreSet,
    ["HuntSet"] = HuntSet
}

function SettingMgr:Init()
end

function SettingMgr:Enter()
    -- todo
    -- decode json
end

function SettingMgr:GetSet(setName)
    if self.Settings[setName] then
        return self.Settings[setName]
    end

    logError("’“≤ªµΩ∏√Set"..setName)
end

_G.SettingMgr = SettingMgr