local BaseTask = require("Task.BaseTask")
--讨伐
local HuntTask = class("BaseTask")

--[[
    1.点击进入战斗界面
    2.点击Hunt入口
    3.判断讨伐入口是否存在,不存在下滑(while 循环)
    4.难度判断,目前默认选择讨伐13,点击进入按钮
    5.判断战斗入口，点击战斗按钮
    6.判断是否处于战斗界面,没有自动战斗则打开自动战斗
    7.判断是否在胜利界面,识别颜色，是的话点击屏幕
    8.点击战斗后的确认按钮按钮
    9.点击TryAgain按钮
    10.跳转到5
]]

function HuntTask:initialize()
    BaseTask.initialize(self,"讨伐")

end

return HuntTask