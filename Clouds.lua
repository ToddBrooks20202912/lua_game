local class = require "middleclass"

local Cloud = class("Cloud")

function Cloud:initialize(gameHeight)
  self.x = 712
  self.y = love.math.random(gameHeight - gameHeight, gameHeight - 188)
  self.cloudPosChange = love.math.random(10, 100)
  self.width = cloud:getWidth()
  self.height = cloud:getHeight()
  self.cloudOrigin = 712
end

function Cloud:update(dt)
  if (self.x < -176) then
    self.x = self.cloudOrigin
    self.y = love.math.random(gameHeight - gameHeight, gameHeight - 188)
  end
    self.x = self.x - self.cloudPosChange * dt
end

function Cloud:draw()
    love.graphics.draw(cloud, self.x, self.y)
end

return {Cloud = Cloud}