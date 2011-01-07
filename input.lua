-- 
--  input.lua
--  love-platformer
--  
--  Created by Jay Roberts on 2011-01-06.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'
require 'controller_manager'
require 'utility'

Input = class(function(input)
  input.controller = ControllerManager()
  
  input.state = {
    movement = vector(0, 0),
    buttons = {
      jump = false,
      fire = false,
      back = false,
      start = false,
      newpress = {
        jump = false,
        fire = false,
        back = false,
        start = false,
      }
    }
  }

  input.previous_state = {}
  
end)


function Input:update(dt)
  self.previous_state = deepcopy(self.state);
  
  self.state.movement = vector(0, 0)
  
  -- Get keyboard movement
  if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
    self.state.movement.x = -1
  elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
    self.state.movement.x = 1
  end
  if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
    self.state.movement.y = -1
  elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
    self.state.movement.y = 1
  end
  
  -- Get keyboard buttons
  self.state.buttons.jump = love.keyboard.isDown('z')
  self.state.buttons.fire = love.keyboard.isDown('x')
  self.state.buttons.back = love.keyboard.isDown('escape')
  self.state.buttons.start = love.keyboard.isDown('enter')

  -- Get controller movement
  if self.controller.enabled then
    self.controller:update(dt)

    if self.controller.state.joystick ~= vector(0, 0) then 
      self.state.movement = self.controller.state.joystick
    end
    
    if self.controller.state.buttons.a then
      self.state.buttons.jump = true
    end
    if self.controller.state.buttons.x then
      self.state.buttons.fire = true
    end
    if self.controller.state.buttons.back then
      self.state.buttons.back = true
    end
    if self.controller.state.buttons.start then
      self.state.buttons.start = true
    end
  end
  
  -- Check for new button presses
  self.state.buttons.newpress.jump  = self.state.buttons.jump  and not self.previous_state.buttons.jump 
  self.state.buttons.newpress.fire  = self.state.buttons.fire  and not self.previous_state.buttons.fire 
  self.state.buttons.newpress.start = self.state.buttons.start and not self.previous_state.buttons.start 
  self.state.buttons.newpress.back  = self.state.buttons.back  and not self.previous_state.buttons.back 
end