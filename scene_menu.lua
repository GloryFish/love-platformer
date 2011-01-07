-- 
--  scene_menu.lua
--  love-platformer
--  
--  Created by Jay Roberts on 2011-01-06.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 
require 'vector'

-- Game scenes
require 'scene_game'
require 'scene_testing'
require 'scene_particles'

menu = Gamestate.new()

function menu.enter(self, pre)
  menu.entries = {
    {
      title = 'IRC scene',
      scene = game,
      level = 'irc'
    },
    {
      title = 'Steps',
      scene = game,
      level = 'steps'
    },
    {
      title = 'Testing scene',
      scene = testing
    },
    {
      title = 'Particles',
      scene = particle_test
    }
  }
  
  menu.colors = {
    text = {
      r = 255,
      g = 255,
      b = 255,
      a = 255
    },
    highlight = {
      r = 0,
      g = 0,
      b = 0,
      a = 255
    },
    background = {
      r = 200,
      g = 200,
      b = 220,
      a = 255
    }
  }
  
  menu.position = vector(100, 100)
  
  menu.lineHeight = 20
  
  menu.index = 1
  
end

function menu.update(self, dt)
  input:update(dt)
  
  if input.state.buttons.newpress.down then
    menu.index = menu.index + 1
    if menu.index > #menu.entries then
      menu.index = 1
    end
  end

  if input.state.buttons.newpress.up then
    menu.index = menu.index - 1
    if menu.index < 1 then
      menu.index = #menu.entries
    end
  end
  
  if input.state.buttons.newpress.select then
    if menu.entries[menu.index].level ~= nil then
      menu.entries[menu.index].scene.level = menu.entries[menu.index].level
    end
    
    Gamestate.switch(menu.entries[menu.index].scene)
  end

  if input.state.buttons.newpress.cancel then
    love.event.push('q')
  end
end

function menu.draw(self)
  love.graphics.setFont(fonts.default)
  
  love.graphics.setBackgroundColor(self.colors.background.r,
                                   self.colors.background.g,
                                   self.colors.background.b,
                                   self.colors.background.a);

  local currentLinePosition = 0
  
  for index, entry in pairs(self.entries) do
    love.graphics.setColor(self.colors.text.r,
                           self.colors.text.g,
                           self.colors.text.b,
                           self.colors.text.a);

    if index == self.index then
      love.graphics.setColor(self.colors.highlight.r,
                             self.colors.highlight.g,
                             self.colors.highlight.b,
                             self.colors.highlight.a);
    end

    love.graphics.print(entry.title, 
                        self.position.x, 
                        self.position.y + currentLinePosition);

    currentLinePosition = currentLinePosition + self.lineHeight;
  end
end

function menu.leave(self)
end