local BaseTask = require("Task.BaseTask")
---@class OneMazeTask:BaseTask һ���Թ�
local OneMazeTask = class("OneMazeTask",BaseTask)

local Type = 
{
    --��ͨ
    Normal = 1,
    --������
    Portal = 2,
}

local Configs = 
{
    --��ͨ���������,��鵽W,���w
    {Type = Type.Normal,Dir = "W"},
    --�д�����ʱ������,���������鵽S�����ȵ��������
    {Type = Type.Portal,Dir = "S"}
}

return OneMazeTask