local BaseTask = require("Task.BaseTask")
--���ฺ����˵�Home
local HomeTask = class("HomeTask",BaseTask)

function HomeTask:initialize()
    BaseTask.initialize(self,TaskType.HomeTask)
end

function HomeTask:Enter()

end

function HomeTask:Update()

end

return HomeTask