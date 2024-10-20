---@class StoreBuyStep 商店购买步骤
local StoreBuyStep = {}

local InStore

-- 确认购买的比对颜色
local InConfirmColor = {"441|505|2F2218,546|505|312318,613|508|FEAD2A,781|502|123018,849|502|102D17", 0.9}

local State = {
    -- 检查商品
    CheckGood = 1,
    -- 点击购买
    ClickBuy = 2,
    -- 确认点击
    ConfirmBuy = 3
}

-- 强化石
local IntensifyStone = {
    [1] = {
        picName = "Stone1.png"
    },
    [2] = {
        picName = "Stone2.png"
    },
    [3] = {
        picName = "Stone3.png"
    }
}

-- 货币
local Res = {
    [1] = {
        picName = "Res1.png"
    },
    [2] = {
        picName = "Res2.png"
    }
}

local SwipeFrom = {755, 572}
local SwipeTo = {755, 214}

-- 商品坐标
local Goods = {
    [1] = {
        -- 范围
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

function StoreBuyStep:SetTarget(buyType, func, storePanel)
    self.buyType = buyType
    self.buyFunc = func
    InStore = storePanel
    self.buyIndex = 1
    self.resType = nil
end

function StoreBuyStep:ResetBuyIndex()
    self.state = State.CheckGood
    self.buyIndex = 1
    self.isSwipe = false
end

function StoreBuyStep:Execute()
    log("商店购买分支" .. tostring(self.state))
    local result = false
    if self.state == State.CheckGood then
        result = self:OnCheck()
    elseif self.state == State.ClickBuy then
        self:OnClickBuy()
    elseif self.state == State.ConfirmBuy then
        self:OnConfirmBuy()
    end

    return result
end

function StoreBuyStep:OnCheck()
    if self.buyIndex > 6 then
        return true
    end

    if self.buyIndex == 5 and self.isSwipe == false then
        print("第5个商品,滑动界面")
        self.isSwipe = true
        Util.Swipe(SwipeFrom, SwipeTo, 0.5)
        Util.WaitTime(1.5)
    end

    print("当前物品" .. tostring(self.buyIndex))
    local canBuy = self:CanBuyInIndex(self.buyIndex)
    if canBuy then
        self.state = State.ClickBuy
    else
        self.buyIndex = self.buyIndex + 1
    end

    return false
end

function StoreBuyStep:OnClickBuy()
    local buyPos = Goods[self.buyIndex].buyPos
    if Util.CompareColorByTable(InStore) then
        log("点击购买物品")
        Util.Click(buyPos[1], buyPos[2])
    else
        self.state = State.ConfirmBuy
    end
end

function StoreBuyStep:OnConfirmBuy()
    if Util.CompareColorByTable(InConfirmColor) then
        Util.Click(722, 505)
    else
        self.state = State.CheckGood
    end
end

function StoreBuyStep:CanBuyInIndex(index)
    if self.buyType == BuyType.IntensifyStone then
        return self:CanBuyStone(index)
    elseif self.buyType == BuyType.Res then
        return self:CanBuyRes(index)
    elseif self.buyType == BuyType.All then
        return self:CanBuyStone(index) or self:CanBuyRes(index)
    end
end

function StoreBuyStep:CanBuyStone(index)
    local config = Goods[index]
    local size = config.size
    for _, stone in pairs(IntensifyStone) do
        local suc, x, y = Util.findPic(size[1], size[2], size[3], size[4], stone.picName)
        if suc then
            print("购买物品是" .. stone.picName)
            print(tostring(x) .. "---" .. tostring(y))
            return true
        end
    end

    print("该物品不是强化石,不购买")
    return false
end

function StoreBuyStep:CanBuyRes(index)
    local config = Goods[index]
    local size = config.size
    for index, stone in pairs(Res) do
        local suc, x, y = Util.findPic(size[1], size[2], size[3], size[4], stone.picName)
        if suc then
            print("购买物品是" .. stone.picName)
            print(tostring(x) .. "---" .. tostring(y))
            self.resType = index
            return true
        end
    end

    print("该物品不是货币,不购买")
    return false
end

return StoreBuyStep
