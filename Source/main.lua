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
enemiesSpawned = false



local function spawnEnemy()
    local x = math.random(0, 400) 
    local y = math.random(0, 120) 

    -- insert
    local newEnemy = Enemy(x, y, 1, 1)
    table.insert(enemies, newEnemy)

    --print("Enemy spawned at:", x, y)
end


-- Spawn multiple enemies at once
local function spawnEnemies(count)
    for i = 1, count do
        spawnEnemy()
    end
	enemiesSpawned = true
end



local function startEnemySpawner()
    -- Spawn a new enemy every 2 seconds
    pd.timer.new(2000, function()
        spawnEnemy()
        startEnemySpawner() -- Reschedule the timer
    end)
end

local function initialize()

	--initialize player
	player = Player(200, 230)
	--spawnEnemy()
	--spawnEnemy()

	--startEnemySpawner()


	
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

	if missile == nil and not enemiesSpawned then
        spawnEnemies(3)
    end

end


initialize()
