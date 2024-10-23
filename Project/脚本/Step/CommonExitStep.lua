local BaseStep = require("Step.BaseStep")

---@class CommonExitStep:BaseStep Í¨ÓÃÍË³ö
local CommonExitStep = class("CommonExitStep", BaseStep)

local PauseColor = {"1233|31|FFFFFF,1247|33|FFFFFF", 0.9}
local SettingColor = {"552|273|370808,550|348|2F221A,544|430|332519,545|505|322419", 0.9}
local ConfirmColor = {"598|440|2E2017,687|441|142746", 0.9}

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
        self:MakeOperation()
    else
        if self:HasOperation() then
            self.step = self.step + 1
            self:ResetOperation()
        end
    end
end

function CommonExitStep:Step2()
    local point = points[2]
    if Util.CompareColorByTable(SettingColor) then
        Util.Click(point[1], point[2])
        self:MakeOperation()
    else
        if self:HasOperation() then
            self.step = self.step + 1
            self:ResetOperation()
        end
    end
end

function CommonExitStep:Step3()
    local point = points[3]
    if Util.CompareColorByTable(ConfirmColor) then
        Util.Click(point[1], point[2])
        self:MakeOperation()
    else
        if self:HasOperation() then
            self.step = self.step + 1
            self:ResetOperation()
        end
    end
end

return CommonExitStep
