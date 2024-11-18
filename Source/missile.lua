local pd <const> = playdate
local gfx <const> = pd.graphics

class('Missile').extends(gfx.sprite)

function Missile:init(x, y, speed)
    -- local missileImage = gfx.image.new("images/projectile")
    -- if not missileImage then
    --     print("Error: Failed to load missile image!") 
    --     return
    -- end
    local missileImage = gfx.image.new(10, 10)
    gfx.pushContext(missileImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillCircleInRect(0, 0, 10, 10)
    gfx.popContext()
    self:setImage(missileImage)
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