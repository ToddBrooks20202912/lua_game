local class = require "middleclass"

local TopBuilding = class("TopBuilding")

function TopBuilding:initialize(gameHeight, buildingPosChange, gameWidth)
  self.x = gameWidth
  self.y = math.random(-70 , gameHeight - 290) -- -50, 6
  self.buildingPosChange = 200
  self.width = building:getWidth()
  self.height = building:getHeight()
  self.buildingOrigin = 600
  self.passNum = 0
  self.active = true
end

function TopBuilding:update(dt)
  if (self.x < -100) then
    self.x = self.buildingOrigin
    self.passNum = self.passNum + 5
    self.y = math.random(-70 , gameHeight - 290) -- -50, 6
    self.active = true
  end
    self.x = self.x - (self.buildingPosChange + self.passNum )  * dt
end

function TopBuilding:passed()
    self.active = false
  end

function TopBuilding:draw()
    love.graphics.draw(building, self.x, self.y)
end

return {TopBuilding = TopBuilding}