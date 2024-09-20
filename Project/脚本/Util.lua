_G.FindDir = 
{
    --左上到右下查找
    LeftUpToRightDown = 0,
    --中心向四周查找
    Center = 1,
    --右下到左上查找
    RightDownToLeftUp = 2,
    --左下到右上查找
    LeftDownToRightUp = 3,
    --右上到左下查找
    RightUpToLeftDown = 4,
}

local Util = {}

-- 获取Game运行时间
function Util.GetPlayTime()
    return tickCount() / 1000
end

-- 网络是否有效
function Util.GetInternetValid()
    -- todo
    return true
end

function Util.WaitTime(seconds)
    sleep(seconds * 1000)
end

--拖动
function Util.Swipe(from, to, waitTime)
    waitTime = waitTime or 0
    touchDown(1, from[1], from[2])
    Util.WaitTime(0.05)
    touchMoveEx(1, to[1], to[2], 100)
    touchMoveEx(1, to[1], to[2], 50)
    touchUp(1)
    Util.WaitTime(0.8 + waitTime)
end

--多点比色
function Util.cmpColorEx(msg, sim)
    sim = sim or 0.9
    local result = cmpColorEx(msg, sim)
    return result > 0
end

--找图
function Util.findPic(x1,y1,x2,y2,picName,dir)
    if not x1 or not y1 or not x2 or not y2 then
        log("缺少FindPic的坐标")
        return
    end

    if not picName or picName == "" then
        log("缺少FindPic的PicName名称")
        return
    end

    picName = picName..".png"
    ret,x,y = findPic(x1,y1,x2,y2,picName,"000000",0.7,dir)
    return x~= -1 and y~= -1
end

---@class Util
_G.Util = Util

function log(msg)
    if true then
        print(msg)
    end
end

string.split = function(str,param)
    return splitStr(str,param)
end