local Util = {}

-- ��ȡ����ʱ��
function Util.GetPlayTime()
    return tickCount() / 1000
end

--��ȡ�Ƿ����
function Util.GetInternetValid()
    --todo 
    return false
end

---@class Util
_G.Util = Util
