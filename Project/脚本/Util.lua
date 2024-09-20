_G.FindDir = 
{
    --���ϵ����²���
    LeftUpToRightDown = 0,
    --���������ܲ���
    Center = 1,
    --���µ����ϲ���
    RightDownToLeftUp = 2,
    --���µ����ϲ���
    LeftDownToRightUp = 3,
    --���ϵ����²���
    RightUpToLeftDown = 4,
}

local Util = {}

-- ��ȡGame����ʱ��
function Util.GetPlayTime()
    return tickCount() / 1000
end

-- �����Ƿ���Ч
function Util.GetInternetValid()
    -- todo
    return true
end

function Util.WaitTime(seconds)
    sleep(seconds * 1000)
end

--�϶�
function Util.Swipe(from, to, waitTime)
    waitTime = waitTime or 0
    touchDown(1, from[1], from[2])
    Util.WaitTime(0.05)
    touchMoveEx(1, to[1], to[2], 100)
    touchMoveEx(1, to[1], to[2], 50)
    touchUp(1)
    Util.WaitTime(0.8 + waitTime)
end

--����ɫ
function Util.cmpColorEx(msg, sim)
    sim = sim or 0.9
    local result = cmpColorEx(msg, sim)
    return result > 0
end

--��ͼ
function Util.findPic(x1,y1,x2,y2,picName,dir)
    if not x1 or not y1 or not x2 or not y2 then
        log("ȱ��FindPic������")
        return
    end

    if not picName or picName == "" then
        log("ȱ��FindPic��PicName����")
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