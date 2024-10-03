---@class SettlementStep 通用的结算界面
local SettlementStep = {}

local confirmPanel = "1009|679|654E2A,1164|680|346728"
local confirmBtn = {
    x = 1166,
    y = 658
}

local retryPanel = "116|683|795D30,271|681|71552D,1011|664|E3D7C9,1131|680|6D532D"
local retryBtn = {
    x = 1120,
    y = 662
}

local State = {
    -- 确认
    Confirm = 1,
    -- 重新开始
    Retry = 2
}

---@param hasRetry boolean 是否有重开这个步骤
function SettlementStep:SetTarget(hasRetry)
    self:Reset()
    self.hasRetry = hasRetry
end

function SettlementStep:Execute()
    if self.state == State.Confirm then
        if Util.CompareColor(confirmPanel) then
            Util.Click(confirmBtn.x, confirmBtn.y)
            if self.hasRetry then
                self.state = State.Retry
                Util.WaitTime(1)
            else
                return true
            end
        end
    end

    if self.state == State.Retry then
        if Util.CompareColor(retryPanel) then
            Util.Click(retryBtn.x, retryBtn.y)
            self.state = State.Confirm
            return true
        end
    end
end

function SettlementStep:Reset()
    self.hasRetry = false
    self.state = State.Confirm
end

return SettlementStep
