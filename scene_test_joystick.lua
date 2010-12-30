-- 
--  scene_test_joystick.lua
--  love-platformer
--  
--  Created by Jay Roberts on 2010-12-25.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'logger'
require 'vector'
require 'controller_manager'

test_joystick = Gamestate.new()

function test_joystick.enter(self, pre)
  test_joystick.logger = Logger(vector(10, 10))
  controller = ControllerManager()
  controller.debug = true
end

function test_joystick.update(self, dt)
  test_joystick.logger:update(dt)
  controller:update(dt)
  
  if controller.state.buttons.back then
    love.event.push('q')
  end
end

function test_joystick.draw(self)
  test_joystick.logger:draw()
  controller:draw()
end

function test_joystick.leave(self)
end