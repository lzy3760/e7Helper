local BaseTask = require("Task.BaseTask")
-- Ë¢ÊéÇ©µÄTask
local Task = class("RandomStoreTask", BaseTask)

function Task:initialize()
    BaseTask.initialize(self, TaskType.RandomStoreTask)
end

return Task
