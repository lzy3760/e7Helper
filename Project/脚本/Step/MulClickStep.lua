local pairs, ipairs = pairs, ipairs

---@class MulClickStep ���ص��Step,ֱ�ӵ��,��ʶ��
---ֻ�����Թ����಻ʶ�����������״̬��ʹ�ã������ط���ֹʹ��
local Step = {}

function Step:Execute(points, internal)
    self.points = points
    self.internal = internal
    self.step = 1

    for _, point in pairs(self.points) do
        Util.Click(point[1], point[2])
        --log("MulClickStep ���" .. tostring(self.step))
        self.step = self.step + 1
        Util.WaitTime(self.internal)
    end
end

return Step
