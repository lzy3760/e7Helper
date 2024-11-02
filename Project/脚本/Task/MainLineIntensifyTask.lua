local BaseTask = require("Task.BaseTask")

---@type MulClickStep
local MulClickStep = require("Step.MulClickStep")
---@type BattleReadyStep
local BattleReadyStep = require("Step.BattleReadyStep")
---@type BattleAutoStep
local BattleAutoStep = require("Step.BattleAutoStep")
---@type StoreBuyStep
local StoreBuyStep = require("Step.StoreBuyStep")
---@type CommonExitStep
local CommonExitStep = require("Step.CommonExitStep")

local StoreColor = {"30|32|FFFFFF,71|33|FFFFFF,89|35|FFFFFF,105|30|FFFFFF", 0.9}

---@class MainLineIntensifyTask:BaseTask 主线强化石
local Task = class("MainLineIntensifyTask", BaseTask)

local Points = {
    [2] = {
        inPanel = "1231|141|10E3F0,1226|622|F33636"
    },
    [3] = {
        swipeFrom = {131, 127},
        swipeTo = {330, 363},
        clickPos = {733, 578}
    },
    [4] = {
        inPanel = {683,151,905,719,"5C9D37","23|0|4E8C36|15|9|FFFFFF|14|11|FFFFFF|6|25|4C8E1F|13|25|40841D",0,0.98},
        clickPos = {1080, 666}
    }
}

function Task:initialize()
    BaseTask.initialize(self, "主线强化石")
end

function Task:Enter()
    BattleReadyStep:SetTarget(nil, nil)
    StoreBuyStep:SetTarget(BuyType.All, nil, StoreColor)
    StoreBuyStep:ResetBuyIndex()
    CommonExitStep:Reset()
end

function Task:Update()
    Util.Invoke(self, "Step" .. self.curStep)
end

function Task:Step1()
    if GameUtil.IsInHome() then
        Util.Click(1212, 637)
        self:MarkOperation()
    else
        if self:HasOperation() then
            self:AddStep()
        end
    end
end

-- 选择地图
function Task:Step2()
    local config = Points[2]
    if not Util.CompareColor(config.inPanel, 0.9) then
        return
    end

    Util.WaitTime(0.5)
    local points = {{1227, 620}, {278, 332}, {1236, 324}}
    MulClickStep:Execute(points, 1)
    Util.WaitTime(1)
    self:AddStep()
end

-- 滑动选择强化石关卡
-- TODO 点击操作判断
function Task:Step3()
    local config = Points[3]
    for i = 1, 3 do
        Util.Swipe(config.swipeFrom, config.swipeTo, 0.8)
        Util.WaitTime(1)
    end

    Util.Click(config.clickPos[1], config.clickPos[2])
    self:AddStep()
end

-- 进入选择辅助队友
function Task:Step4()
    local config = Points[4]
    -- if Util.FindMulColorByTable(config.inPanel) then
    --     Util.Click(config.clickPos[1], config.clickPos[2])
    --     self:MarkOperation()
    -- else
    --     if self:HasOperation() then
    --         self:AddStep()
    --     end
    -- end

    --只点一次，点太快会直接跳过Ready界面，很神奇
    if Util.FindMulColorByTable(config.inPanel) then
        Util.WaitTime(1)
        Util.Click(config.clickPos[1], config.clickPos[2])
        self:AddStep()
    end
end

-- 战斗准备
function Task:Step5()
    local result = BattleReadyStep:Execute()
    if result then
        self:AddStep()
    end
end

function Task:Step6()
    Util.WaitTime(1)
    if BattleAutoStep:Execute() then
        self:AddStep()
    end
end

function Task:Step7()
    if not GameUtil.IsInMazeSelect() then
        return
    end

    log("在迷宫中，准备点击")
    -- 向左上角走
    Util.Click(131, 251)
    -- 等待走的时间
    -- 或者3秒
    Util.WaitTime(3)
    -- 停下自动
    Util.Click(1125, 33)

    -- 打开商店
    for i = 1, 3 do
        Util.Click(817, 327)
        Util.WaitTime(0.3)
    end

    self:AddStep()
end

function Task:Step8()
    Util.WaitTime(1)
    local result = StoreBuyStep:Execute()
    if result then
        self:AddStep()
    end
end

--TODO 增加点击操作判断,判断能不能点击左上角
function Task:Step9()
    Util.Click(72, 31)
    Util.WaitTime(0.5)
    self:AddStep()
end

function Task:Step10()
    if CommonExitStep:Execute() then
        self:Completed()
    end
end

return Task
