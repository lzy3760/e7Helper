---@class BattleAutoStep 局内自动战斗
local BattleAutoStep = {}
local InBattlePanel = "1197|34|FFFFFF,1249|32|FFFFFF"

function BattleAutoStep:Execute()
    if not Util.CompareColor(InBattlePanel) then
        print("不在战斗界面")
        return false
    end

    Util.WaitTime(0.5)
    if not GameUtil.IsAutoBattle() then
        print("没有打开自动战斗，打开自动战斗")
        GameUtil.SetAutoBattle()
        return false
    else
        return true
    end
end

return BattleAutoStep
