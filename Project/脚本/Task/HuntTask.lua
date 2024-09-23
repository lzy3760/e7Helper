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

-- �ַ�
---@class HuntTask:BaseTask
local HuntTask = class("HuntTask", BaseTask)

--[[
    1.�������ս������
    2.�ж��Ƿ����ַ�����,���Hunt���
    3.�ж��ַ�����Ƿ����,�������»�(while ѭ��)
    4.�Ѷ��ж�,ĿǰĬ��ѡ���ַ�13,������밴ť
    5.�ж�ս����ڣ����ս����ť
    6.�ж��Ƿ���ս������,û���Զ�ս������Զ�ս��
    7.�ж��Ƿ���ʤ������,ʶ����ɫ���ǵĻ������Ļ
    8.���ս�����ȷ�ϰ�ť��ť
    9.���TryAgain��ť
    10.��ת��5
]]

-- inState �ж��Ƿ��ڵ�ǰ����  2--����ж�

local Steps = {
    -- ѡ���ַ�Ŀ��
    [2] = {
        inPanel = "1171|152|0D2038,1174|271|01091B,1185|475|0C1F37",
        points = {
            -- ���ַ�
            [1] = {835, 226},
            [2] = {838, 435},
            [3] = {843, 628},
            [4] = {836, 400},
            [5] = {842, 610}
        },
        swipeFrom = {848, 690},
        swipeTo = {836, 68}
    },
    -- ѡ���Ѷ�
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
    BaseTask.initialize(self, "�ַ�")

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
    BattleEnterStep:SetTarget("�ַ�", 3)
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

-- �������ս������
function HuntTask:Step1()
    BattleEnterStep:Execute()
    if BattleEnterStep:IsCompleted() then
        self:AddStep()
    end
end

-- ѡ����սĿ��
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

-- ѡ����ս�Ѷ�
function HuntTask:Step3()
    -- ��0.5���Զ�������������
    Util.WaitTime(0.5)

    local config = Steps[4]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- ս��׼������
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

-- ���ڵ��Զ�ս������
function HuntTask:Step5()
    local result = CloseAutoStep:Execute()
    if result then
        self:AddStep()
    end
end

-- ս�����ж�ʤ������ʧ��
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

-- ʤ�������ת
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
