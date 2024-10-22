local BaseTask = require("Task.BaseTask")

---@type BattleEnterStep
local BattleEnterStep = require("Step.BattleEnterStep")
---@type BattleAutoStep
local BattleAutoStep = require("Step.BattleAutoStep")
---@type BattleReadyStep
local BattleReadyStep = require("Step.BattleReadyStep")
---@type CommonBattleStep
local CommonBattleStep = require("Step.CommonBattleStep")
---@type SettlementStep
local SettlementStep = require("Step.SettlementStep")
---@type MulTapStep
local MulTapStep = require("Step.MulTapStep")

local BuyEnergy = false

-- 不买体力退出
local CancelColor = {316, 466, 503, 553, "312318", "45|23|765B2F|91|-2|322418", 0, 0.9}
local CancelColor2 = {17, 10, 65, 56, "FFFFFF", "-18|13|FFFFFF|0|27|FFFFFF", 0, 0.9}
local CancelHome = {196, 622, 341, 699, "FFFFFF", "15|-5|FFFFFF", 0, 0.9}

-- 购买体力
local BuyColor = {501, 469, 736, 553, "133319", "65|18|346628|133|-4|123018", 0, 0.9}

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
    BattleEnterStep:SetTarget("讨伐")
    BattleReadyStep:SetTarget(false, false)
    -- 购买填这个坐标列表,不购买填另一个坐标列表
    MulTapStep:SetPoint(not BuyEnergy and {CancelColor, CancelColor2, CancelHome} or {BuyColor})
end

-- 需要测试下断网续连之后会不会自动进副本
-- 还是会把上一次点击给吞掉
function HuntTask:Pause(isReduceStep)
    BaseTask.Pause(self, isReduceStep)
    if isReduceStep then
        self:ReduceStep()
    end
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

    local config = Steps[3]

    if not Util.CompareColor(config.inPanel) then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- 战斗准备界面
function HuntTask:Step4()
    local result = BattleReadyStep:Execute()
    if result then
        self:AddStep()
    end
end

-- 检测体力
function HuntTask:Step5()
    if GameUtil.IsResEnough(ResType.Energy) then
        print("体力充足")
        self:AddStep()
        MulTapStep:Reset()
    else
        print("体力不足")
        self:ChangeStep(9)
    end
end

-- 局内的自动战斗设置
function HuntTask:Step6()
    local result = BattleAutoStep:Execute()
    if result then
        self:AddStep()
    end
end

-- 战斗中判断胜利或者失败
function HuntTask:Step7()
    local result = CommonBattleStep:Execute()
    if result ~= nil then
        if not result then
            self:Retry()
        else
            self.curHuntCount = self.curHuntCount + 1
            self:RefreshHUD()
            self:AddStep()
        end
    end
end

-- 胜利后的跳转
function HuntTask:Step8()
    local isContinue = self.curHuntCount < self.huntCount
    SettlementStep:SetTarget(isContinue)
    local result = SettlementStep:Execute()
    if result then
        print("进入结果判断")
        if isContinue then
            print("继续讨伐")
            self:Retry()
        else
            Util.WaitTime(1)
            print("返回大厅")
            Util.Click(271, 656)
            self:Completed()
        end
    else
        print("未判断结果,等待讨伐结算")
    end
end

-- 处理体力不够的情况
function HuntTask:Step9()
    -- 步骤走完了
    local result = MulTapStep:Execute()
    if result then
        if not BuyEnergy then
            self:Completed()
        else
            self:Retry()
        end
    end
end

function HuntTask:Retry()
    self:ChangeStep(4)
end

return HuntTask
