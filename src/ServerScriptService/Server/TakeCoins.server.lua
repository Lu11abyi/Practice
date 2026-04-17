
local PPS = game:GetService("ProximityPromptService")
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local CollectionService = game:GetService("CollectionService")

local allCoins

local function onPromptTriggered(object, player)
	local newCoin
	local newSceneCoin
	
	
	
	local Coin = object.parent.parent
	if Coin.Name ~= "Coin" then print(object.parent.Name.. "当前所交互对象不是金币") return end
	local character = player.character
	local humanoid = character:FindFirstChild("Humanoid")
	--如果不是玩家进行的交互，则退出
	if not humanoid or not character then return print('触发者不是玩家') end

	print(character.name .. "拾取了金币")
	
	allCoins = CollectionService:GetTagged("Coin")
	
	local currentCoins = player:GetAttribute("Coins") or 0
	
	local currentSceneCoins = #allCoins

	newCoin = currentCoins + 1
	newSceneCoin = currentSceneCoins - 1
	print("当前拥有:"..newCoin .."硬币")
	print("当前场景还有:"..newSceneCoin .."硬币")
	
	player:SetAttribute("Coins", newCoin)
	
	player:SetAttribute("currentSceneCoins", newSceneCoin)
	
	Coin:Destroy()
	
	
	
	print(Coin.Name.."实体成功被删除")
	return
end

PPS.PromptTriggered:Connect(onPromptTriggered)