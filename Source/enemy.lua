local pd <const> = playdate
local gfx = playdate.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, speed, health)
    enemyImage = gfx.image.new(20, 20)
    gfx.pushContext(enemyImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 20, 20)
    gfx.popContext()

    self:setImage(enemyImage)
    self:setCollideRect(0, 0, 20, 20)
    self:moveWithCollisions(x, y)
    self.isSpeedUp = false

    self.baseSpeed = speed or 1
    self.speed = self.baseSpeed
    self.health = health or 1
    self.type = "enemy"
    self:setGroups({3})
    self:setCollidesWithGroups({1,2} )
    self:add()

    --print("Enemy type after init:", type(self))
end

function Enemy:update()
    --Enemy.super.update(self)

    if pd.buttonIsPressed(pd.kButtonA) and missileState == "active" then
        self.isSpeedUp = true
    else
        self.isSpeedUp = false
    end


    
    self.speed = self.isSpeedUp and (self.baseSpeed * 2) or self.baseSpeed

    --enemy move towards player while active, stop when ready

    if player then

        if missileState == "active" then

            local ex, ey = self:getPosition()
            local px, py = player:getPosition()

            local dx = px - ex
            local dy = py - ey

            -- Calculate the distance between enemy and player
            local distance = math.sqrt(dx^2 + dy^2)

            -- -- If the enemy is close enough to the player, stop moving
            -- if distance < 5 then -- 5 is the threshold; you can adjust it
            --     return
            -- end

            -- Normalize the direction vector
            if distance > 0 then
                dx = dx / distance
                dy = dy / distance
            end

            -- Move the enemy towards the player
            self:moveTo(ex + dx * self.speed, ey + dy * self.speed)
            
        else
            return
        end

        
    end

    return true
end

function Enemy:remove()
    gfx.sprite.remove(self)
end

function Enemy:collisionResponse(other)
    print("Enemy collided with:", other.type)

   if other.type == "player" then
        setGameState("gameover")
    end

    
    return gfx.sprite.kCollisionTypeBounce
end

function Enemy:takeDamage(damage)
    self.health = self.health - damage
    if self.health <= 0 then

        for i, enemy in ipairs(enemies) do
            if enemy == self then
                table.remove(enemies, i)
                break
            end
        end
        --remove from table
        
        self:remove()
        print("Enemy destroyed")
        destroyedEnemies += 1

        if destroyedEnemies >= 3 then
            destroyedEnemies = 0 
            missileCount += 1 
            
        end
        return false
    else
        print("Enemy took damage. Remaining health:", self.health)
    end
    return true
end
