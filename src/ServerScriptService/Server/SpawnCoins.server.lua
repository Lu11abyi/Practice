local baseCoin = workspace:FindFirstChild("Coin")
local SpawnArea = workspace:FindFirstChild("SpawnCoinArea")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local spawnedCoins = {}
retry = 0
local allCoins = CollectionService:GetTagged("Coin")
--计算随机生成的位置

local function getRandomPosition(SpawnArea)
	local minDistance = 5
	local maxAttempts = 10

	for attempt = 1, maxAttempts do
		local size = SpawnArea.Size
		local position = SpawnArea.Position

		local randomX = math.random(-size.X / 2 * 100, size.X / 2 * 100) / 100
		local randomZ = math.random(-size.Z / 2 * 100, size.Z / 2 * 100) / 100

		-- Y 轴：放在区域顶部表面（让金币浮空）
		

		local randomPosition = Vector3.new(
			position.X + randomX,
			3.2,  
			position.Z + randomZ
		)

		-- 检查重叠
		local allCoins = CollectionService:GetTagged("Coin")
		local isOverlapping = false

		for _, coin in pairs(allCoins) do
			if (randomPosition - coin.Position).Magnitude < minDistance then
				isOverlapping = true
				break
			end
		end

		if not isOverlapping then
			return randomPosition  -- 找到合适位置
		end
	end

	-- 所有尝试都失败
	return nil
end

--生成金币
local function spawnCoin()
	
	local newCoin = baseCoin:Clone()
	newCoin.Position = getRandomPosition(SpawnArea)
	newCoin.Parent = workspace
	
	CollectionService:AddTag(newCoin, "Coin")
	
	
end

--金币生成器
local function spawnCoinsManager()
	local stop = false
	while true do
		wait(1)
		local allCoins = CollectionService:GetTagged("Coin")
		if #allCoins < 2 and not stop then
			spawnCoin()
			
		
		elseif #allCoins < 10 and not stop then
			wait(math.random(2, 3))
			spawnCoin()
			
			print('有新的金币生成了')
			
		elseif #allCoins >= 10 then
			stop = true
			print('当前金币数量已达到最大值，不生成金币')
		elseif #allCoins < 10 and stop then
			stop = false
		end
		
	end	
	
end

spawnCoinsManager()