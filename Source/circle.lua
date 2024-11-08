local pd <const> = playdate
local gfx <const> = pd.graphics

class('Circle').extends(gfx.sprite)

function Circle:init( x,y,r)
    Circle.super.init(self)
    self:moveTo(x,y)

    local circleImage = gfx.image.new(r * 2, r * 2)
    gfx.pushContext(circleImage)
        gfx.fillCircleAtPoint(r, r, r)
    gfx.popContext()

    self:setImage(circleImage)
    self:add()


end


local pd <const> = playdate
local gfx <const> = pd.graphics

class('Circle').extends(gfx.sprite)

function Circle:init(x, y, r)
    Circle.super.init(self)
    self:moveTo(x, y)
    
    -- Create an image with the circle
    local circleImage = gfx.image.new(r * 2, r * 2)
    gfx.pushContext(circleImage)
        gfx.fillCircleAtPoint(r, r, r)
    gfx.popContext()
    
    -- Set the image to the sprite and add it
    self:setImage(circleImage)
    self:add()
end
