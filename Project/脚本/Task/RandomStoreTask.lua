local BaseTask = require("Task.BaseTask")
-- ˢ��ǩ��Task
local Task = class("RandomStoreTask", BaseTask)

function Task:initialize()
    BaseTask.initialize(self, TaskType.RandomStoreTask)
end

return Task
