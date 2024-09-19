local Task = class("TaskMgr.BaseTask")

function Task:initialize()
    self.taskName = nil
    self.isFinish = false
end

function Task:OnEnter()
end

function Task:Update()
end

function Task:Release()
end

return Task