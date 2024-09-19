---@class TaskMgr 负责所有Task的执行
local TaskMgr = {}

function TaskMgr:Init()
    self.tasks = {}
    self.curTask = nil
end

function TaskMgr:Update()
    
end

function TaskMgr:Release()

end

_G.TaskMgr = TaskMgr