-- 
--  hole.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

Hole = class(function(hole, pos)
    hole.position = pos
    hole.scale = vector(2.0, 2.0)
  
    hole.color = {
      r = 255,
      g = 140,
      b = 0,
      a = 255,
    }
    
    hole.image = graphics.hole
    
    hole.offset = vector(8, hole.image:getHeight() / 2) 

  end)

function Hole:moveRight()
  self.position.x = self.position.x + 1
  
  if self.position.x > 13 then
    self.position.x = 13
    return false
  end
  
  return true
end  

function Hole:moveLeft()
  self.position.x = self.position.x - 1
  
  if self.position.x < 0 then
    self.position.x = 0
    return false
  end
  
  return true
end  


function Hole:positionIsInHole(pos)
  if pos.y ~= self.position.y then
    return false
  end
  
  if pos.x >= self.position.x + 1 and pos.x < self.position.x + 3 then
    return true
  end
  
end
  
function Hole:draw()
  -- These are offsets to shift the entire board
  local x_offset = boardOffset.x
  local y_offset = boardOffset.y
  
  local image = self.image
  local color = self.color

  love.graphics.setColor(
    200,
    200,
    200,
    255
    )
  
  if self.position.x > 0 then
    for i = 0, self.position.x - 1  do
      love.graphics.draw(
        graphics.horizontal,
        math.floor(i * (graphics.horizontal:getWidth() * self.scale.x)) + x_offset,
        math.floor(11 * (graphics.horizontal:getHeight() * self.scale.x)) + y_offset,
        self.orientation,
        self.scale.x,
        self.scale.y,
        8,
        8
      )
    end
  end

  if self.position.x < 16 then
    for i = self.position.x + 4, 16 do
      love.graphics.draw(
        graphics.horizontal,
        math.floor(i * (graphics.horizontal:getWidth() * self.scale.x)) + x_offset,
        math.floor(11 * (graphics.horizontal:getHeight() * self.scale.x)) + y_offset,
        self.orientation,
        self.scale.x,
        self.scale.y,
        8,
        8
      )
    end
  end


  love.graphics.setColor(
    color.r,
    color.g,
    color.b,
    color.a
    )
  
  love.graphics.draw(
    image,
    math.floor(self.position.x * (16 * self.scale.x)) + x_offset,
    math.floor(self.position.y * (16 * self.scale.y)) + y_offset,
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )
end