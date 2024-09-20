local Task = class("TaskMgr.BaseTask")

function Task:initialize(taskType)
    self.taskType = taskType
    self.isFinish = false
    self.isPause = false
end

function Task:Enter()
end

function Task:Update()
end

function Task:Release()
end

function Task:Pause()
    self.isPause = true
end

function Task:IsPause()
    return self.isPause
end

function Task:Resume()
    self.isPause = false
end

return Task