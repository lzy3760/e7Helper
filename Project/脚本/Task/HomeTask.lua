local BaseTask = require("Task.BaseTask")
--���ฺ����˵�Home
local HomeTask = class("HomeTask",BaseTask)

function HomeTask:initialize()
    BaseTask.initialize(self,"������")
end

function HomeTask:Enter()
    self:Completed()
end

function HomeTask:Update()

end

return HomeTask