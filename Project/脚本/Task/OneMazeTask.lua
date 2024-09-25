local BaseTask = require("Task.BaseTask")
---@class OneMazeTask:BaseTask 一键迷宫
local OneMazeTask = class("OneMazeTask",BaseTask)

local Type = 
{
    --普通
    Normal = 1,
    --传送门
    Portal = 2,
}

local Configs = 
{
    --普通方向的引导,检查到W,点击w
    {Type = Type.Normal,Dir = "W"},
    --有传送门时的引导,这种情况检查到S后优先点击传送门
    {Type = Type.Portal,Dir = "S"}
}

return OneMazeTask