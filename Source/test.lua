-- local pd <const> = playdate
-- local gfx <const> = pd.graphics

-- class('BG').extends(gfx.sprite)

-- function BG:init()
--     -- 加载背景图片
--     local originalImage = gfx.image.new("images/bg")
--     assert(originalImage, "无法加载背景图片！请检查路径。")
    
--     -- 设置缩放比例
--     local scaleFactor = 0.1 -- 调整为适合你的需求的缩放比例（0.5 表示缩小 50%）
--     local scaledImage = originalImage:scaledImage(scaleFactor, scaleFactor)

--     -- 获取屏幕和图片尺寸
--     local screenWidth = playdate.display.getWidth()
--     local screenHeight = playdate.display.getHeight()
--     local imageWidth, imageHeight = scaledImage:getSize()

--     -- 计算居中位置
--     local centerX = (screenWidth - imageWidth) / 2
--     local centerY = (screenHeight - imageHeight) / 2

--     -- 设置图片和位置
--     self:setImage(scaledImage)
--     self:moveTo(centerX + imageWidth / 2, centerY + imageHeight / 2)
--     self:add() -- 将 sprite 添加到游戏场景中
-- end

