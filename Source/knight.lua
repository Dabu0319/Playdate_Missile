import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Knight').extends(Player)

function Knight:init(x,y)
    local knightImage = gfx.image.new("images/knight")
    Knight.super.init(self, x, y, knightImage)
    self.moveSpeed = 1.5
    self.projectileSpeed = 1.5
    

end