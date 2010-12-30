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
    player.position = pos
    player.scale = vector(2.0, 2.0)
  
    player.color = {
      r = 255,
      g = 140,
      b = 0,
      a = 255,
    }
    
    player.image = graphics.playerWalkA
    
    player.offset = vector(player.image:getWidth() / 2, player.image:getHeight() / 2) 
    
    player.runningSpeed = 150
    player.runningDeceleration = 10
    
    player.onFloor = false
    
    player.velocity = vector(0,0)

  end)

function Player:getCenterpoint()
  local center = vector(self.image:getWidth() / 2 * self.scale.x, 
                         self.image:getHeight() / 2 * self.scale.y)
  return center
end

function Player:respawn()
  self.position = vector(math.random(200, 400), 200)
  self.velocity = vector(0, 0)
end

function Player:getRightScreenEdge()
  return self.position.x + (self.image:getWidth() * self.scale.x) / 2
end

function Player:getLeftScreenEdge()
  return self.position.x - (self.image:getWidth() * self.scale.x) / 2
end

function Player:getTopScreenEdge()
  return self.position.y
end

function Player:getBottomScreenEdge()
  return self.position.y + (self.image:getHeight() * self.scale.y) / 2
end

function Player:jump()
  if self.onFloor then
    self.onFloor = false
    self.velocity = self.velocity + vector(0, -300)
  end
  
end

-- Call once per update if the user is pressing the right arrow key
function Player:movingRight()
  self.velocity.x = self.runningSpeed
end

-- Call once per update if the user is pressing the left arrow key
function Player:movingLeft()
  self.velocity.x = -self.runningSpeed
end

-- Call once per update if the user is not pressing left or right
function Player:notMovingLeftOrRight()
  if math.abs(self.velocity.x) < 2 * self.runningDeceleration then
    self.velocity.x = 0
  elseif self.velocity.x < 0 then
    self.velocity.x = self.velocity.x + self.runningDeceleration 
  elseif self.velocity.x > 0 then
    self.velocity.x = self.velocity.x - self.runningDeceleration 
  end  
end


function Player:update(dt)
  self.position = self.position + (self.velocity * dt)
end
  
function Player:draw()
  local image = self.image
  
  love.graphics.draw(
    image,
    math.floor(self.position.x),
    math.floor(self.position.y),
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )
end