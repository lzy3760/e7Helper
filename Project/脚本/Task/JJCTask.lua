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
        inNPCBattle = {"1077|211|FFFFFF,1092|209|FDFDFD,1106|210|FCFCFC,1170|209|01091C", 0.9}
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
    local config3 = Points[3]
    if not Util.CompareColorByTable(config3.inPanel) then
        return
    end

    if not Util.CompareColorByTable(config3.inNPCBattle) then
        Util.Click(1159, 212)
        return
    end

    --这里不能这么搞，得判断下有没有绿色的按钮可以点击。没有的话就选择NPC,有的话就点击挑战

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
    self:ChangeStep(8)
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

-- 判断是否胜利
function Task:Step6()
    local config = Points[6]
    if Util.CompareColorByTable(config.inPanel) then
        Util.WaitTime(1)
        self:AddStep()
    end
end

-- 点击胜利后的确定按钮
function Task:Step7()
    local config = Points[6]
    if Util.CompareColorByTable(config.inPanel) then
        Util.Click(1172, 659)
        self:MarkOperation()
        log("点击确定了")
    else
        if self:HasOperation() then
            self:ChangeStep(3)
            Util.WaitTime(2)
        end
    end
end

-- 判断货币是否足够
function Task:Step8()
    Util.WaitTime(0.2)
    local config = Points[7]

    -- 没有弹出购买界面
    if not Util.CompareColorByTable(config.inPanel) then
        if self.clickCancel then
            self:Completed()
            self.clickCancel = nil
        elseif self.clickBuy then
            self:ChangeStep(4)
            self.clickBuy = nil
        else
            self:ChangeStep(5)
        end
        return
    end

    -- 货币不够
    if Util.CompareColorByTable(config.isNotEnough) then
        Util.Click(532, 510)
        self.clickCancel = true
        --点击购买货币
    else
        Util.Click(733, 512)
        self.clickBuy = true
    end
end

return Task
