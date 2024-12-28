import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "missile"
import "player"
import "enemy"
import "sound_manager"

local pd <const> = playdate
local gfx = pd.graphics


missileState = "ready" -- state can be "ready" or "active"
gameState = "playing" -- state can be "playing" or "gameover"

player = nil
enemies = {}
missile = nil
missileTrails = {}
missileCount = 5

enemiesSpawned = false

score = 0 



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
    for _ = 1, count do
        spawnEnemy()
    end
	enemiesSpawned = true
end


local function drawMissiles()
	if not player then return end
	local startX, startY = player.x + 20, player.y + 5
    local spacing = 15 

    
    for i = 1, missileCount do
        gfx.setColor(gfx.kColorBlack)
        gfx.fillCircleAtPoint(startX + (i - 1) * spacing, startY, 5)
    end
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


	--startEnemySpawner()
	spawnEnemies(3)

	if SoundManager then
        SoundManager.stopBGM()
        SoundManager.init()
        SoundManager.resetBGM()
    end
end

local function restartGame()

	SoundManager.stopBGM()
	
	--player = Player(200, 230)
	missile = nil
	missileState = "ready"
	enemies = {}
	score = 0
	missileCount = 5
	gameState = "playing"

	-- for i = #enemies, 1, -1 do
    --     local enemy = enemies[i]
    --     enemy:remove()
    --     table.remove(enemies, i)
    -- end

	for _, enemy in ipairs(enemies) do
        enemy:remove()
    end
    enemies = {}

	-- local allSprites = gfx.sprite.getAllSprites()
    -- for _, sprite in ipairs(allSprites) do
    --     if sprite.type == "enemy" then
    --         sprite:remove()
    --     end
    -- end



	initialize()
end

initialize()



function pd.update()

	gfx.clear()


	
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

	if gameState == "playing" then

		gfx.sprite.update()
		pd.timer.updateTimers()

		--trail
		for i, pos in ipairs(missileTrails) do
			local alpha = 1 - (i / #missileTrails) 
			gfx.setColor(gfx.kColorBlack)
			gfx.setDitherPattern(alpha)
			gfx.fillCircleAtPoint(pos.x, pos.y, 2)
		end

		--draw score
		local screenWidth = 400
		local scoreText = "Score: " .. score
		local scoreWidth = gfx.getTextSize(scoreText)
		local scoreX = (screenWidth - scoreWidth) / 2
		gfx.drawText(scoreText, scoreX, 10) 


		drawMissiles()

        if missile == nil and not enemiesSpawned then
            spawnEnemies(3)
        end




	elseif gameState == "gameover" then
		gfx.clear()
	
		local screenWidth = 400 
		local gameOverText = "Game Over"
		local scoreText = "Score: " .. score
		local restartText = "Press A to Restart"
	
		
		local gameOverWidth = gfx.getTextSize(gameOverText)
		local scoreWidth = gfx.getTextSize(scoreText)
		local restartWidth = gfx.getTextSize(restartText)
	
		
		local gameOverX = (screenWidth - gameOverWidth) / 2
		local scoreX = (screenWidth - scoreWidth) / 2
		local restartX = (screenWidth - restartWidth) / 2
	
		
		gfx.drawText(gameOverText, gameOverX, 80)
		gfx.drawText(scoreText, scoreX, 110)
		gfx.drawText(restartText, restartX, 140)
	
		
		if pd.buttonJustPressed(pd.kButtonA) then
			restartGame()
		end
	end

	-- print("Missile state:", missileState)
	-- print(missile)

end


