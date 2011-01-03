-- 
--  player.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

Player = class(function(player, pos)
  -- Tileset
  player.tileset = love.graphics.newImage('resources/ninja.png')
  player.tileset:setFilter('nearest', 'nearest')

  player.tileSize = 16
  player.scale = 2
  player.offset = vector(player.tileSize / 2, player.tileSize / 2)

  -- Quads, animation frames
  player.animations = {}
  
  player.animations['standing'] = {}
  player.animations['standing'].quads = {
    love.graphics.newQuad(0, 0, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight())
  }

  player.animations['walking'] = {}
  player.animations['walking'].frameInterval = 0.2
  player.animations['walking'].quads = {
    love.graphics.newQuad(0 * player.tileSize, 2 * player.tileSize, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight()),
    love.graphics.newQuad(1 * player.tileSize, 2 * player.tileSize, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight()),
    love.graphics.newQuad(2 * player.tileSize, 2 * player.tileSize, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight()),
    love.graphics.newQuad(3 * player.tileSize, 2 * player.tileSize, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight()),
    love.graphics.newQuad(4 * player.tileSize, 2 * player.tileSize, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight()),
    love.graphics.newQuad(5 * player.tileSize, 2 * player.tileSize, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight())
  }
  
  player.animation = {}
  player.animation.current = 'standing'
  player.animation.frame = 1
  player.animation.elapsed = 0
  
  -- Instance vars
  player.flip = 1
  player.position = pos
  player.speed = 100
  player.state = 'standing'
  
  player.velocity = vector(0, 0)
  
end)

-- Call during update with the joystick vector
function Player:setMovement(movement)
  self.velocity.x = movement.x * self.speed
  
  if movement.x > 0 then
    self.flip = 1
  end

  if movement.x < 0 then
    self.flip = -1
  end

  if movement.x == 0 then
    self:setState('standing')
  else
    self:setState('walking')
  end    
end

function Player:setState(state)
  if (self.state ~= state) then
    self.state = state

    if state == 'walking' then
      self.animation.current = 'walking'
      self.animation.frame = 1
    end

    if state == 'standing' then
      self.animation.current = 'standing'
      self.animation.frame = 1
    end

  end
  
end


function Player:update(dt)
  self.animation.elapsed = self.animation.elapsed + dt
  
  -- Handle animation
  if #self.animations[self.animation.current].quads > 1 then -- More than one frame
    if self.animation.elapsed > self.animations[self.animation.current].frameInterval then -- Switch to next frame
      self.animation.frame = self.animation.frame + 1
      if self.animation.frame > #self.animations[self.animation.current].quads then -- Aaaand back around
        self.animation.frame = 1
      end
      self.animation.elapsed = 0
    end
  end
  
  -- Apply velocity to position
  self.position = self.position + self.velocity * dt
end
  
function Player:draw()
  love.graphics.setColor(255, 255, 255, 255)
  
  love.graphics.drawq(self.tileset,
                      self.animations[self.animation.current].quads[self.animation.frame], 
                      self.position.x, 
                      self.position.y,
                      0,
                      self.scale * self.flip,
                      self.scale,
                      self.offset.x,
                      self.offset.y)
  
end