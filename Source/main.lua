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

local function initialize()

	--initialize player
	player = Player(200, 230)
	table.insert(enemies, Enemy(50, 50, 1, 0.2)) 
    table.insert(enemies, Enemy(150, 30, 1, 1))
	
	
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
