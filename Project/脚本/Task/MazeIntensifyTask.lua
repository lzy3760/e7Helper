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
    StoreBuyStep:SetTarget(BuyType.All, nil, Steps[2].mulColor)
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
-- todo 判断下第一关有没有给打通
function MazeTask:Step2()
    -- Util.WaitTime(1.5)
    -- local config = Steps[2]
    -- Util.Swipe(config.swipeFrom, config.swipeTo)
    -- Util.WaitTime(1.5)
    -- local clickPos = config.clickPos
    -- Util.Click(clickPos[1], clickPos[2])
    -- self:AddStep()

    local config = Steps[2]
    local suc, x, y = Util.FindMulColorByTable(config.mulColor)
    if suc then
        Util.Click(x, y)
        self:AddStep()
        return
    else
        Util.Swipe(config.swipeFrom, config.swipeTo)
        Util.WaitTime(1.5)
        suc, x, y = Util.FindMulColorByTable(config.mulColor)
        if not suc then
            logError("没有找到强化石迷宫入口")
        else
            Util.Click(x, y)
            self:AddStep()
        end
    end
end

-- 选小关
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

function MazeTask:Step7()
    if not GameUtil.IsInMazeSelect() then
        return
    end

    Util.WaitTime(1.5)

    for i = 1, 4 do
        Util.Click(645, 360)
        Util.WaitTime(0.3)
    end

    self:AddStep()
end

function MazeTask:Step8()
    Util.WaitTime(1)
    local result = StoreBuyStep:Execute()
    if result then
        self:AddStep()
    end
end

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
