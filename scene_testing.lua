-- 
--  scene_test.lua
--  love-platformer
--  
--  Created by Jay Roberts on 2010-12-25.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'logger'
require 'vector'

testing = Gamestate.new()

function testing.enter(self, pre)
  testing.logger = Logger(vector(10, 10))
  
  love.joystick.open(1)
  
end

function testing.update(self, dt)
  testing.logger:update(dt)
  testing.logger:addLine('Testing...')
  
  
  local x, y = love.joystick.getAxes(1)
  testing.logger:addLine(string.format('Joystick x: %f y: %f', x, y))
  
end

function testing.draw(self)
  testing.logger:draw()
end

function testing.leave(self)
end