---@class MulTapStep 多重点击Step
local Step = {}

function Step:Reset()
    self.step = 1
end

function Step:SetPoint(points, internal)
    self.points = points
    self.step = #self.points

    -- 点击间隔
    self.internal = internal or 0
end

function Step:Execute()
    if self.step > #self.points then
        return
    end

    local point = self.points[self.step]
    Util.Click(point[1], point[2])
    self.step = self.step + 1
    Util.WaitTime(self.internal)
end

return Step
