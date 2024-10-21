---@class BattleAutoStep �����Զ�ս��
local BattleAutoStep = {}
local InBattlePanel = "1197|34|FFFFFF,1249|32|FFFFFF"

function BattleAutoStep:Execute()
    if not Util.CompareColor(InBattlePanel) then
        print("����ս������")
        return false
    end

    Util.WaitTime(0.5)
    if not GameUtil.IsAutoBattle() then
        print("û�д��Զ�ս�������Զ�ս��")
        GameUtil.SetAutoBattle()
        return false
    else
        return true
    end
end

return BattleAutoStep
