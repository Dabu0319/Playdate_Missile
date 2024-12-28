
local pd <const> = playdate
local gfx <const> = pd.graphics

import "missile"

class('Player').extends(gfx.sprite)

function Player:init(x, y)
    playerImage = gfx.image.new(20, 20)
    gfx.pushContext(playerImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 20, 20)
    self:setCollideRect(0, 0, 20, 20)

    gfx.popContext()

    self:setImage(playerImage)
    self:moveTo(x, y)
    self:add()

    self.type = "player"
    self:setGroups({1})
    self:setCollidesWithGroups({3})
end

function Player:fireMissile(x,y)
    if  missile == nil and missileCount > 0 and missileState == "ready" then
        missile = Missile(200, 220, 2) 
        --local missile1 = Missile(200, 220, 2)

        missileState = "active" 
        enemiesSpawned = false
        missileCount -= 1
        --print("Missile fired!")
        if enemySpawnerTimer then
            enemySpawnerTimer:start()
        else
            startEnemySpawner() 
        end

    end
    
end

-- function Player:collisionResponse(other)
--     print("Player collisionResponse called with:", other.type)

--     if other.type == "missile" then
--         print("Collision ignored with missile.")
--         return gfx.sprite.kCollisionTypeNone -- 忽略与导弹的碰撞
--     elseif other.type == "enemy" then
--         print("Collision with enemy detected! Triggering game over.")
--         self:destroy()
--         setGameState("gameover")
--         return gfx.sprite.kCollisionTypeBounce -- 或者选择合适的响应类型
--     end

--     return gfx.sprite.kCollisionTypeNone -- 默认忽略
-- end


function Player:update()
    
    Player.super.update(self)

    --gfx.clear()

    -- if pd.buttonJustPressed(pd.kButtonA) and gameState == "playing" and missileState == "ready" then
    --     -- This block will only execute once per button press
    --     --print("Button A just pressed")
    --     self:fireMissile()
    -- end

    --self:drawMissiles()
    


    
end


