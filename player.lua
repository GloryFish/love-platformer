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
  player.offset = vector(player.tileSize / 2, player.tileSize / 2)

  player.quads = {}
  player.quads.standing = love.graphics.newQuad(0, 0, player.tileSize, player.tileSize, player.tileset:getWidth(), player.tileset:getHeight())

  player.flip = -1

  player.position = pos
  
  player.speed = 100
end)


function Player:movingRight()
  self.flip = 1
end

function Player:movingLeft()
  self.flip = -1
end

function Player:update(dt)
end
  
function Player:draw()
  love.graphics.setColor(255, 255, 255, 255)
  
  love.graphics.drawq(self.tileset,
                      self.quads.standing, 
                      self.position.x, 
                      self.position.y,
                      0,
                      self.scale * self.flip,
                      self.scale,
                      self.offset.x,
                      self.offset.y)
  
end