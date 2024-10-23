---@class BaseStep
local BaseStep = class("BaseStep")

function BaseStep:ResetOperation()
    self.operation = false
end

function BaseStep:MakeOperation()
    self.operation = true
end

function BaseStep:HasOperation()
    return self.operation and self.operation == true
end

return BaseStep