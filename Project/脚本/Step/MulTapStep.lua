---@class MulTapStep 多重点击Step,识别到对应颜色然后才点击
local Step = {}

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
        return
    end

    local point = self.points[self.step]
    local clickResult = Util.FindMulColorAndClick(point[1], point[2], point[3], point[4], point[5], point[6])

    if clickResult then
        self.step = self.step + 1
        Util.WaitTime(self.internal)
    end
end

function Step:IsComplete()
    return self.step > #self.points
end

return Step
