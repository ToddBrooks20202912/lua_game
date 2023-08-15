_G.love = require("love")

local push = require "push"
local winWidth, winHeight = 1280, 720
gameWidth, gameHeight = 350, 288




-- TODO list: 
-- Menu implementation (do this relatively early)
-- Pause menu implementation (do this after menu)
-- Main game logic (whatever logic depending on what I do for the game and how questions are answered)
-- Implement saves (???)
local font = love.graphics.newFont("ITC_ Korinna_Normal.ttf", 13) -- font import
local hills = love.graphics.newImage("sky.png")
local skyPos = 0
local floor = love.graphics.newImage("floor.png")
local floorPos = 0
local buildingPosChange = 15
local skyPosChange = 15
local floorPosChange = 30
local hillOrigin = gameHeight -- this is the looping point of the image on the x axis
local floorOrign = gameWidth
local pauseDisplay = love.graphics.newImage("pauseDisplay.png")

local game = {
  state = {
      menu = false, -- this will change to true when menu is working
      paused = false, 
      running = false, 
      ended = false
    },
  }
function love.load() -- Load in data when the application starts up | we put things in here we want to load | Only runs once
  
  -- Misc
  love.graphics.setFont(font)
  
  
  -- Player
  players = require("Player") -- see the Player.lua file
  player = players.Player:new()
  
  -- Building
  building = love.graphics.newImage("building.png")
  botBuildings = require("BottomBuilding")
  topBuildings = require("TopBuilding")

  building1 = botBuildings.BotBuilding:new(gameHeight, buildingPosChange, gameWidth)
  building2 = topBuildings.TopBuilding:new(gameHeight, buildingPosChange, gameWidth)
  building3 = botBuildings.BotBuilding:new(gameHeight, buildingPosChange, gameWidth + 200)
  building4 = topBuildings.TopBuilding:new(gameHeight, buildingPosChange, gameWidth + 200)

  -- Score
  score = 0
  
  -- Clouds
  cloud = love.graphics.newImage("cloud.png")
  clouds = require("Clouds") -- see the Clouds.lua file
--  for i=1, 5, 1 do
--    local cloud[i] = clouds.Cloud:new(gameHeight)
--    table.insert(cloud[i])
--  end
-- Today I learned that Lua cannot do this. I will have to manually create these.
  cloud1 = clouds.Cloud:new(gameHeight)
  cloud2 = clouds.Cloud:new(gameHeight)
  cloud3 = clouds.Cloud:new(gameHeight)
  cloud4 = clouds.Cloud:new(gameHeight)
  cloud5 = clouds.Cloud:new(gameHeight)
  
  love.graphics.setDefaultFilter("nearest", "nearest")
  push:setupScreen(gameWidth, gameHeight, winWidth, winHeight, {
      vsync = true,
      fullscreen = false,
      resizable = true
      })
  game.state.paused = false
  game.state.ended = false
  num = 0
end

function love.resize(width, height)
    push:resize(width, height)
end

function love.update(dt) -- Runs every 60 frames | "dt" is deltatime, time between the frame and the last, every frame (every frame is a second) | updates everything (player moving)
  
  if not (game.state.paused or game.state.ended) then -- all main game logic goes here, otherwise it will move onto the other conditionals to check for the state of the game 
    cloud1:update(dt)
    cloud2:update(dt)
    cloud3:update(dt)
    cloud4:update(dt)
    cloud5:update(dt)
    player:update(dt)
    building1:update(dt)
    building2:update(dt)
    building3:update(dt)
    building4:update(dt)
    print(game.state.ended) -- debug check, catches unusual events/errors where a state has changed but not ended
    skyPos = (skyPos + skyPosChange * dt) % hillOrigin -- resets and returns the positions
    floorPos = (floorPos + floorPosChange *dt) % floorOrign -- changing the floor position at the "resettable" positions, making them look like they move
    
    
    if player:hasHit(building1) then
      game.state.ended = true
      love.graphics.print("Final score: " .. score, (gameWidth / 2) -50, (gameHeight / 2) - 50)
      print(game.state.ended)
    end
    if player:hasHit(building2) then
      game.state.ended = true
      love.graphics.print("Final score: " .. score, (gameWidth / 2) -50, (gameHeight / 2) - 50)
      print(game.state.ended)
    end
    if player:hasHit(building3) then
      game.state.ended = true
      love.graphics.print("Final score: " .. score, (gameWidth / 2) -50, (gameHeight / 2) - 50)
      print(game.state.ended)
    end
    if player:hasHit(building4) then -- these check for ANY collisions against any possible buildings
      game.state.ended = true -- if the player hits, it then transfers the game's state to a gameover state
      love.graphics.print("Final score: " .. score, (gameWidth / 2) -50, (gameHeight / 2) - 50)
      print(game.state.ended)
    end
    if player.y > gameHeight - 16 then -- hard-coded, since the floor is 16 pixels above 
      game.state.ended = true
      love.graphics.print("Final score: " .. score, (gameWidth / 2) -50, (gameHeight / 2) - 50)
      print(game.state.ended) -- these were for debugging with the console
    end
    
    
    if building1.active == true and player.x > (building1.x + building1.width) then 
      score = score + 1
      building1.active = false
      
    end
    
    if building3.active == true and player.x > (building3.x + building3.width) then -- if these are active buildings and the player passes, they score a point
      score = score + 1
      building3.active = false -- this is done to prevent scoring beyond 1 point
    end
    -- each building will then loop back round from the beginning to end of the screen, when reset, they also reset their activation
    end  
end

function love.draw() -- Draws to the screen | We first move the player's location, then we visually draw this on the screen | Player is hit, heart destroyed or damaged
  push:start() -- push implements easy handling of resizing and drawing
  if not game.state.paused or not game.state.ended then -- all main game logic goes here, otherwise it will move onto the other conditionals to check for the state of the game 
    love.graphics.draw(hills, -skyPos, 0) -- background
    cloud1:draw()
    cloud2:draw()
    cloud3:draw()
    cloud4:draw()
    cloud5:draw()
    player:draw()
    building1:draw()
    building2:draw()
    building3:draw()
    building4:draw()
    love.graphics.draw(floor, -floorPos, gameHeight - 16) -- gameHeight - x, where x is the height of the floor
    love.graphics.print("Current Score:" .. score) -- overlay text to track score
    
    
  end
  if game.state.paused == true then
    drawPause() 
  end
  if game.state.ended == true then
  end  
  push:finish()
end

function drawPause() -- pause screen, will stop all possible updates and exist outside the main game loop
    -- love.graphics.rectangle("fill", 500, 100, 100, 100) -- Quit
  love.graphics.draw(pauseDisplay, (gameWidth / 2) -50, (gameHeight / 2) - 50)
  love.graphics.setColor(0,0,0)
  love.graphics.print("Current Score: " .. score, (gameWidth / 2) -50, (gameHeight / 2) - 50) -- overlayed ontop of the image, displays current score
end

function drawMenu()
  love.graphics.rectangle("fill", (gameWidth / 2) - 50, (gameHeight / 2) - 50, 100, 100) -- currently a placeholder
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
  if key == "space" then
    if game.state.ended == true then
      love.load()
    end
    player:flap()
  end
end

