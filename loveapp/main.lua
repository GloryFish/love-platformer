--
--  main.lua
--  redditgamejam-04
--
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
--

require 'gamestate'
require 'input'
require 'scene_menu'

function love.load()
  love.window.setTitle('Love Platformer')

  -- Seed random
  local seed = os.time()
  math.randomseed(seed);
  math.random(); math.random(); math.random()

  fonts = {
    default = love.graphics.newFont('resources/fonts/silk.ttf', 24),
    large =  love.graphics.newFont('resources/fonts/silk.ttf', 48)
  }


  input = Input()

  Gamestate.registerEvents()
  Gamestate.switch(menu)
end

function love.update(dt)
end


