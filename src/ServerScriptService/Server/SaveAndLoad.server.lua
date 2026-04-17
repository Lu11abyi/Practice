
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
-- 创建数据存储
local hadCoinsDataStore = DataStoreService:GetDataStore("PlayerhadCoins")

--保存玩家数据
local function saveCoins(player)
	local userID = player.UserId
	local coins = player:GetAttribute("Coins")

	-- 使用 pcall 安全地保存数据
	local success, err = pcall(function()
		hadCoinsDataStore:SetAsync(userID, coins)
	end)
	

	if success then
		print(player.Name .. " 数据保存成功: " .. coins .. " 硬币")
	else
		warn(player.Name .. " 数据保存失败: " .. err)
	end
end

--加载玩家数据
local function loadCoins(player)
	print("尝试加载"..player.name.."的数据")
	local userID = player.UserId

	-- 使用 pcall 安全地读取数据
	local success, data = pcall(function()
		--根据userID来获取数据
		return hadCoinsDataStore:GetAsync(userID)
	end)
	

	if success then
		if data then
			-- 有存档，恢复数据
			player:SetAttribute("Coins", data)
			print(player.Name .. " 加载存档成功, 当前拥有: " .. data .. " 硬币")
		else
			-- 没有存档，初始化为 0
			player:SetAttribute("Coins", 0)
			print(player.Name .. " 是新玩家，初始化硬币为 0")
		end
	else
		-- 读取失败，默认初始化为 0
		player:SetAttribute("Coins", 0)
		warn(player.Name .. " 加载存档失败")
	end
end

-- 初始化函数
local function initDisplay(player)
	player:SetAttribute("Coins", 0)
	player:SetAttribute("MaxCoins", 10)
	player:SetAttribute("currentSceneCoins", 0)
end


-- 玩家加入时先初始化然后读档
local function onPlayerAdded(player)

	initDisplay(player)

	-- 加载存档
	loadCoins(player)
end

-- 玩家离开时保存
local function onPlayerRemoving(player)
	local userID = player.UserId
	local coins = player:GetAttribute("Coins")
	local success, err = pcall(function()
		hadCoinsDataStore:SetAsync(userID, coins)
	end)
	
	print(player.name..'玩家离开')
	
	print(coins)
	print(success)

	if success then
		print(player.Name .. " 数据保存成功: " .. coins .. " 硬币")
	else
		warn(player.Name .. " 数据保存失败: " .. err)
	end
end

-- 新生成玩家时对该玩家进行初始化和读档
Players.PlayerAdded:Connect(onPlayerAdded)
-- 玩家离开时对该玩家存档
game:BindToClose(function()
	for _, player in pairs(Players:GetPlayers()) do
		saveCoins(player)
	end
	task.wait(0.5)
end)
