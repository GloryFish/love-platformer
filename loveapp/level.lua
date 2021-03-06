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
  level.tileset, level.quads, level.tileString, level.tileSize, level.gravity = love.filesystem.load(string.format('resources/maps/%s.lua', name))()

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

      -- Handle player start
      if character == 'P' then
        level:setPlayerStart(x, y)
        level.tiles[x][y] = ' '
      else
        level.tiles[x][y] = character
      end
      x = x + 1
    end
    y = y + 1
  end
end)

function Level:setPlayerStart(x, y)
  -- playerStart should be placed in the center of the tile so we need to offset the world coordinates by half tileSize
  local coords = self:toWorldCoords(vector(x, y))
  self.playerStart = coords + vector(math.floor(self.tileSize * self.scale / 2), math.floor(self.tileSize * self.scale / 2))
end

function Level:draw()
  love.graphics.setColor(255, 255, 255, 255)
  for x, column in ipairs(self.tiles) do
    for y, char in ipairs(column) do
      love.graphics.draw(self.tileset,
                         self.quads[char],
                         (x - 1) * self.tileSize * self.scale,
                         (y - 1) * self.tileSize * self.scale,
                         0,
                         self.scale,
                         self.scale)
    end
  end
end

function Level:getWidth()
  return #self.tiles * self.tileSize * self.scale
end

function Level:getHeight()
  return #self.tiles[1] * self.tileSize * self.scale
end

function Level:pointIsWalkable(point)
  local tilePoint = self:toTileCoords(point)
  tilePoint = tilePoint + vector(1, 1)

  if self.tiles[tilePoint.x] ~= nil then
    if self.tiles[tilePoint.x][tilePoint.y] == '#' then
      return false
    end
  end

  return true
end

-- This function takes a world point returns the Y position of the top edge of the matching tile in world space
function Level:floorPosition(point)
  local y = math.floor(point.y / (self.tileSize * self.scale))

  return y * (self.tileSize * self.scale)
end


function Level:toWorldCoords(point)
  local world = vector(
    (point.x - 1) * self.tileSize * self.scale,
    (point.y - 1) * self.tileSize * self.scale
  )

  return world
end

function Level:toTileCoords(point)
  local coords = vector(math.floor(point.x / (self.tileSize * self.scale)),
                        math.floor(point.y / (self.tileSize * self.scale)))

  return coords
end