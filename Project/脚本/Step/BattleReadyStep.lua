local BaseStep = require("Step.BaseStep")
---@class BattleReadyStep:BaseStep ս��ǰ׼��,����رտ���ս��,�ر�����ս��
local BattleReadyStep = class("BattleReadyStep", BaseStep)

local inPanel = {"731|269|514446,734|398|5C4446",0.8}
local click = {
    x = 1071,
    y = 661
}

---@param checkQuickBattle boolean �Ƿ����ս��
---@param checkContinueBattle boolean �Ƿ�����ս��
-- ���������nil�����������������
function BattleReadyStep:SetTarget(checkQuickBattle, checkContinueBattle)
    self:Reset()
    self.quickBattle = checkQuickBattle
    self.continueBattle = checkContinueBattle
end

function BattleReadyStep:IsInPanel()
    return Util.CompareColorByTable(inPanel)
end

function BattleReadyStep:Execute()
    if not Util.CompareColorByTable(inPanel) then
        if self:HasOperation() then
            log("�ַ����")
            self:ResetOperation()
            return true
        else
            log("�ַ�û�е��")
            return false
        end
    end

    if self.quickBattle ~= nil then
        if GameUtil.IsQuickBattle() ~= self.quickBattle then
            GameUtil.SetQuickBattle()
            log("���ÿ�����ս")
            return false
        end
    end

    Util.WaitTime(0.2)

    if self.continueBattle ~= nil then
        if GameUtil.IsContinueBattle() ~= self.continueBattle then
            GameUtil.SetContinueBattle()
            log("����������ս")
            return false
        end
    end

    Util.Click(click.x, click.y)
    self:MakeOperation()
    log("�ַ���ǵ��")
    return false
end

function BattleReadyStep:Reset()
    self.quickBattle = nil
    self.continueBattle = nil
end

return BattleReadyStep
