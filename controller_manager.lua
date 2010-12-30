-- 
--  controller_manager.lua
--  love-platformer
--  
--  Created by Jay Roberts on 2010-12-29.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

ControllerManager = class(function(mgr)
  local count = love.joystick.getNumJoysticks()
  if count > 0 then
    mgr.stickID = 0
    
    love.joystick.open(mgr.stickID)
    mgr.state = {
      joystick = {
        x = 0,
        y = 0
      },
      buttons = {
        a = false,
        b = false,
        x = false,
        y = false
      }
    }
    mgr.previous_state = {}
  else
    return nil
  end
end)

function ControllerManager:update(dt)
  self.previous_state = self.state;
  
  -- Dpad-Up 0
  -- Dpad-Left 1
  -- Dpad-Left 2
  -- Dpad-Right 3
  -- Start 4
  -- Back 5
  -- Left Stick 6
  -- Right Stick 7
  -- Left Bumper 8
  -- Right Bumper 9
  -- Guide 10
  -- A 11
  -- B 12
  -- X 13
  -- Y 14
  
  self.state.joystick.x, self.state.joystick.y = love.joystick.getAxes(self.stickID)

  self.state.buttons.start = love.joystick.isDown(self.stickID, 4)
  self.state.buttons.back = love.joystick.isDown(self.stickID, 5)
  self.state.buttons.guide = love.joystick.isDown(self.stickID, 10)

  self.state.buttons.lbumper = love.joystick.isDown(self.stickID, 8)
  self.state.buttons.rbumper = love.joystick.isDown(self.stickID, 9)

  self.state.buttons.a = love.joystick.isDown(self.stickID, 11)
  self.state.buttons.b = love.joystick.isDown(self.stickID, 12)
  self.state.buttons.x = love.joystick.isDown(self.stickID, 13)
  self.state.buttons.y = love.joystick.isDown(self.stickID, 14)
  
  
end