---@class CommonBattleStep 通用的战斗判断,用户讨伐,后记什么的
local CommonBattleStep = {}

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

---@return boolean nil代表无结果,true代表胜利,false代表失败
function CommonBattleStep:Execute()
    if Util.CompareColor(sucPanel) then
        Util.Click(sucClick.x, sucClick.y)
        return true
    end

    if Util.CompareColor(failPanel) then
        Util.Click(failClick.x, failClick.y)
        return false
    end
end

return CommonBattleStep
