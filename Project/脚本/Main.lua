require("HWSDK")
---@type Project
local Project = require("Project")
---@type Update
local Update = require("Update")

Update:Init(function()
    Project:Start()
end, function()

end)
