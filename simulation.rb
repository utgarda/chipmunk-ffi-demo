require 'rubygems'
require 'chipmunk-ffi'

class Simulation

  def visible_shapes
    @visible_shapes
  end

  def initialize
    @visible_shapes = []
    @space = CP::Space.new
  end

  def update(ticks = 0)
    @space.step 1.0/60.0
  end
end