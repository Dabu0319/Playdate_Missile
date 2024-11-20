
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
    if missileState == "ready" and missile == nil then
        missile = Missile(200, 220, 4) 
        --local missile1 = Missile(200, 220, 2)

        missileState = "active" 
        enemiesSpawned = false
        
        print("Missile fired!")
    end
    
end


function Player:update()
    --print helloworld
    --print("Hello World")
    if pd.buttonJustPressed(pd.kButtonA) then
        -- This block will only execute once per button press
        print("Button A just pressed")
        self:fireMissile()
    end
    


    
end


