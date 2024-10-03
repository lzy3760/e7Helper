---@class StoreBuyStep �̵깺����
local StoreBuyStep = {}

---@type MulClickStep
local MulClickStep = require("Step.MulClickStep")

-- ǿ��ʯ
local IntensifyStone = {
    [1] = {
        -- firstColor = "CFBE9F",
        -- offsetColor = "16|19|504E26"
        -- offsetColor = "-6|20|DACDB3|-14|27|CEBEA0"
        picName = "Stone1.png"
    },
    [2] = {
        -- firstColor = "344342",
        -- offsetColor = "13|14|7C3E5E"
        picName = "Stone2.png"
    }

    -- {553,594,650,697,"FFF7D8","-6|20|DACDB3|-14|27|CEBEA0",0,0.9}
}

local SwipeFrom = {755, 572}
local SwipeTo = {755, 214}

-- ��Ʒ����
local Goods = {
    [1] = {
        -- ��Χ
        size = {557, 94, 647, 188},
        buyPos = {1162, 166}
    },
    [2] = {
        size = {554, 239, 648, 335},
        buyPos = {1162, 308}
    },
    [3] = {
        size = {551, 380, 649, 477},
        buyPos = {1162, 454}
    },
    [4] = {
        size = {548, 514, 657, 629},
        buyPos = {1162, 602}
    },
    [5] = {
        size = {551, 444, 653, 563},
        buyPos = {1162, 527}
    },
    [6] = {
        size = {554, 600, 648, 695},
        buyPos = {1162, 673}
    }
}

function StoreBuyStep:SetTarget(buyType)
    self.buyType = buyType
    self.buyIndex = 1
end

function StoreBuyStep:Execute()
    if self.buyIndex == 5 then
        print("��5����Ʒ,��������")
        Util.Swipe(SwipeFrom, SwipeTo, 0.5)
        Util.WaitTime(1.5)
    end

    print("��ǰ��Ʒ" .. tostring(self.buyIndex))
    local canBuy = self:CanBuyInIndex(self.buyIndex)
    if canBuy then
        local buyPos = Goods[self.buyIndex].buyPos
        MulClickStep:Execute({buyPos, {722, 505}}, 1)
        --MulClickStep:Execute({buyPos, {496, 505}}, 1)
        self.buyIndex = self.buyIndex + 1
    else
        print("����Ʒ����ǿ��ʯ,������")
        self.buyIndex = self.buyIndex + 1
    end

    if self.buyIndex > 6 then
        return true
    end

    Util.WaitTime(1)
end

function StoreBuyStep:CanBuyInIndex(index)
    if self.buyType == BuyType.IntensifyStone then
        return self:CanBuyStone(index)
    elseif self.buyType == BuyType.Res then
        return self:CanBuyRes(index)
    end
end

function StoreBuyStep:CanBuyStone(index)
    local config = Goods[index]
    local size = config.size
    for _, stone in pairs(IntensifyStone) do
        local suc, x, y = Util.findPic(size[1], size[2], size[3], size[4], stone.picName)
        if suc then
            print(tostring(x) .. "---" .. tostring(y))
            return true
        end
    end

    return false
end

function StoreBuyStep:CanBuyRes()

end

return StoreBuyStep
