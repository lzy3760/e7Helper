---@class MulTapStep 多重点击Step
local Step = {}

-- example
local ExamplePoints = {{"x1,x2,y1,y2,color,offsetColor"}}

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
    local clickResult = Util.FindMulColorAndClick(point.x1, point.y1, point.x2, point.y2, point.firstColor,
        point.offsetColor)

    if clickResult then
        self.step = self.step + 1
        Util.WaitTime(self.internal)
    end
end

function Step:IsComplete()
    return self.step > #self.points
end

return Step
