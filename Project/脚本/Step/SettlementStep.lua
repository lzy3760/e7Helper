local BaseStep = require("Step.BaseStep")
---@class SettlementStep:BaseStep ͨ�õĽ������
local SettlementStep = class("SettlementStep", BaseStep)

local confirmPanel = "1009|679|654E2A,1164|680|346728"
local confirmBtn = {
    x = 1166,
    y = 658
}

-- �������ݺ���������
local retryPanel = {"52|659|AB8759,256|658|FFFFFF,280|658|FFFFFF", 0.9}
local retryBtn = {
    x = 1120,
    y = 662
}

local State = {
    -- ȷ��
    Confirm = 1,
    -- ���¿�ʼ
    Retry = 2
}

---@param hasRetry boolean �Ƿ����ؿ��������
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
                    log("�л���Retry")
                    self.state = State.Retry
                    self:ResetOperation()
                else
                    return true
                end
            end
        end
    end

    if self.state == State.Retry then
        log("���RetryBtn")
        if Util.CompareColorByTable(retryPanel) then
            log("���RetryBtn")
            Util.Click(retryBtn.x, retryBtn.y)
            self:MakeOperation()
        else
            log("����Ƿ������")
            if self:HasOperation() then
                log("ȷ��Hunt���")
                self:ResetOperation()
                self.state = nil
                return true
            end
        end
    end
end

-- �Ƿ����ؿ��Ľ�����
function SettlementStep:IsInRetryPanel()
    return Util.CompareColorByTable(retryPanel)
end

return SettlementStep
