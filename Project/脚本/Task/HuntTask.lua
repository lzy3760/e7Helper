local BaseTask = require("Task.BaseTask")

---@type BattleEnterStep
local BattleEnterStep = require("Step.BattleEnterStep")
---@type CloseAutoBattleStep
local CloseAutoStep = require("Step.CloseAutoStep")
---@type BattleReadyStep
local BattleReadyStep = require("Step.BattleReadyStep")
---@type CommonBattleStep
local CommonBattleStep = require("Step.CommonBattleStep")
---@type SettlementStep
local SettlementStep = require("Step.SettlementStep")

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

local Steps = {
    -- 选择讨伐目标
    [2] = {
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
        swipeTo = {836, 68}
    },
    -- 选择难度
    [3] = {
        inPanel = "250|668|222322,626|681|765D34,1145|662|17391B",
        -- {"250|668|222322,626|681|765D34,1145|662|17391B",0.9}
        click = {1145, 659}
    },
    [5] = {
        inPanel = "17|665|0D1E3B,120|663|0D1E3B",
        click = {1071, 661}
    }
}

function HuntTask:initialize()
    BaseTask.initialize(self, "讨伐")

    ---@type HuntSet
    local huntSet = SettingMgr:GetSet("HuntSet")
    self.huntType = huntSet.huntType
    self.huntCount = huntSet.huntCount
    self.curHuntCount = 0
end

function HuntTask:RefreshHUD()
    local content = tostring(self.curHuntCount) .. "/" .. tostring(self.huntCount)
    showHUD(self.hudId, content, 12, "#FF000000", "#FFFFFFFF", 0, 0, 720, 50, 25, 0, 0, 0, 0, 1)
end

function HuntTask:Enter()
    -- todo create HUD
    self.hudId = createHUD()
    self:RefreshHUD()
    BattleEnterStep:SetTarget("讨伐", 3)
    BattleReadyStep:SetTarget(false, false)
    SettlementStep:SetTarget(true)
end

function HuntTask:Pause()
    BaseTask.Pause(self)
    self:ReduceStep()
end

function HuntTask:Update()
    Util.Invoke(self, "Step" .. self.curStep)
end

function HuntTask:Release()
    self.curStep = nil
    hideHUD(self.hudId)
    -- todo destroy HUD
end

-- 点击进入战斗界面
function HuntTask:Step1()
    BattleEnterStep:Execute()
    if BattleEnterStep:IsCompleted() then
        self:AddStep()
    end
end

-- 选择挑战目标
function HuntTask:Step2()
    local config = Steps[2]
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
function HuntTask:Step3()
    -- 等0.5秒自动滑动到最下面
    Util.WaitTime(0.5)

    local config = Steps[4]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- 战斗准备界面
function HuntTask:Step4()
    if not BattleReadyStep:IsInPanel() then
        return
    end

    if self.curHuntCount >= self.huntCount then
        self:Completed()
        return
    end

    local result = BattleReadyStep:Execute()
    if result then
        self:AddStep()
    end
end

-- 局内的自动战斗设置
function HuntTask:Step5()
    local result = CloseAutoStep:Execute()
    if result then
        self:AddStep()
    end
end

-- 战斗中判断胜利或者失败
function HuntTask:Step6()
    local result = CommonBattleStep:Execute()
    if result ~= nil then
        self.curHuntCount = self.curHuntCount + 1
        self:RefreshHUD()

        if not result then
            self:Retry()
        else
            self:AddStep()
        end
    end
end

-- 胜利后的跳转
function HuntTask:Step7()
    local result = SettlementStep:Execute()
    if result then
        self:Retry()
    end
end

function HuntTask:Retry()
    self:ChangeStep(4)
end

return HuntTask
