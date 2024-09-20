local BaseTask = require("Task.BaseTask")
local Task = class("InternetTask",BaseTask)

function Task:initialize()
    BaseTask.initialize(self,TaskType.InternetError)
end

function Task:Enter()
    --这里先把网络短线的5秒等待过去
    Util.WaitTime(6)
end

function Task:Update()
end

return BaseTask