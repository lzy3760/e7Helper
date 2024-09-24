---@class ResNotEnoughStep ��Դ�����Step
local Step = {}

local Points = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {
        select = 0,
        buy = 0
    }
}

function Step:Reset()
    self.sucFunc = nil
    self.cancelFunc = nil
    self.isBuy = false
    self.step = 1
end

-- isBuy �Ƿ���
-- sucFunc ����ɹ�֮��Ļص�
-- cancelFunc ȡ�������Ļص�
-- Ŀǰֻ֧��local����
function Step:SetCallBack(isBuy, sucFunc, cancelFunc)
    self.sucFunc = sucFunc
    self.cancelFunc = cancelFunc
    self.isBuy = isBuy
end

-- �����Ƿ��㹻,û����������㹻
local function IsResEnough(resType)
    
end

function Step:Execute(resType)
    local config = Points[resType]

    if IsResEnough(resType) then
        return true
    else
        if self.step == 1 then
            Util.Click(config.select.x, config.select.y)
            self.step = self.step + 1
        elseif self.step == 2 then
            Util.Click(config.buy.x, config.buy.y)
            return true
        end
    end
end

return Step
