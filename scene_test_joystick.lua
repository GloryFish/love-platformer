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
  
end

function test_joystick.update(self, dt)
  test_joystick.logger:update(dt)
  controller:update(dt)
  
  test_joystick.logger:addLine(string.format('x: %f, y: %f', controller.state.joystick.x, controller.state.joystick.y))

  if controller.state.buttons.a then
    test_joystick.logger:addLine("A")
  end
  if controller.state.buttons.b then
    test_joystick.logger:addLine("B")
  end
  if controller.state.buttons.x then
    test_joystick.logger:addLine("X")
  end
  if controller.state.buttons.y then
    test_joystick.logger:addLine("Y")
  end

  if controller.state.buttons.start then
    test_joystick.logger:addLine("start")
  end

end

function test_joystick.draw(self)
  test_joystick.logger:draw()
end

function test_joystick.leave(self)
end