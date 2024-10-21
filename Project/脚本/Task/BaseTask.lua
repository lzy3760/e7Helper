---@class BaseTask
local Task = class("TaskMgr.BaseTask")

function Task:initialize(taskType)
    self.taskType = taskType
    self.isFinish = false
    self.isPause = false
    self.curStep = 1
    self.operation = false
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
function Task:Pause(isReduceStep)
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
    self.operation = false
    log(self.taskType .. "�����" .. self.curStep .. "��")
    Util.WaitTime(1)
end

function Task:ReduceStep()
    self.curStep = self.curStep - 1
end

-- ��ת��step
function Task:ChangeStep(step)
    self.curStep = step
    self.operation = false
    log(self.taskType .. "��ת����" .. self.curStep .. "��")
    Util.WaitTime(1)
end

function Task:MarkOperation()
    self.operation = true
end

function Task:HasOperation()
    return self.operation
end

return Task
