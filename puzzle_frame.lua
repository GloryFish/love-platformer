-- 
--  block.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

PuzzleFrame = class(function(frame)
    frame.position = pos
    frame.scale = vector(2.0, 2.0)
  
    frame.color = {
      r = 255,
      g = 255,
      b = 255,
      a = 255,
    }
    
    frame.kind = block_kind
    
    frame.imageVertical = graphics.vertical
    frame.imageHorizontal = graphics.horizontal
    frame.imageCorner = graphics.corner
    
    frame.offset = vector(8, 8) 

  end)
  
  
function PuzzleFrame:draw()
  -- These are offsets to shift the entire board
  local x_offset = boardOffset.x
  local y_offset = boardOffset.y
  
  local image = nil
  local color = {
    r = 200,
    g = 200,
    b = 200,
    a = 255,
  }

  love.graphics.setColor(
    color.r,
    color.g,
    color.b,
    color.a
    )
  
  --  Corners
  love.graphics.draw(
    self.imageCorner,
    math.floor(-1 * (self.imageHorizontal:getWidth() * self.scale.x)) + x_offset,
    math.floor(-1 * (self.imageHorizontal:getHeight() * self.scale.x)) + y_offset,
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )

  love.graphics.draw(
    self.imageCorner,
    math.floor(17 * (self.imageHorizontal:getWidth() * self.scale.x)) + x_offset,
    math.floor(-1 * (self.imageHorizontal:getHeight() * self.scale.x)) + y_offset,
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )

  love.graphics.draw(
    self.imageCorner,
    math.floor(-1 * (self.imageHorizontal:getWidth() * self.scale.x)) + x_offset,
    math.floor(11 * (self.imageHorizontal:getHeight() * self.scale.x)) + y_offset,
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )

  love.graphics.draw(
    self.imageCorner,
    math.floor(17 * (self.imageHorizontal:getWidth() * self.scale.x)) + x_offset,
    math.floor(11 * (self.imageHorizontal:getHeight() * self.scale.x)) + y_offset,
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )


  
  
  -- Top
  for i = 0, 16 do
    love.graphics.draw(
      self.imageHorizontal,
      math.floor(i * (self.imageHorizontal:getWidth() * self.scale.x)) + x_offset,
      math.floor(-1 * (self.imageHorizontal:getHeight() * self.scale.x)) + y_offset,
      self.orientation,
      self.scale.x,
      self.scale.y,
      self.offset.x,
      self.offset.y
    )
  end
  
  --  Left
  for j = 0, 10 do
    love.graphics.draw(
      self.imageVertical,
      math.floor(-1 * (self.imageHorizontal:getWidth() * self.scale.x)) + x_offset,
      math.floor(j * (self.imageHorizontal:getHeight() * self.scale.x)) + y_offset,
      self.orientation,
      self.scale.x,
      self.scale.y,
      self.offset.x,
      self.offset.y
    )
  end


  --  Right
  for j = 0, 10 do
    love.graphics.draw(
      self.imageVertical,
      math.floor(17 * (self.imageHorizontal:getWidth() * self.scale.x)) + x_offset,
      math.floor(j * (self.imageHorizontal:getHeight() * self.scale.x)) + y_offset,
      self.orientation,
      self.scale.x,
      self.scale.y,
      self.offset.x,
      self.offset.y
    )
  end


  --  Bottom
   

end