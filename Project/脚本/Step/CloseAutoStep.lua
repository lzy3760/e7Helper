---@class CloseAutoBattleStep 关闭局内自动战斗
local BattleAutoStep = {}

local InBattlePanel = "45|157|FFFFFF,143|144|FFFFFF,151|151|FFFFFF,159|144|FFFFFF,1251|34|FFFFFF,1234|33|FFFFFF"

function BattleAutoStep:Execute()
    if not Util.CompareColor(InBattlePanel) then
        return false
    end

    if not GameUtil.IsAutoBattle() then
        GameUtil.SetAutoBattle()
    end

    return true
end

return BattleAutoStep
