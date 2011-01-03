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
require 'level'
require 'player'

testing = Gamestate.new()

function testing.enter(self, pre)
  testing.logger = Logger(vector(10, 10))
  controller = ControllerManager()
  
  lvl = Level('testmap')
  
  player = Player(lvl.playerStart)
  
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  
  love.mouse.setVisible(true)
end

function testing.update(self, dt)
  testing.logger:update(dt)
  
  local mouse = vector(love.mouse.getX(), love.mouse.getY())
  local tile = lvl:toTileCoords(mouse)
  
  tile = tile + vector(1, 1)
  
  testing.logger:addLine(string.format('World: %i, %i', mouse.x, mouse.y))
  testing.logger:addLine(string.format('Tile: %i, %i', tile.x, tile.y))

  -- testing.logger:addLine(string.format('%s', lvl.tiles[tile.x][tile.y]))
  
  if (lvl:pointIsWalkable(mouse)) then
    testing.logger:addLine(string.format('Walkable'))
  else
    testing.logger:addLine(string.format('Wall'))
  end
  
  controller:update(dt)
  
  if controller.state.buttons.back then
    love.event.push('q')
  end

  player:setMovement(controller.state.joystick)

  player:update(dt)

end

function testing.draw(self)
  testing.logger:draw()
  controller:draw(dt)
  
  lvl:draw()
  player:draw()
end

function testing.leave(self)
end