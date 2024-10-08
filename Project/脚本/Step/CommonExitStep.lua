---@class CommonExitStep Í¨ÓÃÍË³ö
local CommonExitStep = {}
---@type MulClickStep
local MulClickStep = require("Step.MulClickStep")

local PauseColor = {}
local SettingColor = {}
local ConfirmColor = {}

local points = {{1243, 31}, {642, 272}, {741, 443}}

function CommonExitStep:Reset()
    self.step = 1
end

function CommonExitStep:Execute()
    if self.step == 1 then
        self:Step1()
    elseif self.step == 2 then
        self:Step2()
    elseif self.step == 3 then
        self:Step3()
    end

    return self.step > 3
end

function CommonExitStep:Step1()
    local point = points[1]
    if Util.CompareColorByTable(PauseColor) then
        Util.Click(point[1], point[2])
    else
        self.step = self.step + 1
    end
end

function CommonExitStep:Step2()
    local point = points[2]
    if Util.CompareColorByTable(SettingColor) then
        Util.Click(point[1], point[2])
    else
        self.step = self.step + 1
    end
end

function CommonExitStep:Step3()
    local point = points[3]
    if Util.CompareColorByTable(ConfirmColor) then
        Util.Click(point[1], point[2])
    else
        self.step = self.step + 1
    end
end

return CommonExitStep
