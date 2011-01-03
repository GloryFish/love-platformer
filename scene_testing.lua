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
  testing.logger:addLine(string.format('State: %s', player.state))

  if (lvl:pointIsWalkable(mouse)) then
    testing.logger:addLine(string.format('Walkable'))
  else
    testing.logger:addLine(string.format('Wall'))
  end
  
  controller:update(dt)
  
  if controller.state.buttons.back then
    love.event.push('q')
  end

  -- Apply any controller movement to the player
  player:setMovement(controller.state.joystick)
  
  -- TODO: Fix jumping invocation, use a newpress parameter, check to make sur eplayer isn't already jumping 
  if controller.state.buttons.a then
    player:setState('jumping')
  end
  
  -- Here we modify the player's velocity, handle collisions etc
  
  player.velocity = player.velocity + lvl.gravity * dt
  
  local newPos = player.position + player.velocity * dt
  
  local ul, ur, bl, br = player:getCorners(newPos)
  
  -- TODO: Change the checking here so that what we actually check isn't the potential point
  -- Rather, we should check only the potential component in a single direction
  -- i.e. if we are checking falling, check the current actual position but with the y velocity added
  -- if we are checkign running, check the current actual position with the x velocity added
  -- That should fix any hanging issues
  
  if player.velocity.y > 0 then -- Falling
    if lvl:pointIsWalkable(bl) == false or lvl:pointIsWalkable(br) == false then -- Collide with bottom
      player.velocity.y = 0
    end
  end

  if player.velocity.y < 0 then -- Jumping
    if lvl:pointIsWalkable(ul) == false or lvl:pointIsWalkable(ur) == false then -- Collide with top
      player.velocity.y = 0
    end
  end

  -- Update corners
  newPos = player.position + player.velocity * dt
  ul, ur, bl, br = player:getCorners(newPos)
  
  if player.velocity.x > 0 then -- Collide with right side
    if lvl:pointIsWalkable(ur) == false or lvl:pointIsWalkable(br) == false then
      player.velocity.x = 0
    end
  end

  if player.velocity.x < 0 then -- Collide with left side
    if lvl:pointIsWalkable(ul) == false or lvl:pointIsWalkable(bl) == false then
      player.velocity.x = 0
    end
  end



  
  -- Here we update the player, the final velocity will be applied here
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