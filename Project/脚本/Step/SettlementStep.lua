local BaseStep = require("Step.BaseStep")
---@class SettlementStep:BaseStep ͨ�õĽ������
local SettlementStep = class("SettlementStep", BaseStep)

local confirmPanel = "1009|679|654E2A,1164|680|346728"
local confirmBtn = {
    x = 1166,
    y = 658
}

--�������ݺ���������
local retryPanel = "116|683|795D30,271|681|71552D"
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
function SettlementStep:SetTarget(hasRetry)
    self:Reset()
    self.hasRetry = hasRetry
end

function SettlementStep:Execute()
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
        if Util.CompareColor(retryPanel) then
            log("���RetryBtn")
            Util.Click(retryBtn.x, retryBtn.y)
            self:MakeOperation()
        else
            if self:HasOperation() then
                log("ȷ��Hunt���")
                self:ResetOperation()
                return true
            end
        end
    end
end

-- �Ƿ����ؿ��Ľ�����
function SettlementStep:IsInRetryPanel()
    return Util.CompareColor(retryPanel)
end

function SettlementStep:Reset()
    self.hasRetry = false
    self.state = State.Confirm
end

return SettlementStep
