--配置区
local Coin = script.Parent
local TweenService = game:GetService("TweenService")
local playtime = 1
--local currentCoinPosition = Coin.Position
--local baseY = Coin.Position.Y
--local floatYaxis = 0.1
--local maxfloatYaxis = 1
--local isMax = false
--主程序
--while true do
	
--	if currentCoinPosition.Y >= baseY + maxfloatYaxis then
--		isMax = true
	
--	elseif currentCoinPosition.Y <= baseY - maxfloatYaxis then
--		isMax = true
--	end
	
--	if isMax == true then
--		floatYaxis = -floatYaxis
--		isMax = false
--	end
	
--	wait(0.03)
	
--	currentCoinPosition = Vector3.new(
--		currentCoinPosition.X,
--		currentCoinPosition.Y + floatYaxis,
--		currentCoinPosition.Z
--	)
		
--	Coin.Position = currentCoinPosition
	
--end

--使用TweenService控制上下浮动更好
local floatTweenInfo = TweenInfo.new(
	playtime,                          -- 时长
	Enum.EasingStyle.Sine,      -- 缓动类型(正弦浮动)
	Enum.EasingDirection.InOut, -- 方向
	-1,                         -- 无限循环(运行次数)
	true                        -- 往返运动（上下浮动）
)

local floatgoal = {Position = Coin.Position + Vector3.new(0, 1, 0)}
local floatTween = TweenService:Create(Coin, floatTweenInfo, floatgoal)
floatTween:Play()

local rorationTweenInfo = TweenInfo.new(
	playtime,                          -- 时长
	Enum.EasingStyle.Linear,    -- 缓动类型(线性)
	Enum.EasingDirection.In,    -- 方向
	-1                          -- 无限循环(运行次数)
	          
)

local rorationgoal = {Orientation = Vector3.new(0, 360, 0)}
local rorationTween = TweenService:Create(Coin, rorationTweenInfo, rorationgoal)
rorationTween:Play()

