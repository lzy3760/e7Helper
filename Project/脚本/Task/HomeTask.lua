local BaseTask = require("Task.BaseTask")
--该类负责回退到Home
local HomeTask = class("HomeTask",BaseTask)

function HomeTask:initialize()
    BaseTask.initialize(self,"主界面")
end

function HomeTask:Enter()
    self:Completed()
end

function HomeTask:Update()

end

return HomeTask