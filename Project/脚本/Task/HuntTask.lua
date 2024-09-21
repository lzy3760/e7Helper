local BaseTask = require("Task.BaseTask")
-- �ַ�
---@class HuntTask:BaseTask
local HuntTask = class("BaseTask")

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
    BaseTask.initialize(self, "�ַ�")
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

-- Ŀǰֻ�����ַ�����,������ͨ������ģʽ����
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
