require 'rubygems'
require 'chipmunk-ffi'
require 'simple'


class Sketch < Processing::App
  include Visible

  def setup
    frame_rate 30

    rect_mode RADIUS
    ellipse_mode RADIUS

    smooth
    stroke 255
    stroke_weight 2
    no_fill

    @demo = Simple.new
    @demo.init
  end


  def draw
    background 51

    @demo.update

    @demo.visible_shapes.each do|shape|

      # Resetting all transformations possibly done by previous shapes' draw() method calls
      reset_matrix

      # Drawing our stuff aroung the center of Processing window, not upper-left corner
      translate width/2, height/2

      # In Chipmunk's demos Y axis is directed the other way , so we flip it'
      scale 1, -1
      
      shape.draw
    end
  end

end


Sketch.new(:width => 600, :height => 600, :title => "Chipmunk Demos")
