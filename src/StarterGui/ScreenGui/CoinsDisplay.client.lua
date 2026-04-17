-- 获取玩家和 UI 元素
local player = game.Players.LocalPlayer
local hadCoinsDisplay = script.Parent:WaitForChild("DisplayhadCoin")
local maxCoinsDisplay = script.Parent:WaitForChild("DisplaymaxCoin")
local currentCoinsDisplay = script.Parent:WaitForChild("DisplaycurrentCoins")
local CollectionService = game:GetService("CollectionService")
-- 更新显示的函数
local function updatehadCoinsDisplay(CoinsDisplay, newCoins)
	
	CoinsDisplay.Text = newCoins
end


-- 监听属性变化（当服务器修改 Coins等 属性时自动触发）
player:GetAttributeChangedSignal("Coins"):Connect(function()
	local coins = player:GetAttribute("Coins") or 0
	updatehadCoinsDisplay(hadCoinsDisplay, coins)
end)

player:GetAttributeChangedSignal("currentSceneCoins"):Connect(function()
	local coins = player:GetAttribute("currentSceneCoins") or 0
	updatehadCoinsDisplay(currentCoinsDisplay, coins)
end)

CollectionService:GetInstanceAddedSignal("Coin"):Connect(function()
	local coins = CollectionService:GetTagged("Coin")
	player:SetAttribute("currentSceneCoins", #coins)
	updatehadCoinsDisplay(currentCoinsDisplay, #coins)
end)




-- 初始化显示
local initCoins = player:GetAttribute("Coins") or 0
local initMaxCoins = player:GetAttribute("MaxCoins") or 0
local initcurrentSceneCoins = player:GetAttribute("currentSceneCoins") or 0

updatehadCoinsDisplay(hadCoinsDisplay, initCoins)
updatehadCoinsDisplay(maxCoinsDisplay, initMaxCoins)
updatehadCoinsDisplay(currentCoinsDisplay, initcurrentSceneCoins)
