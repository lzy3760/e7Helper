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
        GameUtil.SetAutoBattle()
    end

    return true
end

return BattleAutoStep
