local BaseStep = require("Step.BaseStep")
---@class MulTapStep:BaseStep 多重点击Step,识别到对应颜色然后才点击
local Step = class("MulTapStep", BaseStep)

-- example
local ExamplePoints = {{"x1,x2,y1,y2,color,offsetColor"}}

function Step:Reset()
    self.step = 1
end

function Step:SetPoint(points, internal)
    self.points = points
    self.step = 1

    -- 点击间隔
    self.internal = internal or 1
end

function Step:Execute()
    if self.step > #self.points then
        return true
    end

    local point = self.points[self.step]
    local result, x, y = Util.FindMulColorByTable(point)
    if result then
        Util.Click(x, y)
        self:MakeOperation()
    else
        if self:HasOperation() then
            self:ResetOperation()
            self.step = self.step + 1
            Util.WaitTime(self.internal)
        end
    end

    return false
end

function Step:IsComplete()
    return self.step > #self.points
end

return Step
