local BaseTask = require("Task.BaseTask")

---@type BattleEnterStep
local BattleEnterStep = require("Step.BattleEnterStep")
---@type BattleReadyStep
local BattleReadyStep = require("Step.BattleReadyStep")
---@type BattleAutoStep
local BattleAutoStep = require("Step.BattleAutoStep")
---@type MulClickStep
local MulClickStep = require("Step.MulClickStep")
---@type StoreBuyStep
local StoreBuyStep = require("Step.StoreBuyStep")
---@type CommonExitStep
local CommonExitStep = require("Step.CommonExitStep")

local StoreColor = {"30|32|FFFFFF,71|33|FFFFFF,89|35|FFFFFF,105|30|FFFFFF", 0.9}

---@class MazeIntensifyTask:BaseTask 迷宫强化石
local MazeTask = class("MazeIntensifyTask", BaseTask)

local Steps = {
    [2] = {
        mulColor = {727, 122, 960, 716, "958F1A", "125|-20|CBAE9F", 0, 0.9},
        swipeFrom = {850, 705},
        swipeTo = {843, 135}
    },
    [3] = {
        swipeTo = {787, 676},
        swipeFrom = {789, 111},
        clickPos = {1093, 665}
    }
}

function MazeTask:initialize()
    BaseTask.initialize(self, "迷宫强化石")
end

function MazeTask:Enter()
    BattleEnterStep:SetTarget("迷宫")
    BattleReadyStep:SetTarget(nil, nil)
    StoreBuyStep:SetTarget(BuyType.All, nil, StoreColor)
    StoreBuyStep:ResetBuyIndex()
    CommonExitStep:Reset()
end

function MazeTask:Update()
    Util.Invoke(self, "Step" .. self.curStep)
end

function MazeTask:Step1()
    BattleEnterStep:Execute()
    if BattleEnterStep:IsCompleted() then
        self:AddStep()
    end
end

-- 进大关
-- TODO 增加点击操作判断
function MazeTask:Step2()
    local config = Steps[2]
    local suc, x, y = Util.FindMulColorByTable(config.mulColor)
    if not suc then
        Util.Swipe(config.swipeFrom, config.swipeTo)
        Util.WaitTime(1.5)
        return
    end

    if Util.CompareColorByTable(config.inPanel) then
        Util.Click(x, y)
        self:MarkOperation()
    else
        if self:HasOperation() then
            self:AddStep()
        end
    end
end

-- 选小关
-- TODO 后续判断考虑下,有问题再判断
function MazeTask:Step3()
    Util.WaitTime(1.5)
    local config = Steps[3]
    Util.Swipe(config.swipeFrom, config.swipeTo)
    Util.WaitTime(1.5)
    local clickPos = config.clickPos
    Util.Click(clickPos[1], clickPos[2])
    self:AddStep()
end

-- 点击战斗
function MazeTask:Step4()
    local result = BattleReadyStep:Execute()
    if result then
        self:AddStep()
    end
end

-- 打开自动战斗
function MazeTask:Step5()
    if BattleAutoStep:Execute() then
        self:AddStep()
    end
end

function MazeTask:Step6()
    if not GameUtil.IsInMazeSelect() then
        return
    end

    -- 这里不改，迷宫中不会有问题
    local points = {{108, 76}, {486, 164}, {748, 480}, {108, 76}, {202, 105}, {745, 477}, {130, 510}}
    MulClickStep:Execute(points, 1)
    self:AddStep()
end

-- 打开商店
function MazeTask:Step7()
    if GameUtil.IsInMazeSelect() then
        Util.Click(645, 360)
        self:MarkOperation()
    else
        if self:HasOperation() then
            self:AddStep()
        end
    end
end

function MazeTask:Step8()
    Util.WaitTime(1)
    local result = StoreBuyStep:Execute()
    if result then
        self:AddStep()
    end
end

--TODO 退出商店判断
function MazeTask:Step9()
    Util.Click(72, 31)
    Util.WaitTime(1)
    self:AddStep()
end

function MazeTask:Step10()
    if CommonExitStep:Execute() then
        self:Completed()
    end
end

return MazeTask
