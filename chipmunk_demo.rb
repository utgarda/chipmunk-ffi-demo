require 'rubygems'
require 'chipmunk-ffi'
require 'simple'
require 'draw_space'

class Sketch < Processing::App

  def setup
    smooth
    no_stroke
    frame_rate 30
    rect_mode RADIUS

    @demo = Simple.new
    @demo.init

    @frame_count = 0
  end


  def draw
    @frame_count += 1

    # erase previous screen
    if @frame_count == 1
      background 51
    else
      fill 51
      @demo.visible_shapes.each {|shape|
        erase_shape shape
      }
    end

    @demo.update    

    fill 240
    @demo.visible_shapes.each {|shape|
        draw_shape shape
    }

  end

end


Sketch.new(:width => 400, :height => 400, :title => "Chipmunk Demos")
