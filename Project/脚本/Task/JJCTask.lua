local BaseTask = require("Task.BaseTask")
---@class JJCTask:BaseTask
---竞技场
local Task = class("JJCTask", BaseTask)

---@type MulClickStep
local MulClickStep = require("Step.MulClickStep")
---@type BattleAutoStep
local AutoBattleStep = require("Step.BattleAutoStep")

local Points = {
    [1] = {
        clickPos = {862, 646}
    },
    [2] = {
        inPanel = {"301|143|FFFFFF,563|138|FFFFFF,840|128|FFFFFF", 0.9},
        clickPos = {346, 354}
    },
    [3] = {
        inPanel = {"221|537|152743,218|603|2E2017,217|667|2F2117", 0.9},
        inNPCBattle = {"1206|185|01091C,1208|233|01091C", 0.9}
    },
    [4] = {
        inPanel = {"859|659|18391B,968|657|112E17", 0.9}
    },
    [5] = {
        inPanel = {"491|29|81C222,804|28|81C222", 0.9}
    },
    [6] = {
        inPanel = {"486|221|FFED84,523|224|FFEC84,540|222|FFEB84,630|196|FFEB84,660|224|FFEB84", 0.9}
    },
    [7] = {
        inPanel = {"571|507|312318,674|511|133319", 0.9},
        isNotEnough = {"435|331|000000,579|328|000000", 0.9}
    }
}

function Task:initialize()
    BaseTask.initialize(self, "JJC")
end

function Task:Enter()
end

function Task:Update()
    Util.Invoke(self, "Step" .. self.curStep)
end

function Task:Step1()
    local config = Points[1]
    if GameUtil.IsInHome() then
        Util.Click(config.clickPos[1], config.clickPos[2])
    else
        self:AddStep()
    end
end

function Task:Step2()
    local config = Points[2]
    if not Util.CompareColorByTable(config.inPanel) then
        return
    end

    Util.Click(config.clickPos[1], config.clickPos[2])
    self:AddStep()
end

-- 选择NPC并且点击进入战斗
function Task:Step3()
    local config = Points[3]
    if not Util.CompareColorByTable(config.inPanel) then
        return
    end

    if not Util.CompareColorByTable(config.inNPCBattle) then
        Util.Click(1159, 212)
        Util.WaitTime(0.5)
    end

    local clickPoints = {{558, 220}, {646, 656}}
    MulClickStep:Execute(clickPoints, 0.5)
    self:AddStep()
end

-- 点击进入战斗
function Task:Step4()
    local config = Points[4]
    if not Util.CompareColorByTable(config.inPanel) then
        return
    end

    Util.Click(874, 657)
    self:ChangeStep(7)
end

-- 判断在战斗中打开自动战斗
function Task:Step5()
    local config = Points[5]
    if not Util.CompareColorByTable(config.inPanel) then
        return
    end

    if AutoBattleStep:Execute() then
        self:AddStep()
    end
end

-- 点击胜利后的确定按钮
function Task:Step6()
    local config = Points[6]
    if Util.CompareColorByTable(config.inPanel) then
        Util.WaitTime(0.5)
        for i = 1, 3 do
            Util.Click(1172, 659)
            Util.WaitTime(0.2)
        end

        self:ChangeStep(3)
        Util.WaitTime(3)
    end
end

-- 判断货币是否足够
function Task:Step7()
    Util.WaitTime(0.2)
    local config = Points[7]
    if not Util.CompareColorByTable(config.inPanel) then
        self:ChangeStep(5)
    else
        if Util.CompareColorByTable(config.isNotEnough) then
            -- 货币不够
            Util.Click(532, 510)
            self:Completed()
            -- 友情书签购买
        else
            Util.Click(733, 512)
            self:ChangeStep(5)
        end
    end
end

return Task
