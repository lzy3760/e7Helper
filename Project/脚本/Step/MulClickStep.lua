local pairs, ipairs = pairs, ipairs

---@class MulClickStep ���ص��Step,ֱ�ӵ��,��ʶ��
local Step = {}

function Step:Execute(points, internal)
    self.points = points
    self.internal = internal
    self.step = 1

    for _, point in pairs(self.points) do
        for i = 1, 2 do
            Util.Click(point[1], point[2])
            Util.WaitTime(0.1)
        end

        self.step = self.step + 1
        Util.WaitTime(self.internal)
    end
end

return Step
