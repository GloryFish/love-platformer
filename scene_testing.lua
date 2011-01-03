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

testing = Gamestate.new()

function testing.enter(self, pre)
  testing.logger = Logger(vector(10, 10))
  controller = ControllerManager()
  
  tileWidth, tileHeight = 16, 16 -- 10 x 6
  tilesetWidth, tilesetHeight = 160, 112
  
  ninjatiles = love.graphics.newImage('resources/ninja.png')
  
  local quadInfo = { 
    { ' ', 5 * tileWidth, 0 * tileHeight}, -- 1 = grass 
    { '#', 9 * tileWidth, 6 * tileHeight}, -- 2 = box
  }

  quads = {}
  for _,info in ipairs(quadInfo) do
    -- info[1] = character, info[2]= x, info[3] = y
    quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileWidth, tileHeight, tilesetWidth, tilesetHeight)
  end

  
  local tileString = [[
                         
          #              
                         
                         
     #     #             
    ##############  #    
#########################
]]
  
    
    TileTable = {}

    local width = #(tileString:match("[^\n]+"))

    for x = 1,width,1 do TileTable[x] = {} end

    local x,y = 1,1
    for row in tileString:gmatch("[^\n]+") do
      assert(#row == width, 'Map is not aligned: width of row ' .. tostring(y) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
      x = 1
      for character in row:gmatch(".") do
        TileTable[x][y] = character
        x = x + 1
      end
      y=y+1
    end
    
end

function testing.update(self, dt)
  testing.logger:update(dt)
  -- testing.logger:addLine(string.format('Particles: %i', particles:count()))
  controller:update(dt)
  
end

function testing.draw(self)
  testing.logger:draw()
  controller:draw(dt)


  for x,column in ipairs(TileTable) do
    for y,char in ipairs(column) do
      love.graphics.drawq(ninjatiles, quads[char], (x - 1) * tileWidth, (y - 1) * tileHeight)
    end
  end
  
end

function testing.leave(self)
end