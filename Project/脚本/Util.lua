local Util = {}

-- ��ȡ����ʱ��
function Util.GetPlayTime()
    return tickCount() / 1000
end

-- ��ȡ�����Ƿ���Ч,���޵�����������
function Util.GetInternetValid()
    -- todo
    return false
end

function Util.WaitTime(seconds)
    sleep(seconds * 1000)
end

function Util.Swipe(from, to, waitTime)
    waitTime = waitTime or 0
    touchDown(1, from[1], from[2])
    Util.WaitTime(0.05)
    touchMoveEx(1, to[1], to[2], 100)
    touchMoveEx(1, to[1], to[2], 50)
    touchUp(1)
    Util.WaitTime(0.8 + waitTime)
end

---@class Util
_G.Util = Util
