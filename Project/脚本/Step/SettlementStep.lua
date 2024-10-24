local BaseStep = require("Step.BaseStep")
---@class SettlementStep:BaseStep 通用的结算界面
local SettlementStep = class("SettlementStep", BaseStep)

local confirmPanel = "1009|679|654E2A,1164|680|346728"
local confirmBtn = {
    x = 1166,
    y = 658
}

-- 这里数据好像有问题
local retryPanel = {"52|659|AB8759,256|658|FFFFFF,280|658|FFFFFF", 0.9}
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
function SettlementStep:SetRetry(hasRetry)
    self.hasRetry = hasRetry
end

function SettlementStep:Execute()
    if not self.state then
        self.state = State.Confirm 
    end

    if self.state == State.Confirm then
        if Util.CompareColor(confirmPanel) then
            Util.Click(confirmBtn.x, confirmBtn.y)
            self:MakeOperation()
        else
            if self:HasOperation() then
                if self.hasRetry then
                    log("切换到Retry")
                    self.state = State.Retry
                    self:ResetOperation()
                else
                    return true
                end
            end
        end
    end

    if self.state == State.Retry then
        log("检查RetryBtn")
        if Util.CompareColorByTable(retryPanel) then
            log("点击RetryBtn")
            Util.Click(retryBtn.x, retryBtn.y)
            self:MakeOperation()
        else
            log("检查是否操作了")
            if self:HasOperation() then
                log("确认Hunt点击")
                self:ResetOperation()
                self.state = nil
                return true
            end
        end
    end
end

-- 是否在重开的界面中
function SettlementStep:IsInRetryPanel()
    return Util.CompareColorByTable(retryPanel)
end

return SettlementStep
