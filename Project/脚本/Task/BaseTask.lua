---@class BaseTask
local Task = class("TaskMgr.BaseTask")

function Task:initialize(taskType)
    self.taskType = taskType
    self.isFinish = false
    self.isPause = false
    self.curStep = 1
end

function Task:Enter()
end

function Task:Update()

end

function Task:Release()
end

function Task:Completed()
    self.isFinish = true
end

-- ��ͣ��Task
function Task:Pause()
    self.isPause = true
end

-- ��Task�Ƿ���ͣ
function Task:IsPause()
    return self.isPause
end

-- ����Task
function Task:Resume()
    self.isPause = false
end

-- �Ƿ��ڸ�����,���ж�ֻ�ж��Ƿ�����ͨ�ĸ���
-- ��������ĸ������ܲ�ɫ������
function Task:IsInBattle()

end

local HomeColor = "55|632|FFFFFF,145|640|EBEBEB,232|650|C3C3C3,334|635|FFFFFF,421|634|FFFFFF"
-- �Ƿ���������
function Task:IsInHome()
    return Util.CompareColor(HomeColor)
end

local QuickBattle = "1214|641|0B0201,1234|662|201D1C,1250|679|090200"

-- �Ƿ�رտ�����ս
function Task:IsQuickBattle()
    return Util.CompareColor(QuickBattle)
    -- todo �޸�ΪfindColor
end

-- ���ÿ�����ս
function Task:SetQuickBattle()
    Util.Click(1233, 664)
end

local ContinueBattle = "5BBB02"
-- ������ս
function Task:IsContinueBattle()
    -- return Util.CompareColor(ContinueBattle)
    local suc, x, y = Util.FindColor(574, 540, 605, 565, ContinueBattle, FindDir.LeftUpToRightDown)
    return suc
end

-- ����������ս
function Task:SetContinueBattle()
    Util.Click(582, 559)
end

local Battle = {"1002|698|D6F7FF,1007|693|D6F7FF", "1080|698|D6F7FF,1084|694|D6F7FF", "1158|698|D6F7FF,1163|693|D6F7FF",
                "1237|697|D6F7FF,1241|694|D6F7FF"}

-- �Ƿ����Զ�ս��
function Task:IsAutoBattle()
    for _, color in pairs(Battle) do
        local suc = Util.CompareColor(color, 0.5)
        if suc then
            log("�����Զ�ս��")
            return true
        else
            log("�������Զ�ս��")
        end
    end
    return false
end

-- �����Զ�ս��
function Task:SetAutoBattle()
    Util.Click(1125, 34)
end

-- һֱ���ֱ������ʲô����
---@param internal number ������
---@param func function �ص�
function Task:ClickUtil(x, y, internal, checkFunc, func)
    if self.loopClick then
        logError("�ظ������⵽�˳�ͻ!!")
    end

    self.loopClick = true
    self.clickInternal = internal
end

function Task:AddStep()
    self.curStep = self.curStep + 1
    log("�����" .. self.curStep .. "��")
    Util.WaitTime(1)
end

function Task:ReduceStep()
    self.curStep = self.curStep - 1
end

-- ��ת��step
function Task:ChangeStep(step)
    self.curStep = step
    log("��ת����" .. self.curStep .. "��")
    Util.WaitTime(1)
end

return Task
