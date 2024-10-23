local BaseStep = require("Step.BaseStep")
---@class BattleReadyStep:BaseStep 战斗前准备,比如关闭快速战斗,关闭连续战斗
local BattleReadyStep = class("BattleReadyStep",BaseStep)

local inPanel = "17|665|0D1E3B,120|663|0D1E3B"
local click = {
    x = 1071,
    y = 661
}

---@param checkQuickBattle boolean 是否快速战斗
---@param checkContinueBattle boolean 是否连续战斗
-- 如果属性是nil代表不检查这两个属性
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
        if self:HasOperation() then
            log("讨伐点击")
            self:ResetOperation()
            return true
        else
            log("讨伐没有点击")
            return false
        end
    end

    if self.quickBattle ~= nil then
        if GameUtil.IsQuickBattle() ~= self.quickBattle then
            GameUtil.SetQuickBattle()
            log("设置快速挑战")
            return false
        end
    end

    Util.WaitTime(0.2)

    if self.continueBattle ~= nil then
        if GameUtil.IsContinueBattle() ~= self.continueBattle then
            GameUtil.SetContinueBattle()
            log("设置连续挑战")
            return false
        end
    end

    Util.Click(click.x, click.y)
    self:MakeOperation()
    log("讨伐标记点击")
    return false
end

function BattleReadyStep:Reset()
    self.quickBattle = nil
    self.continueBattle = nil
end

return BattleReadyStep
