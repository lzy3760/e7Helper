local BaseTask = require("Task.BaseTask")
-- 讨伐
---@class HuntTask:BaseTask
local HuntTask = class("BaseTask")

--[[
    1.点击进入战斗界面
    2.判断是否处于讨伐界面,点击Hunt入口
    3.判断讨伐入口是否存在,不存在下滑(while 循环)
    4.难度判断,目前默认选择讨伐13,点击进入按钮
    5.判断战斗入口，点击战斗按钮
    6.判断是否处于战斗界面,没有自动战斗则打开自动战斗
    7.判断是否在胜利界面,识别颜色，是的话点击屏幕
    8.点击战斗后的确认按钮按钮
    9.点击TryAgain按钮
    10.跳转到5
]]
-- inState 判断是否在当前区域  2--点击判定
local Steps = {
    [1] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step1
    },
    [2] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step2
    },
    [3] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step3
    },
    [4] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step4
    },
    [5] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step5
    },
    [6] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step6
    },
    [7] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step7
    },
    [8] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step8
    },
    [9] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step9
    },
    [10] = {
        inPanel = "",
        click = "",
        func = HuntTask.Step10
    }
}

function HuntTask:initialize()
    BaseTask.initialize(self, "讨伐")
end

function HuntTask:Enter()
    -- todo create HUD
end

function HuntTask:Update()
    local step = Steps[self.curStep]
    if step then
        step.func(self)
    end
end

function HuntTask:Release()
    self.curStep = nil
    -- todo destroy HUD
end

function HuntTask:Step1()
    local config = Steps[1]
    if not self:IsInHome() then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

function HuntTask:Step2()
    local config = Steps[2]
    local inPanel = config.inPanel
    if not Util.CompareColor(inPanel) then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- 目前只用龙讨伐测试,后期跑通用其他模式测试
function HuntTask:Step3()
    local config = Steps[3]
    local inPanel = config.inPanel
    if not Util.CompareColor(inPanel) then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

function HuntTask:Step4()
    -- todo
    Util.Swipe(nil, nil)
    Util.WaitTime(1)

    local config = Steps[4]
    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

function HuntTask:Step5()
end

function HuntTask:Step6()
end

function HuntTask:Step7()
end

function HuntTask:Step8()
end

function HuntTask:Step9()
end

function HuntTask:Step10()
end

return HuntTask
