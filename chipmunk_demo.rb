require 'rubygems'
require 'chipmunk-ffi'
require 'simple'
require 'jruby'


class Sketch < Processing::App
  include Visible

  def setup
    JRuby.objectspace=true

    frame_rate 30

    rect_mode RADIUS
    ellipse_mode RADIUS

    smooth
    stroke 255
    stroke_weight 2
    no_fill

    @demo = Simple.new
  end


  def draw
    background 51

    @demo.update

    @demo.visible_shapes.each do|shape|

      # Resetting all transformations possibly done by previous shapes' draw() method calls
      reset_matrix

      # Drawing our stuff around the center of Processing window, not upper-left corner
      translate width/2, height/2

      # In Chipmunk's demos Y axis is directed the other way , so we flip it
      scale 1, -1

      stroke shape == @shape_grabbed ? 200 : 255

      shape.draw
    end

  end

  def mouse_pressed
    @shape_grabbed = @demo.grab(mouse_to_space)
  end

  def mouse_released
    @demo.release
    @shape_grabbed = nil
  end

  def mouse_to_space
    vec2(mouse_x - width/2, height/2 - mouse_y)
  end

end


Sketch.new(:width => 600, :height => 600, :title => "Chipmunk Demos")
