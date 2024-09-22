local BaseTask = require("Task.BaseTask")
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
                -- ���ַ�
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
    BaseTask.initialize(self, "�ַ�")
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

-- �������ս������
function HuntTask:Step1()
    local config = self.Steps[1]
    if not self:IsInHome() then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- ��������ַ�
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

-- ѡ����սĿ��
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

-- ѡ����ս�Ѷ�
function HuntTask:Step4()
    -- todo
    -- Util.Swipe(nil, nil)

    -- ��2���Զ�������������
    Util.WaitTime(0.5)

    local config = self.Steps[4]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    local click = config.click
    Util.Click(click[1], click[2])
    self:AddStep()
end

-- ����ս��
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

    log("������ս��ɫ")
    if self:IsContinueBattle() then
        log("������ս�رնԺ�")
        self:SetContinueBattle()
    end

    log("����ս����ɫ")
    if not self:IsQuickBattle() then
        log("����ս������")
        self:SetQuickBattle()
    end

    Util.Click(config.click[1], config.click[2])
    self:AddStep()
end

-- ��������Զ�ս��
function HuntTask:Step6()
    local config = self.Steps[6]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    if not self:IsAutoBattle() then
        log("�����Զ�ս��")
        self:SetAutoBattle()
    end

    self:AddStep()
end

-- ս������ж�
function HuntTask:Step7()
    local config = self.Steps[7]

    local hasResult = false

    -- ʤ��
    if Util.CompareColor(config.sucPanel) then
        Util.Click(config.sucClick[1], config.sucClick[2])
        self:AddStep()
        hasResult = true
        -- ʧ��
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

-- �������
function HuntTask:Step8()
    local config = self.Steps[8]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    Util.WaitTime(0.5)
    Util.Click(config.click[1], config.click[2])
    self:AddStep()
end

-- ���½��н���
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
