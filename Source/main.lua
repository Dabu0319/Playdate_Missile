import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "knight"


local pd <const> = playdate
local gfx <const> = pd.graphics

local function initialize()
	print("helloworld")
	--drawCenteredText()

	-- local knightImage = gfx.image.new("images/knight")
	-- if knightImage then
    --     local playerInstance = Player(200, 200, knightImage)  -- Ensure player instance is created
    --     playerInstance:add()
    -- else
    --     print("Error: knight image not found.")
    -- end 

	local playerInstance = Knight(200, 200)
	playerInstance:add()

	-- Load a font
	local font = gfx.font.new('font/Mini Sans 2X')
    if font then
        gfx.setFont(font)
        print("Font loaded successfully.")
    else
        print("Error: Font not found.")
    end
end

initialize()

function pd.update()
	gfx.clear()
	gfx.setColor(gfx.kColorBlack)
	

	
	gfx.sprite.update()


	local text = "Hello World"
    
    -- Get text dimensions
    local textWidth, textHeight = gfx.getTextSize(text)
    
    -- Calculate centered position
    local x = (400 - textWidth) / 2
    local y = (240 - textHeight) / 2
    
    -- Draw text at the center
    gfx.drawText(text, x, y)
	

	pd.timer.updateTimers()
	
	
	
end


