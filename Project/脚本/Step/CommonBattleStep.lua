local BaseStep = require("Step.BaseStep")
---@class CommonBattleStep:BaseStep 通用的战斗判断,用户讨伐,后记什么的
local CommonBattleStep = class("CommonBattleStep", BaseStep)

local sucPanel = "594|238|278FB1,686|238|3F8EAB,640|218|FEFFA5"
local sucClick = {
    x = 650,
    y = 426
}

local failPanel = "183|405|3F772E,342|403|417930,182|468|6B5639,338|468|6A5538"
local failClick = {
    x = 1125,
    y = 658
}

local State = {
    Win = 1,
    Fail = 2
}

---@return boolean nil代表无结果,true代表胜利,false代表失败
function CommonBattleStep:Execute()
    if not self.state then
        self:ResetOperation()
        if Util.CompareColor(sucPanel) then
            self.state = State.Win
        end

        if Util.CompareColor(failPanel) then
            self.state = State.Fail
        end
    end

    if not self.state then
        log("未获取到结算状态结果")
        return
    end

    if self.state == State.Win then
        if Util.CompareColor(sucPanel) then
            Util.Click(sucClick.x, sucClick.y)
            self:MakeOperation()
        else
            if self:HasOperation() then
                self.state = nil
                return true
            end
        end
    elseif self.state == State.Fail then
        if Util.CompareColor(failPanel) then
            Util.Click(failClick.x, failClick.y)
            self:MakeOperation()
        else
            if self:HasOperation() then
                self.state = nil
                return false
            end
        end
    end
end

return CommonBattleStep
