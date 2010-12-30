-- 
--  main.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'gamestate'
require 'scene_testing'
require 'scene_test_joystick'

function love.load()
  love.graphics.setCaption('Love Platformer')
  
  -- Seed random
  local seed = os.time()
  math.randomseed(seed);
  math.random(); math.random(); math.random()  
  
  fonts = {
    default = love.graphics.newFont('resources/fonts/silk.ttf', 24)
  }
  
  Gamestate.registerEvents()
  Gamestate.switch(testing)
end

function love.update(dt)
end