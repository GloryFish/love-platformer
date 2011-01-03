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
  player = Player(vector(200, 16))
  
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  
end

function testing.update(self, dt)
  testing.logger:update(dt)
  -- testing.logger:addLine(string.format('Particles: %i', particles:count()))
  controller:update(dt)

  player:setMovement(controller.state.joystick)
  
  if controller.state.joystick:len() > 0.1 then
    player:setState('walking')
  else
    player:setState('standing')
  end

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