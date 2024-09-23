---@class BattleReadyStep ս��ǰ׼��,����رտ���ս��,�ر�����ս��
local BattleReadyStep = {}

local inPanel = "17|665|0D1E3B,120|663|0D1E3B"
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
    return Util.CompareColor(inPanel)
end

function BattleReadyStep:Execute()
    if not Util.CompareColor(inPanel) then
        return false
    end

    if self.quickBattle ~= nil then
        if GameUtil.IsQuickBattle() ~= self.quickBattle then
            GameUtil.SetQuickBattle()
        end
    end

    if self.continueBattle ~= nil then
        if GameUtil.IsContinueBattle() ~= self.continueBattle then
            GameUtil.SetContinueBattle()
        end
    end

    Util.Click(click.x, click.y)
    return true
end

function BattleReadyStep:Reset()
    self.quickBattle = nil
    self.continueBattle = nil
end

return BattleReadyStep
