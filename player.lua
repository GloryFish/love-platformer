-- 
--  player.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

Player = class(function(player, pos)
  player.tileset = love.graphics.newImage('resources/ninja.png')
  player.tileset:setFilter('nearest', 'nearest')
  player.tileSize = 16
  player.scale = 2

  player.quads = {}
  player.quads.standing = love.graphics.newQuad(0, 0, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight())

  player.position = pos
end)


function Player:update(dt)
end
  
function Player:draw()
  
  love.graphics.setColor(255, 255, 255, 255)
  
  love.graphics.drawq(self.tileset,
                      self.quads.standing, 
                      self.position.x * self.scale, 
                      self.position.y * self.scale,
                      0,
                      self.scale,
                      self.scale)
  
end