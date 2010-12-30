-- 
--  block.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

Block = class(function(block, pos, block_kind)
    block.position = pos
    block.scale = vector(2.0, 2.0)
    
    block.kind = block_kind

    if block.kind == 'good' then 
      block.color = {
        r = 0,
        g = 255,
        b = 0,
        a = 255,
      }
      block.image = graphics.blockA

    else
      block.color = {
        r = 255,
        g = 0,
        b = 0,
        a = 255,
      }
      block.image = graphics.blockB
      
    end

    block.state = 'dropping'
    
    block.offset = vector(block.image:getWidth() / 2, block.image:getHeight() / 2) 

  end)

function Block:reset(pos, block_kind)
    self.kind = block_kind
    self.position = pos
    self.state = 'dropping'
end

function Block:update()
  if self.state == 'dropping' then
    self.position.y = self.position.y + 1
  end
end
  
function Block:draw()
  -- These are offsets to shift the entire board
  local x_offset = boardOffset.x
  local y_offset = boardOffset.y
  
  local image = self.image
  local color = self.color

  if self.state == 'dead' then
    color = {
      r = 100,
      g = 100,
      b = 100,
      a = 255,
    }
  end
  
  love.graphics.setColor(
    color.r,
    color.g,
    color.b,
    color.a
    )
  
  love.graphics.draw(
    image,
    math.floor(self.position.x * (image:getWidth() * self.scale.x)) + boardOffset.x,
    math.floor(self.position.y * (image:getHeight() * self.scale.y)) + boardOffset.y,
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )
end

-- Return the blocks position in screen coordinates
function Block:getScreenPosition()
  return vector(math.floor(self.position.x * (self.image:getWidth() * self.scale.x)) + boardOffset.x,
                math.floor(self.position.y * (self.image:getHeight() * self.scale.y)) + boardOffset.y)
end

function Block:setState(state)
  self.state = state
end

function Block:shiftRight()
  self.position.x = self.position.x + 1
  if self.position.x > 16 then
    self.position.x = 0
  end
end

function Block:shiftLeft()
  self.position.x = self.position.x - 1
  if self.position.x < 0 then
    self.position.x = 16
  end
end

-- Take an objects position, siz, and movementVector and return a movement vector that prevents collision with the block
function Block:collideInScreenSpace(object, movementVector)
  -- Dont collide if the object is not moving
  if movementVector == vector(0,0) then
    return movementVector
  end
  
  -- Don't collide if the object is far away
  if object.position:dist(self:getScreenPosition()) > 32 then
    return movementVector
  end

  if movementVector.y > 0 then -- Object is falling
    if object:getRightScreenEdge() > self:getLeftScreenEdge() and
       object:getLeftScreenEdge() < self:getRightScreenEdge() + 1 and
       object:getBottomScreenEdge() > self:getTopScreenEdge() then
       movementVector.y = 0
       
       local difference = object:getBottomScreenEdge() - self:getTopScreenEdge()
       if math.abs(difference) < 4 then
         object.position.y = object.position.y - difference
        end
       object.onFloor = true
    end
  end


  if movementVector.x > 0 then -- Object is moving right
    if object:getBottomScreenEdge() > self:getTopScreenEdge() and
       object:getTopScreenEdge() < self:getBottomScreenEdge() + 1 and
       object:getRightScreenEdge() > self:getLeftScreenEdge() then
       movementVector.x = 0

       local difference = object:getRightScreenEdge() - self:getLeftScreenEdge()
       if math.abs(difference) < 4 then
         object.position.x = object.position.x - difference
       end
      end
  elseif movementVector.x < 0 then -- Object is movingleft
    if object:getBottomScreenEdge() > self:getTopScreenEdge() and
       object:getTopScreenEdge() < self:getBottomScreenEdge() + 1 and
       object:getLeftScreenEdge() < self:getRightScreenEdge() then
       movementVector.x = 0

       local difference = self:getRightScreenEdge() - object:getLeftScreenEdge()
       if math.abs(difference) < 4 then
         object.position.x = object.position.x + difference
       end


      end
  end
  
  return movementVector
end

function Block:getLeftScreenEdge()
  local pos = self:getScreenPosition()
  return pos.x - ( (self.image:getWidth() * self.scale.x) / 2)  
end

function Block:getRightScreenEdge()
  local pos = self:getScreenPosition()
  return pos.x + ( (self.image:getWidth() * self.scale.x) / 2)  
end

function Block:getTopScreenEdge()
  local pos = self:getScreenPosition()
  return pos.y - ( (self.image:getHeight() * self.scale.y) / 2)  
end

function Block:getBottomScreenEdge()
  local pos = self:getScreenPosition()
  return pos.y + ( (self.image:getHeight() * self.scale.y) / 2)  
end



function Block:isOffscreen()
  return self.position.y * (self.image:getHeight() * self.scale.y) + boardOffset.y > love.graphics:getHeight()
end