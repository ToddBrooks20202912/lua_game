local class = require "middleclass"

local Player = class("Player")

function Player:initialize()
  self.x = 75
  self.y = 180
  self.width = 10
  self.height = 10
  self.gravity = 0
end

function Player:flap()
  self.gravity = -165
end

function Player:hasHit(object)
    if self.x > object.x + object.width or object.x > self.x + self.width then
      return false
    end
    if self.y > object.y + object.height or object.y > self.y + self.height then
      return false
    end
    return true
end


function Player:update(dt)
  self.gravity = self.gravity + 516 * dt
  self.y = self.y + self.gravity *dt
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return {Player = Player}