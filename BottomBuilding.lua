local class = require "middleclass"

local BotBuilding = class("BottomBuilding")

function BotBuilding:initialize(gameHeight, buildingPosChange, gameWidth)
  self.x = gameWidth
  self.y = math.random(gameHeight / 1.5, gameHeight- 100) -- 192, 288
  self.buildingPosChange = 200
  self.width = building:getWidth()
  self.height = building:getHeight()
  self.buildingOrigin = 600
  self.passNum = 0
  self.active = true
end

function BotBuilding:update(dt)
  if (self.x < -100) then
    self.x = self.buildingOrigin
    self.passNum = self.passNum + 5
    self.y = math.random(gameHeight / 1.5, gameHeight - 100) -- 192, 288
    self.active = true
  end
    self.x = self.x - (self.buildingPosChange + self.passNum )  * dt
end

function BotBuilding:passed()
    self.active = false
  end

function BotBuilding:draw()
    love.graphics.draw(building, self.x, self.y)
end

return {BotBuilding = BotBuilding}