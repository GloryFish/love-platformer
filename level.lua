-- 
--  level.lua
--  love-platformer
--  
--  Created by Jay Roberts on 2011-01-02.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

Level = class(function(level, name)
  level.scale = 2
  
  -- Load a map file which will give us a tileset image, 
  -- a set of quads for each image in the tileset indexed by
  -- an ascii character, a string representing the initial level layout,
  -- and the size of each tile in the tileset.
  level.tileset, level.quads, level.tileString, tileSize = love.filesystem.load(string.format('resources/maps/%s.lua', name))()

  -- Now we build an array of characters from the tileString
  level.tiles = {}

  local width = #(level.tileString:match("[^\n]+"))

  for x = 1, width, 1 do 
    level.tiles[x] = {} 
  end

  local x, y = 1, 1

  for row in level.tileString:gmatch("[^\n]+") do
    assert(#row == width, 'Map is not aligned: width of row ' .. tostring(y) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
    x = 1
    for character in row:gmatch(".") do
      level.tiles[x][y] = character
      x = x + 1
    end
    y = y + 1
  end
end)


function Level:draw()  
  for x, column in ipairs(self.tiles) do
    for y, char in ipairs(column) do
      love.graphics.drawq(self.tileset, 
                          self.quads[char], 
                          (x - 1) * tileSize * self.scale, 
                          (y - 1) * tileSize * self.scale,
                          0,
                          self.scale,
                          self.scale)
    end
  end
end