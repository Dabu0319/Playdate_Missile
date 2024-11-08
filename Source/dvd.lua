-- import "CoreLibs/graphics"
-- import "CoreLibs/object"

-- local gfx <const> = playdate.graphics

-- class("dvd").extends()

-- function dvd:init(xspeed, yspeed)
--     self.label = {
-- 		x = 155,
-- 		y = 110,
-- 		xspeed = xspeed,
-- 		yspeed = yspeed,
-- 		width = 100,
-- 		height = 20
-- 	}
-- end

-- function dvd:swapColors()
-- 	if (gfx.getBackgroundColor() == gfx.kColorWhite) then
-- 		gfx.setBackgroundColor(gfx.kColorBlack)
-- 		gfx.setImageDrawMode("inverted")
-- 	else
-- 		gfx.setBackgroundColor(gfx.kColorWhite)
-- 		gfx.setImageDrawMode("copy")
-- 	end
-- end

-- function dvd:update()
--     local label = self.label;
--     local swap = false
-- 	if (label.x + label.width >= 400 or label.x <= 0) then
--         label.xspeed = -label.xspeed;
-- 		swap = true
--     end
        
--     if (label.y + label.height >= 240 or label.y <= 0) then
--         label.yspeed = -label.yspeed;
-- 		swap = true
-- 	end

-- 	if (swap) then
-- 		self:swapColors()
-- 	end

-- 	label.x += label.xspeed
-- 	label.y += label.yspeed
-- end

-- function dvd:draw()
--     local label = self.label;
--     gfx.drawTextInRect("Template", label.x, label.y, label.width, label.height)
-- end


-- --main
-- import "dvd" -- DEMO
-- local dvd = dvd(1, -1) -- DEMO

-- local gfx <const> = playdate.graphics
-- local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

-- local function loadGame()
-- 	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
-- 	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
-- 	gfx.setFont(font) -- DEMO
-- end

-- local function updateGame()
-- 	dvd:update() -- DEMO
-- end

-- local function drawGame()
-- 	gfx.clear() -- Clears the screen
-- 	dvd:draw() -- DEMO
-- end

-- loadGame()

-- function playdate.update()
-- 	updateGame()
-- 	drawGame()
-- 	playdate.drawFPS(0,0) -- FPS widget
-- end