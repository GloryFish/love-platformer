-- 
--  scene_test.lua
--  love-platformer
--  
--  Created by Jay Roberts on 2010-12-25.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'logger'
require 'vector'
require 'controller_manager'
require 'input'
require 'level'
require 'player'
require 'camera'

testing = Gamestate.new()

function testing.enter(self, pre)
  testing.logger = Logger(vector(40, 40))

  input = Input()
  
  lvl = Level('steps')

  player = Player(lvl.playerStart)

  camera = Camera()
  camera.bounds = {
    top = 0,
    right = lvl:getWidth(),
    bottom = lvl:getHeight(),
    left = 0
  }
  camera.position = player.position
  camera:update(0)
  
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  
  love.mouse.setVisible(true)
end

function testing.keypressed(self, key, unicode)
  if input.state.buttons.newpress.back then
    Gamestate.switch(menu)
  end
end

function testing.update(self, dt)
  testing.logger:update(dt)
  
  local mouse = vector(love.mouse.getX(), love.mouse.getY())
  local tile = lvl:toTileCoords(mouse)
  
  tile = tile + vector(1, 1)
  
  testing.logger:addLine(string.format('World: %i, %i', mouse.x, mouse.y))
  testing.logger:addLine(string.format('Tile: %i, %i', tile.x, tile.y))
  if player.onground then
    testing.logger:addLine(string.format('State: %s', 'On Ground'))
  else
    testing.logger:addLine(string.format('State: %s', 'Jumping'))
  end
  testing.logger:addLine(string.format('Width: %i Height: %i', lvl:getWidth(), lvl:getHeight()))

  if (lvl:pointIsWalkable(mouse)) then
    testing.logger:addLine(string.format('Walkable'))
  else
    testing.logger:addLine(string.format('Wall'))
  end
  
  input:update(dt)
  
  if input.state.buttons.newpress.back then
    Gamestate.switch(menu)
  end

  -- Apply any controller movement to the player
  player:setMovement(input.state.movement)
  
  if input.state.buttons.newpress.jump then
    if player.onground then
      player:jump()
    end
  end
  
  -- Apply gravity
  local gravityAmount = 1
  
  if input.state.buttons.jump and player.velocity.y < 0 then
    gravityAmount = 0.5
  end
  
  player.velocity = player.velocity + lvl.gravity * dt * gravityAmount -- Gravity
  
  if dt > 0.5 then
    player.velocity.y = 0
  end
  
  -- if temp == true then
  --   player.velocity = player.velocity + lvl.gravity * dt * gravityAmount -- Gravity
  -- else
  --   temp = true
  -- end
  
  local newPos = player.position + player.velocity * dt
  local curUL, curUR, curBL, curBR = player:getCorners()
  local newUL, newUR, newBL, newBR = player:getCorners(newPos)
  
  if player.velocity.y > 0 then -- Falling
    local testBL = vector(curBL.x, newBL.y)
    local testBR = vector(curBR.x, newBR.y)
    
    if lvl:pointIsWalkable(testBL) == false or lvl:pointIsWalkable(testBR) == false then -- Collide with bottom
      player:setFloorPosition(lvl:floorPosition(testBL))
      player.velocity.y = 0
      player.onground = true
    end
  end

  if player.velocity.y < 0 then -- Jumping
    local testUL = vector(curUL.x, newUL.y)
    local testUR = vector(curUR.x, newUR.y)

    if lvl:pointIsWalkable(testUL) == false or lvl:pointIsWalkable(testUR) == false then -- Collide with top
      player.velocity.y = 0
    end
  end
  
  newPos = player.position + player.velocity * dt
  curUL, curUR, curBL, curBR = player:getCorners()
  newUL, newUR, newBL, newBR = player:getCorners(newPos)
  
  if player.velocity.x > 0 then -- Collide with right side
    local testUR = vector(newUR.x, curUR.y)
    local testBR = vector(newBR.x, curBR.y - 1)

    if lvl:pointIsWalkable(testUR) == false or lvl:pointIsWalkable(testBR) == false then
      player.velocity.x = 0
    end
  end

  if player.velocity.x < 0 then -- Collide with left side
    local testUL = vector(newUL.x, curUL.y)
    local testBL = vector(newBL.x, curBL.y - 1)

    if lvl:pointIsWalkable(testUL) == false or lvl:pointIsWalkable(testBL) == false then
      player.velocity.x = 0
    end
  end
  
  -- Here we update the player, the final velocity will be applied here
  player:update(dt)
  
  camera.focus = player.position
  camera:update(dt)


end

function testing.draw(self)
  love.graphics.push()

  -- Game
  love.graphics.translate(-camera.offset.x, -camera.offset.y)
  lvl:draw()
  player:draw()

  love.graphics.pop()

  -- UI
  love.graphics.translate(0, 0)  
  testing.logger:draw()
end

function testing.leave(self)
end