import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "missile"
import "player"
import "enemy"

local pd <const> = playdate
local gfx = pd.graphics

player = nil
enemies = {}
missile = nil
missileState = "ready" -- state can be "ready" or "active"

local function spawnEnemy()
    local x = math.random(0, 400) 
    local y = math.random(0, 120) 

    -- insert
    local newEnemy = Enemy(x, y, 1, 1)
    table.insert(enemies, newEnemy)

    --print("Enemy spawned at:", x, y)
end

local function startEnemySpawner()
    -- 使用 pd.timer.new 设置定时器，并在每次触发时重新启动定时器
    pd.timer.new(2000, function()
        spawnEnemy()
        startEnemySpawner() -- 递归调用，生成下一轮敌人
    end)
end

local function initialize()

	--initialize player
	player = Player(200, 230)
	spawnEnemy()
	spawnEnemy()

	startEnemySpawner()


	
end



function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()

	
	-- if player then
	-- 	player:update()
	-- end

	-- if missile then
	-- 	missile:update()
	-- end


	-- for i = #enemies, 1, -1 do
	-- 	local enemy = enemies[i]
	-- 	if not enemy:update() then
	-- 		table.remove(enemies, i)
	-- 	end
	-- end

end


initialize()
