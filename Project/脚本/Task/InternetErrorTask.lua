local BaseTask = require("Task.BaseTask")
local Task = class("InternetTask",BaseTask)

function Task:initialize()
    BaseTask.initialize(self,TaskType.InternetError)
end

function Task:Enter()
    --�����Ȱ�������ߵ�5��ȴ���ȥ
    Util.WaitTime(6)
end

function Task:Update()
end

return BaseTask