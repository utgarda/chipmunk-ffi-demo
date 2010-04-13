class Simulation
  attr_reader :visible_shapes

  def initialize
    @visible_shapes = []
    @space = CP::Space.new
    @mouse_body = CP::Body.new CP::INFINITY, CP::INFINITY
  end

  def update(ticks = 0)
    @space.step 1.0/60.0
  end

  def grab(point)
    release
    @last_mouse_point = point
    shape = @space.point_query_first(point, CP::ALL_ONES, 0)
    if (shape)
      @mouse_joint = CP::PivotJoint.new @mouse_body, shape.body, CP::ZERO_VEC_2, shape.body.world2local(point)
      @mouse_joint.max_force = 50000.0
      @mouse_joint.bias_coef = 0.15
      @space.add_constraint @mouse_joint
    end
  end

  def release
    if @mouse_joint
      @space.remove_constraint @mouse_joint
      @mouse_joint = nil
    end
  end

  def drag(point)
    if @mouse_joint
      new_point = @last_mouse_point.lerp(point, 0.25)
      @mouse_body.p = new_point
      @mouse_body.v = (new_point - @last_mouse_point) * 60
      @last_mouse_point = new_point
    end
  end

end