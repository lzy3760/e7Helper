local BattleType = {
    ["迷宫"] = 1,
    ["精灵祭坛"] = 2,
    ["讨伐"] = 3
}

local inBattlePanel = "28|32|FFFFFF,525|688|4D3921"
local BattlePos = {{179, 351}, {}, {806, 341}, {}}

local EnterPos = {965, 643}

local State = {
    InHome = 1,
    InBattle = 2
}

local BaseStep = require("Step.BaseStep")
---@class BattleEnterStep:BaseStep 进入Battle战斗入口的Step
local Step = class("BattleEnterStep", BaseStep)

---@param battleType string Battle类型
---@param battlePos number Battle坐标
function Step:SetTarget(battleType)
    self:Reset()
    self.battleType = battleType
    self.battlePos = BattleType[battleType]
end

function Step:Execute()
    if self.state == State.InHome then
        if GameUtil.IsInHome() then
            Util.Click(EnterPos[1], EnterPos[2])
            self:MakeOperation()
        else
            if self:HasOperation() then
                self.state = State.InBattle
                Util.WaitTime(1)
                self:ResetOperation()
            end
        end
    elseif self.state == State.InBattle then
        if Util.CompareColor(inBattlePanel) then
            if BattleType[self.battleType] > 4 then
                -- todo Util.Swipe()
                Util.WaitTime(1)
            end

            local clickPos = BattlePos[self.battlePos]
            if clickPos then
                Util.Click(clickPos[1], clickPos[2])
                self:MakeOperation()
            end
        else
            if self:HasOperation() then
                self.complete = true
                self:ResetOperation()
            end
        end
    end
end

function Step:Reset()
    self.state = State.InHome
    self.complete = false
end

function Step:IsCompleted()
    return self.complete
end

return Step
