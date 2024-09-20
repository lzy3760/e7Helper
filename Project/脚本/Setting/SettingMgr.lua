local RandomStoreSet = require("Setting.RandomStoreSet")

local SettingMgr = {}
SettingMgr.Settings = {
    ["RandomStoreSet"] = RandomStoreSet
}

function SettingMgr:Init()
end

function SettingMgr:Enter()
    -- todo
    -- decode json
end

return SettingMgr
