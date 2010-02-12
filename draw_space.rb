
def draw_shape(shape)
  if shape.kind_of? Visible::Circle
    p = shape.body.p
    ellipse width / 2 + p.x, height / 2 - p.y, shape.rad, shape.rad
  end
end

def erase_shape(shape)
  if shape.kind_of? Visible::Circle
    p = shape.body.p
    rect width / 2 + p.x, height / 2 - p.y, shape.rad, shape.rad
  end
end

module Visible
  class Circle < CP::Shape::Circle

    def initialize(body, rad, offset_vec)
      super(body,rad,offset_vec)
      @rad = rad
    end

    def rad
      @rad
    end

  end
end