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

  if input == nil then
    require 'input'
    input = Input()
  end

  local particleImage = love.graphics.newImage('resources/dust.png')
  particleImage:setFilter('nearest', 'nearest')

  particle_test.particles = love.graphics.newParticleSystem(particleImage, 500)

  particle_test.ppos = vector(400, 300)
  particle_test.pspeed = 500

	particle_test.particles:setEmissionRate(500)
	particle_test.particles:setSpeed(300, 800)
	particle_test.particles:setLinearAcceleration(0, 0, 0, 0)
	particle_test.particles:setSizes(2, 1)
	particle_test.particles:setColors(255, 255, 255, 255, 58, 128, 255, 0)
	particle_test.particles:setPosition(particle_test.ppos.x, particle_test.ppos.y)
	particle_test.particles:setEmitterLifetime(-1)
	particle_test.particles:setParticleLifetime(1)
	particle_test.particles:setDirection(0)
	particle_test.particles:setSpread(360)
	particle_test.particles:setRadialAcceleration(-2000)
	particle_test.particles:setTangentialAcceleration(1000)
  particle_test.particles:setRotation(0, 4)
  particle_test.particles:setSpin(-3, 3)

  particle_test.particles:start()


  -- particles:setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  -- particles:setSpeed(10, 50)
  -- particles:setColor(255, 255, 255, 255, 255, 255, 255, 0)
  -- particles:setSprite(particleImage)


end

function particle_test.update(self, dt)
  particle_test.logger:update(dt)
  -- testing.logger:addLine(string.format('Particles: %i', particles:count()))
  input:update(dt)

  particle_test.particles:setPosition(particle_test.ppos.x, particle_test.ppos.y)
  particle_test.ppos = particle_test.ppos + (input.state.movement * particle_test.pspeed * dt)

	particle_test.particles:setEmissionRate(100)
	particle_test.particles:setSpeed(50, 100)
	particle_test.particles:setColors(255, 255, 255, 255, 100, 100, 100, 0)

  if input.state.buttons.fire then
    particle_test.particles:setEmissionRate(500)
  	particle_test.particles:setSpeed(300, 1000)
  	particle_test.particles:setColors(255, 200, 200, 255, 255, 100, 100, 0)
  end

  if input.state.buttons.newpress.back then
    Gamestate.switch(menu)
  end

  particle_test.particles:update(dt)

end

function particle_test.draw(self)
  particle_test.logger:draw()
  love.graphics.draw(particle_test.particles)
end

function particle_test.leave(self)
end