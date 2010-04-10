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

  def grab(point)
    @space.point_query_first(point, CP::ALL_ONES, 0)
  end

  def release

  end
end