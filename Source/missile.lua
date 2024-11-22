import "sound_manager"


local pd <const> = playdate
local gfx <const> = pd.graphics

class('Missile').extends(gfx.sprite)




function Missile:init(x, y, speed)
    -- local missileImage = gfx.image.new("images/projectile")
    -- if not missileImage then
    --     print("Error: Failed to load missile image!") 
    --     return
    -- end
    self.originalImage = gfx.image.new(12, 12)
    gfx.pushContext(self.originalImage)
    gfx.setColor(gfx.kColorBlack)
    --gfx.fillCircleInRect(0, 0, 10, 10)
    gfx.fillCircleAtPoint(6, 6, 5)
    gfx.popContext()
    self:setImage(self.originalImage)
    self:moveTo(x, y)

    --init movement
    self.speed = speed or 1
    self.angle = 0
    self.angleSpeed = 0.3
    self.type = "missile"
    --self:setCollideRect((self.width)/4,  (self.width)/4, (self.width)/2 , (self.width)/2)
    self:setCollideRect(0, 0, 10, 10)
    --print("Sprite size:", self.width, self.height)
    --print("Collision rect:", self:getCollideRect())
    self:add()

    --init trail
    
    self.trailPositions = {}
    self.trailMaxLength = 10 
    self.trailFadeStep = 1 / self.trailMaxLength


    --local fps = pd.display.getRefreshRate()
    local fps = 30

    self.scale = 1.0
    self.shrinkTime = 5
    --self.shrinkRate = self.scale / (self.shrinkTime * fps)
    self.shrinkRate = 1 / self.shrinkTime
    self.isFastShrink = false

    self.lastUpdateTime = playdate.getElapsedTime()

    --timer
    self.timer = pd.timer.performAfterDelay((self.shrinkTime) *1000, function()
        if missile == self then
            self:destroy()
        end
        
    end)

    print("Missile initialized with type:", self.type)
end


function Missile:destroy()

    if missileTrails then
        for _, pos in ipairs(missileTrails) do
            gfx.setColor(gfx.kColorWhite) 
            gfx.fillCircleAtPoint(pos.x, pos.y, 2)
        end
    end
    missileTrails = {}
    
    self:remove()
    missile = nil
    missileState = "ready"

    if missileCount == 0 then
        gameState = "gameover"
    end
end



function Missile:update()

    local currentTime = playdate.getElapsedTime() 
    local deltaTime = currentTime - self.lastUpdateTime
    self.lastUpdateTime = currentTime
    
    

    if not self.angleSpeed then
        self.angleSpeed = 0.3
    end

    
    local crankChange = pd.getCrankChange()
    self.angle += crankChange * self.angleSpeed
    local radians = math.rad(self.angle)

    local currentSpeed = self.speed * (self.isFastShrink and 2 or 1)
    
    local dx = math.sin(radians) * currentSpeed 
    local dy = -math.cos(radians) * currentSpeed 

    
    local x, y = self:getPosition()
    self:moveWithCollisions(x + dx, y + dy)

    --trail
    table.insert(missileTrails, {x = x, y = y})
    if #missileTrails > self.trailMaxLength then
        table.remove(missileTrails, 1)
    end


    --shrink
    if pd.buttonIsPressed(pd.kButtonA) and missileState == "active" then
        self.isFastShrink = true
    else
        self.isFastShrink = false
    end

    --print("Missile speed:", self.speed)

    --print("isFastShrink:", self.isFastShrink)

    local currentShrinkRate = self.shrinkRate * (self.isFastShrink and 2 or 1) * deltaTime
    self.scale = math.max(self.scale - currentShrinkRate, 0.01)
    --self.scale -= currentShrinkRate

    -- if self.scale <= 0 then
    --     self:remove()
    --     missile = nil
    --     missileState = "ready"
    --     return false
    -- end

    local scaledImage = self.originalImage:scaledImage(self.scale)
    self:setImage(scaledImage)


    if self.scale <= 0 or y < 0 or x < 0 or x > 400 then
        
        -- if missile == self then
        --     missile = nil
        --     missileState = "ready"
        -- end

        self:destroy()
        return false
    end

    return true
end



function Missile:collisionResponse(other)
    print("Missile collided with:", other.type)
    if other.type == "enemy" then
        other:takeDamage(1) -- Deal 1 damage for now
        score += 1

        SoundManager.playEffect("destroy")
        print("Score:", score)

    end
end