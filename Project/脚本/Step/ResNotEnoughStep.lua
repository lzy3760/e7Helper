---@class ResNotEnoughStep 资源不足的Step
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

-- isBuy 是否购买
-- sucFunc 购买成功之后的回调
-- cancelFunc 取消购买后的回调
-- 目前只支持local函数
function Step:SetCallBack(isBuy, sucFunc, cancelFunc)
    self.sucFunc = sucFunc
    self.cancelFunc = cancelFunc
    self.isBuy = isBuy
end

-- 体力是否足够,没弹界面就是足够
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
