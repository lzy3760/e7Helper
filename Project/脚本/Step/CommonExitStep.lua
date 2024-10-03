---@class CommonExitStep Í¨ÓÃÍË³ö
local CommonExitStep = {}
---@type MulClickStep
local MulClickStep = require("Step.MulClickStep")

local points = {{1243, 31}, {642, 272}, {741, 443}}

function CommonExitStep:Execute()
    MulClickStep:Execute(points, 1)
end

return CommonExitStep
