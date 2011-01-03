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

particle_test = Gamestate.new()

function particle_test.enter(self, pre)
  particle_test.logger = Logger(vector(10, 10))
  controller = ControllerManager()
  
  local particleImage = love.graphics.newImage('resources/square.png')
  
  particles = love.graphics.newParticleSystem(particleImage, 500)
  
  ppos = vector(400, 300)
  pspeed = 500
  
	particles:setEmissionRate(500)
	particles:setSpeed(300, 800)
	particles:setGravity(0)
	particles:setSize(2, 1)
	particles:setColor(255, 255, 255, 255, 58, 128, 255, 0)
	particles:setPosition(ppos.x, ppos.y)
	particles:setLifetime(-1)
	particles:setParticleLife(1)
	particles:setDirection(0)
	particles:setSpread(360)
	particles:setRadialAcceleration(-2000)
	particles:setTangentialAcceleration(1000)
  particles:setRotation(0, 4)
  particles:setSpin(-3, 3)

  particles:start()


  -- particles:setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  -- particles:setSpeed(10, 50)
  -- particles:setColor(255, 255, 255, 255, 255, 255, 255, 0)
  -- particles:setSprite(particleImage)
  
  
end

function particle_test.update(self, dt)
  particle_test.logger:update(dt)
  -- testing.logger:addLine(string.format('Particles: %i', particles:count()))
  controller:update(dt)
  
  particles:setPosition(ppos.x, ppos.y)
  ppos = ppos + (controller.state.joystick * pspeed * dt)

	particles:setEmissionRate(100)
	particles:setSpeed(50, 100)
	particles:setColor(255, 255, 255, 255, 100, 100, 100, 0)

  if controller.state.buttons.b then
    particles:setEmissionRate(500)
  	particles:setSpeed(300, 1000)
  	particles:setColor(255, 200, 200, 255, 255, 100, 100, 0)
  elseif controller.state.buttons.a then
    particles:setEmissionRate(500)
  	particles:setSpeed(300, 1000)
  	particles:setColor(200, 255, 200, 255, 100, 255, 100, 0)
  elseif controller.state.buttons.x then
    particles:setEmissionRate(500)
  	particles:setSpeed(300, 1000)
  	particles:setColor(200, 200, 255, 255, 100, 100, 255, 0)
  end
  
  if controller.state.buttons.back then
    love.event.push('q')
  end
  
  particles:update(dt)
  
end

function particle_test.draw(self)
  particle_test.logger:draw()
  controller:draw(dt)
  love.graphics.draw(particles)
end

function particle_test.leave(self)
end