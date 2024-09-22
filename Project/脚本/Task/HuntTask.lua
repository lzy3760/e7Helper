local BaseTask = require("Task.BaseTask")
-- 讨伐
---@class HuntTask:BaseTask
local HuntTask = class("HuntTask", BaseTask)

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

local InitSteps = function(self)
    self.Steps = {
        [1] = {
            click = {965, 643},
            func = self.Step1
        },
        [2] = {
            inPanel = "28|32|FFFFFF,525|688|4D3921",
            click = {806, 341},
            func = self.Step2
        },
        [3] = {
            inPanel = "1171|152|0D2038,1174|271|01091B,1185|475|0C1F37",
            points = {
                -- 龙讨伐
                [1] = {835, 226},
                [2] = {838, 435},
                [3] = {843, 628},
                [4] = {836, 400},
                [5] = {842, 610}
            },
            swipeFrom = {848, 690},
            swipeTo = {836, 68},
            func = self.Step3
        },
        [4] = {
            inPanel = "250|668|222322,626|681|765D34,1145|662|17391B",
            -- {"250|668|222322,626|681|765D34,1145|662|17391B",0.9}
            click = {1145, 659},
            func = self.Step4
        },
        [5] = {
            inPanel = "17|665|0D1E3B,120|663|0D1E3B",
            click = {1071, 661},
            func = self.Step5
        },
        [6] = {
            inPanel = "45|157|FFFFFF,143|144|FFFFFF,151|151|FFFFFF,159|144|FFFFFF,1251|34|FFFFFF,1234|33|FFFFFF",
            func = self.Step6
        },
        [7] = {
            sucPanel = "594|238|278FB1,686|238|3F8EAB,640|218|FEFFA5",
            sucClick = {650, 426},
            failPanel = "183|405|3F772E,342|403|417930,182|468|6B5639,338|468|6A5538",
            failClick = {1125, 658},
            func = self.Step7
        },
        [8] = {
            -- {"1009|679|654E2A,1164|680|346728",0.9}
            inPanel = "1009|679|654E2A,1164|680|346728",
            click = {1166, 658},
            func = self.Step8
        },
        [9] = {
            -- {"116|683|795D30,271|681|71552D,1011|664|E3D7C9,1131|680|6D532D",0.9}
            inPanel = "116|683|795D30,271|681|71552D,1011|664|E3D7C9,1131|680|6D532D",
            click = {1120, 662},
            func = self.Step9
        }
    }
end

function HuntTask:initialize()
    BaseTask.initialize(self, "讨伐")
    InitSteps(self)
    ---@type HuntSet
    local huntSet = SettingMgr:GetSet("HuntSet")
    self.huntType = huntSet.huntType
    self.huntCount = huntSet.huntCount
    self.curHuntCount = 0
end

function HuntTask:RefreshHUD()
    local content = tostring(self.curHuntCount) .. "/" .. tostring(self.huntCount)
    showHUD(self.hudId, content, 12, "#FF000000", "#FFFFFFFF", 0, 0, 720, 50, 25, 0, 0, 0, 0, 1) -- 
end

function HuntTask:Enter()
    -- todo create HUD
    self.hudId = createHUD()
    self:RefreshHUD()
end

function HuntTask:Pause()
    BaseTask.Pause(self)
    self:ReduceStep()
end

function HuntTask:Update()
    local step = self.Steps[self.curStep]
    if step then
        step.func(self)
    end
end

function HuntTask:Release()
    self.curStep = nil
    hideHUD(self.hudId)
    -- todo destroy HUD
end

-- 点击进入战斗界面
function HuntTask:Step1()
    local config = self.Steps[1]
    if not self:IsInHome() then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- 点击进入讨伐
function HuntTask:Step2()
    local config = self.Steps[2]
    local inPanel = config.inPanel
    if not Util.CompareColor(inPanel) then
        return
    end

    Util.WaitTime(0.8)
    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- 选择挑战目标
function HuntTask:Step3()
    local config = self.Steps[3]
    local inPanel = config.inPanel
    if not Util.CompareColor(inPanel) then
        return
    end

    if self.huntType > 3 then
        Util.Swipe(config.swipeFrom, config.swipeTo, 0.5)
        Util.WaitTime(1.5)
    end

    local click = config.points[self.huntType]
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- 选择挑战难度
function HuntTask:Step4()
    -- todo
    -- Util.Swipe(nil, nil)

    -- 等2秒自动滑动到最下面
    Util.WaitTime(0.5)

    local config = self.Steps[4]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- 进入战斗
function HuntTask:Step5()
    local config = self.Steps[5]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    if self.curHuntCount >= self.huntCount then
        self:Completed()
        return
    end

    Util.WaitTime(0.8)

    log("连续挑战比色")
    if self:IsContinueBattle() then
        log("连续挑战关闭对号")
        self:SetContinueBattle()
    end

    log("快速战斗比色")
    if not self:IsQuickBattle() then
        log("快速战斗设置")
        self:SetQuickBattle()
    end

    Util.Click(config.click[1], config.click[2])
    self:AddStep()
end

-- 点击进入自动战斗
function HuntTask:Step6()
    local config = self.Steps[6]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    if not self:IsAutoBattle() then
        log("设置自动战斗")
        self:SetAutoBattle()
    end

    self:AddStep()
end

-- 战斗结果判断
function HuntTask:Step7()
    local config = self.Steps[7]

    local hasResult = false

    -- 胜利
    if Util.CompareColor(config.sucPanel) then
        Util.Click(config.sucClick[1], config.sucClick[2])
        self:AddStep()
        hasResult = true
        -- 失败
    elseif Util.CompareColor(config.failPanel) then
        Util.Click(config.failClick[1], config.failClick[2])
        self:ChangeStep(5)
        hasResult = true
    end

    if hasResult then
        self.curHuntCount = self.curHuntCount + 1
        self:RefreshHUD()
    end
end

-- 结算界面
function HuntTask:Step8()
    local config = self.Steps[8]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    Util.WaitTime(0.5)
    Util.Click(config.click[1], config.click[2])
    self:AddStep()
end

-- 重新进行界面
function HuntTask:Step9()
    local config = self.Steps[9]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    Util.Click(config.click[1], config.click[2])
    self:ChangeStep(5)
    Util.WaitTime(1)
end

return HuntTask
