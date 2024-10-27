local pairs, ipairs = pairs, ipairs

---@class MulClickStep 多重点击Step,直接点击,不识别
---只能在迷宫这类不识别网络情况的状态下使用，其他地方禁止使用
local Step = {}

function Step:Execute(points, internal)
    self.points = points
    self.internal = internal
    self.step = 1

    for _, point in pairs(self.points) do
        Util.Click(point[1], point[2])
        --log("MulClickStep 点击" .. tostring(self.step))
        self.step = self.step + 1
        Util.WaitTime(self.internal)
    end
end

return Step
