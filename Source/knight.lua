import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Knight').extends(Player)

function Knight:init(x,y)
    local knightImage = gfx.image.new("images/knight")
    Knight.super.init(self, x, y, knightImage)
    self.moveSpeed = 0.1
    self.projectileSpeed = 0.1
    

end