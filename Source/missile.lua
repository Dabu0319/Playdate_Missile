local pd <const> = playdate
local gfx <const> = pd.graphics

class('Missile').extends(gfx.sprite)





function Missile:init(x, y, speed)
    -- local missileImage = gfx.image.new("images/projectile")
    -- if not missileImage then
    --     print("Error: Failed to load missile image!") 
    --     return
    -- end
    self.originalImage = gfx.image.new(10, 10)
    gfx.pushContext(self.originalImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillCircleInRect(0, 0, 10, 10)
    gfx.popContext()
    self:setImage(self.originalImage)
    self:moveTo(x, y)

    self.speed = speed or 1
    self.angle = 0
    self.angleSpeed = 0.3
    self.type = "missile"
    --self:setCollideRect((self.width)/4,  (self.width)/4, (self.width)/2 , (self.width)/2)
    self:setCollideRect(0, 0, 10, 10)
    print("Sprite size:", self.width, self.height)
    print("Collision rect:", self:getCollideRect())
    self:add()

    local fps = pd.display.getRefreshRate()

    self.scale = 1.0
    self.shrinkTime = 5
    self.shrinkRate = 1 / (self.shrinkTime * fps)
    self.isFastShrink = false

    --timer
    self.timer = pd.timer.performAfterDelay(self.shrinkTime*1000, function()
        self:remove()
        missile = nil
        missileState = "ready"
    end)

    print("Missile initialized with type:", self.type)
end


function Missile:update()
    
    --Missile.super.update(self)

    if not self.angleSpeed then
        self.angleSpeed = 0.3
    end

    
    local crankChange = pd.getCrankChange()
    self.angle += crankChange * self.angleSpeed
    local radians = math.rad(self.angle)
    local dx = math.sin(radians) * self.speed
    local dy = -math.cos(radians) * self.speed

    
    local x, y = self:getPosition()
    self:moveWithCollisions(x + dx, y + dy)

    --shrink
    if pd.buttonIsPressed(pd.kButtonA) then
        self.isFastShrink = true
    else
        self.isFastShrink = false
    end

    local currentShrinkRate = self.shrinkRate * (self.isFastShrink and 2 or 1)
    self.scale -= currentShrinkRate

    if self.scale <= 0 then
        self:remove()
        missile = nil
        missileState = "ready"
        return
    end

    local scaledImage = self.originalImage:scaledImage(math.max(self.scale, 0.01))
    self:setImage(scaledImage)


    if y < 0 or x < 0 or x > 400 then
        self:remove()
        missile = nil
        missileState = "ready"
        return false
    end

    return true
end



function Missile:collisionResponse(other)
    print("Missile collided with:", other.type)
    if other.type == "enemy" then
        other:takeDamage(1) -- Deal 1 damage for now

    end
end