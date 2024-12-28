import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "missile"
import "player"
import "enemy"
import "sound_manager"

local pd <const> = playdate
local gfx = pd.graphics

-- 全局变量
stateHandlers = {}
missileState = "ready" -- 状态："ready" 或 "active"
gameState = "playing" -- 状态："playing" 或 "gameover"

player = nil
enemies = {}
missile = nil
missileTrails = {}
local defaultMissileCount = 5
missileCount = defaultMissileCount

enemiesSpawned = false
score = 0
destroyedEnemies = 0 -- 修复拼写问题
enemySpawnerTimer = nil

function startEnemySpawner()
    if enemySpawnerTimer then
        if not enemySpawnerTimer.paused then
            return -- 如果计时器已经在运行，直接返回
        end
        enemySpawnerTimer:resume() -- 如果计时器暂停，恢复
    else
        -- 如果计时器不存在，创建新的计时器
        enemySpawnerTimer = pd.timer.keyRepeatTimerWithDelay(2000, 2000, function()
            spawnEnemy()
        end)
    end
end

function pauseEnemySpawner()
    if enemySpawnerTimer then
        enemySpawnerTimer:pause() -- 暂停计时器
    end
end

-- 全局函数，生成敌人
function spawnEnemy()
    local x = math.random(0, 400)
    local y = math.random(0, 120)
    local newEnemy = Enemy(x, y, 1, 1)
    table.insert(enemies, newEnemy)
end

-- 绘制导弹状态
local function drawMissiles()
    if not player then return end
    local startX, startY = player.x + 20, player.y -- 子弹显示在玩家的左上方
    local spacing = 15
    for i = 1, missileCount do
        gfx.setColor(gfx.kColorBlack)
        gfx.fillCircleAtPoint(startX + (i - 1) * spacing, startY, 5)
    end
end
local function initialize()
    -- 清理残留的玩家、敌人和导弹
    if player then
        player:remove()
        player = nil
    end

    if missile then
        missile:remove()
        missile = nil
    end

    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        enemy:remove()
        table.remove(enemies, i)
    end

    -- 创建新的玩家
    player = Player(200, 230)

    -- 清空敌人并生成新敌人
    enemies = {}
    spawnEnemy()
    spawnEnemy()
    spawnEnemy()

    -- 重置导弹状态
    missile = nil
    missileState = "ready"
    missileTrails = {}

    -- 初始化游戏变量
    score = 0
    destroyedEnemies = 0
    missileCount = defaultMissileCount

    -- 初始化声音
    if SoundManager then
        SoundManager.stopBGM()
        SoundManager.init()
        SoundManager.resetBGM()
    end

    -- 启动计时器但暂停
    enemySpawnerPaused = true
    pauseEnemySpawner()
end

-- 切换游戏状态
function setGameState(newState)
    if gameState == newState then return end
    gameState = newState

    if newState == "gameover" then
        -- 停止敌人生成
        if enemySpawnerTimer then
            enemySpawnerTimer:pause()
        end

        -- 清理敌人
        for _, enemy in ipairs(enemies) do
            enemy:remove()
        end
        enemies = {}

        -- 移除玩家
        if player then
            player:remove()
        end

        -- 移除导弹
        if missile then
            missile:remove()
            missile = nil
        end
    end

    if stateHandlers[newState] then
        stateHandlers[newState]()
    end
end

local function restartGame()
    -- 重置游戏变量
    score = 0
    destroyedEnemies = 0
    missileCount = defaultMissileCount
    enemiesSpawned = false

    -- 重置计时器状态
    enemySpawnerPaused = true
    pauseEnemySpawner()

    -- 重新初始化游戏内容
    initialize()

    -- 切换到游戏状态
    setGameState("playing")
end

-- 游戏中状态更新
local function playingUpdate()
    gfx.clear()
    gfx.sprite.update()
    pd.timer.updateTimers()

    -- 绘制导弹轨迹
    for i, pos in ipairs(missileTrails) do
        local alpha = 1 - (i / #missileTrails)
        gfx.setColor(gfx.kColorBlack)
        gfx.setDitherPattern(alpha)
        gfx.fillCircleAtPoint(pos.x, pos.y, 2)
    end

    -- 绘制分数
    gfx.setColor(gfx.kColorBlack)
    local scoreText = "Score: " .. score
    gfx.drawText(scoreText, 180, 10)

    -- 绘制导弹状态
    drawMissiles()

    -- 手动检测玩家与敌人碰撞
    if player and #enemies > 0 then
        for _, enemy in ipairs(enemies) do
            local collisions = enemy:overlappingSprites()
            for _, sprite in ipairs(collisions) do
                if sprite == player then -- 玩家与敌人碰撞
                    print("Player collided with Enemy!")
                    setGameState("gameover")
                    return
                end
            end
        end
    end
end

-- 游戏结束状态更新
local function gameOver()
    gfx.clear()
    gfx.drawTextAligned("Game Over", 200, 80, kTextAlignment.center)
    gfx.drawTextAligned("Score: " .. score, 200, 110, kTextAlignment.center)
    gfx.drawTextAligned("Press A to Restart", 200, 140, kTextAlignment.center)
end

-- 初始化游戏
initialize()
stateHandlers["playing"] = playingUpdate
stateHandlers["gameover"] = gameOver

-- 主更新函数
function pd.update()
    if stateHandlers[gameState] then
        stateHandlers[gameState]()
    end

    -- 玩家操作逻辑
    if pd.buttonJustPressed(pd.kButtonA) then
        if gameState == "gameover" then
            restartGame() -- 重新开始游戏
        elseif gameState == "playing" and player then
            player:fireMissile()
        end
    end
end
