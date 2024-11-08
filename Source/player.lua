import "projectile"
local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y, image)

    self:moveTo(x, y)
    self:setImage(image)
    self.moveSpeed = 1
    self.projectileSpeed = 1

end

function Player:shoot(x,y)
    local projectileInstance = Projectile(x, y-10, self.projectileSpeed)
    projectileInstance:add()
    
end

function Player:ability()
    local function timerCallback()
        self:shoot(self.x, self.y)
        
    end
    pd.timer.performAfterDelay(50, timerCallback)
    pd.timer.performAfterDelay(150, timerCallback)
end

function Player:update()
    --print helloworld
    --print("Hello World")
    Player.super.update(self)

    -- if pd.buttonIsPressed(pd.kButtonLeft) then
    --     self:moveBy(-self.moveSpeed, 0)
    -- end
    -- if pd.buttonIsPressed(pd.kButtonRight) then
    --     self:moveBy(self.moveSpeed, 0)
    -- end
    local crankChange = pd.getCrankChange()
    self:moveBy(crankChange * self.moveSpeed/5, 0)

    -- press a to shoot, press b to use ability
    if pd.buttonJustPressed(pd.kButtonA) then
        self:shoot( self.x, self.y)
    end
    if pd.buttonJustPressed(pd.kButtonB) then
        self:ability( )
    end


    
end