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

-- �Ƿ���������
function Task:IsInHome()
end

-- �Ƿ����Զ�ս��
function Task:IsAutoBattle()

end

-- �����Զ�ս��
function Task:SetAutoBattle()
    -- tap
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
end

--��ת��step
function Task:ChangeStep(step)
    self.curStep = step
end

return Task
