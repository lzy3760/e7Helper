local Util = {}

-- ??????????
function Util.GetPlayTime()
    return tickCount() / 1000
end

--?????????
function Util.GetInternetValid()
    --todo 
    return false
end

---@class Util
_G.Util = Util
