---@class TaskMgr ��������Task��ִ��
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