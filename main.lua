_G.love = require("love")
local push = require "push"
local winWidth, winHeight = 1280, 720
local gameWidth, gameHeight = 512, 288

-- TODO list: 
-- Background
-- Menu implementation (do this relatively early)
-- Pause menu implementation (do this after menu)
-- Main game logic (whatever logic depending on what I do for the game and how questions are answered)
-- Implement saves (???)

local hills = love.graphics.newImage("hills.png")
local hillPos = 0
local floor = love.graphics.newImage("floor.png")
local floorPos = 0

local hillPosChange = 15
local floorPosChange = 30
local hillOrigin = 413 -- this is the looping point of the image on the x axis

local game = {
  state = {
      menu = false,
      paused = false, 
      running = false, 
      ended = false
    },
  }
function love.load() -- Load in data when the application starts up | we put things in here we want to load | Only runs once
  love.graphics.setDefaultFilter("nearest", "nearest")
  push:setupScreen(gameWidth, gameHeight, winWidth, winHeight, {
      vsync = true,
      fullscreen = false,
      resizable = true
      })
  menu = true
  paused = false
  num = 0
end

function love.resize(width, height)
    push:resize(width, height)
end

function love.update(dt) -- Runs every 60 frames | "dt" is deltatime, time between the frame and the last, every frame (every frame is a second) | updates everything (player moving)
  hillPos = (hillPos + hillPosChange * dt) % hillOrigin
  if (game.state.menu == false and game.state.paused == false) then
    num = num + 1
    text = num
  end
  
end

function love.draw() -- Draws to the screen | We first move the player's location, then we visually draw this on the screen | Player is hit, heart destroyed or damaged
  push:start()
  if not game.state.paused then
    love.graphics.draw(hills, -hillPos, 0)
    love.graphics.draw(floor, -floorPos, gameHeight - 16) -- gameHeight - x, where x is the height of the floor
    love.graphics.print(text)
  end
  if game.state.paused == true then
    drawPause()
  end
  if game.state.menu == true then
    -- drawMenu()
  end  
  push:finish()
end

function drawPause()
  love.graphics.rectangle("fill", (gameWidth / 2) - 50, (gameHeight / 2) - 50, 100, 100) -- Resume Game
    -- love.graphics.rectangle("fill", 500, 100, 100, 100) -- Quit
end


function love.keypressed(key) -- "Opens the menu" | Currently pressing escape will stop the game, then pressing escape again will begin it.
  if key == "escape" then
    if game.state.paused == true then
      game.state.paused = false
    else
      game.state.paused = true
    end
    print(game.state.paused)
    print(game.state.menu)
  end  
  if key == "backspace" then
    love.event.quit()
  end
end