local remove = table.remove
local insert = table.insert
local BaseTask = require("Task.BaseTask")

---@class TaskMgr 负责所有Task的执行
local TaskMgr = {}

function TaskMgr:Init()
    self.tasks = {}
    self.curTask = nil
    self.pause = true
end

function TaskMgr:Update()
    if self.pause then
        return
    end

    if not self.curTask then
        return
    end

    self.curTask:Update()
    if self.curTask.isFinish then
        self.curTask:Release()
        remove(self.tasks, 1)
        self.curTask = self.tasks[1]
        self.curTask:OnEnter()
    end
end

function TaskMgr:Release()
end

function TaskMgr:GetTaskClass(taskName)

end

function TaskMgr:AddTask(taskName)
    local taskClass = self:GetTaskClass(taskName)
    local task = taskClass:new()
    insert(self.tasks, task)
end

function TaskMgr:ClearTask()
end

function TaskMgr:Start()
    self.pause = false
    self.curTask = self.tasks[1]
    self.curTask:OnEnter()
end

_G.TaskMgr = TaskMgr
