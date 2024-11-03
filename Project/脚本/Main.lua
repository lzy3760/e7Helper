require("HWSDK")
---@type Project
local Project = require("Project")
---@type Update
local Update = require("Update")

-- Update:Init(function()
--     Project:Start()
-- end, function()

-- end)

Project:GameStart()

local testCount = 1
while true do
    if testCount > 0 then
        testCount = testCount - 1
        Project.Test()
    else
        Project:GameUpdate()
    end
end