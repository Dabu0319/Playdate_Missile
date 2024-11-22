
local pd <const> = playdate
local gfx <const> = pd.graphics

import "missile"

class('Player').extends(gfx.sprite)

function Player:init(x, y)
    local playerImage = gfx.image.new(20, 20)
    gfx.pushContext(playerImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 20, 20)
    gfx.popContext()

    self:setImage(playerImage)
    self:moveTo(x, y)
    self:add()
end

function Player:fireMissile(x,y)
    if  missile == nil and missileCount>0 then
        missile = Missile(200, 220, 2) 
        --local missile1 = Missile(200, 220, 2)

        missileState = "active" 
        enemiesSpawned = false
        missileCount -= 1
        --print("Missile fired!")


    end
    
end

-- function Player:drawMissiles()
--     local startX = 220 
--     local startY = 10  
--     local spacing = 15

--     for i = 1, missileCount do
--         gfx.setColor(gfx.kColorBlack)
--         gfx.fillCircleAtPoint(startX, startY + (i - 1) * spacing, 5)
--     end
    
-- end


function Player:update()
    
    --Player.super.update(self)

    --gfx.clear()

    if pd.buttonJustPressed(pd.kButtonA) then
        -- This block will only execute once per button press
        --print("Button A just pressed")
        self:fireMissile()
    end

    --self:drawMissiles()
    


    
end


