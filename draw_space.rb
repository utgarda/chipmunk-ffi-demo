require 'matrix'

class Vector #TODO consider using PVector from Processing instead
  def x
    self[0]
  end

  def y
    self[1]
  end
end


module Visible

  def vec2_line(v1, v2)
    line v1.x, v1.y, v2.x, v2.y
  end

  def pos
    Vector[body.p.x, body.p.y]
  end

  def body_translate
    translate pos.x, pos.y
    rotate body.angle
  end

  class Circle < CP::Shape::Circle
    include Visible

    def initialize(body, rad, offset_vec)
      super(body, rad, offset_vec)
      @rad = rad
    end

    def rad
      @rad
    end

    def draw
      body_translate

      ellipse 0, 0, @rad, @rad

      4.times{
        rotate HALF_PI
        vec2_line Vector[0, @rad*0.75], Vector[0, @rad]
      }
    end
  end

  class Segment < CP::Shape::Segment
    include Visible

    def initialize(body, v1, v2, r)
      super(body, v1, v2, r)
      @v1 = Vector[v1.x, v1.y]
      @v2 = Vector[v2.x, v2.y]
      @r  = r
    end

    def draw
      body_translate
      vec2_line @v1, @v2
    end
  end

end