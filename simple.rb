require 'rubygems'
require 'chipmunk-ffi'
require 'draw_space'
require 'simulation'

class Simple < Simulation

  def initialize
    super
    init_space
    declare_visible_shapes
  end

  def init_space
#  Create an infinite mass body to attach ground segments and other static geometry to.
#  We won't be adding this body to the space, because we don't want it to be simulated at all.
#  Adding bodies to the space simulates them. (fall under the influence of gravity, etc)
#  We want the static body to stay right where it is at all times.
    static_body = CP::Body.new CP::INFINITY, CP::INFINITY

#  Create a space, a space is a simulation world. It simulates the motions of rigid bodies,
#  handles collisions between them, and simulates the joints between them.
    @space = CP::Space.new

#  Lets set some parameters of the space:
#  More iterations make the simulation more accurate but slower
    @space.iterations = 10

#  These parameters tune the efficiency of the collision detection.
#  For more info: http://code.google.com/p/chipmunk-physics/wiki/cpSpace
    @space.resize_static_hash 30.0, 1000
    @space.resize_active_hash 30.0, 1000

#  Give it some gravity
    @space.gravity = CP::Vec2.new 0, -1100

#  Set some parameters of the shape.
#  For more info: http://code.google.com/p/chipmunk-physics/wiki/cpShape
    @ground = Visible::Segment.new static_body, CP::Vec2.new(-320, -240), CP::Vec2.new(320, -240), 0.0 #CP::Shape::Segment.new static_body, CP::Vec2.new(-320, -240), CP::Vec2.new(320, -240), 0.0

#  Set some parameters of the shape.
#  For more info: http://code.google.com/p/chipmunk-physics/wiki/cpShape
    @ground.e = 1.0
    @ground.u = 1.0

#TODO ground->layers = NOT_GRABABLE_MASK; // Used by the Demo mouse grabbing code

#  Add the shape to the space as a static shape
#  If a shape never changes position, add it as static so Chipmunk knows it only needs to
#  calculate collision information for it once when it is added.
#  Do not change the postion of a static shape after adding it.
    @space.add_static_shape @ground

#  Add a moving circle object.
    radius = 15.0
    mass = 10.0

#  This time we need to give a mass and moment of inertia when creating the circle.
    ball_body = CP::Body.new mass, CP::moment_for_circle(mass, 0.0, radius, CP::ZERO_VEC_2)

#  Set some parameters of the body:
#  For more info: http://code.google.com/p/chipmunk-physics/wiki/cpBody

# Set the initial position
    ball_body.p = CP::Vec2.new 0, -100 + radius+5
# Set the initial angular speed
    ball_body.w = 1

# Add the body to the space so it will be simulated and move around.
    @space.add_body ball_body

#  Add a circle shape for the ball.
#  Shapes are always defined relative to the center of gravity of the body they are attached to.
#  When the body moves or rotates, the shape will move with it.
#  Additionally, all of the cpSpaceAdd*() functions return the thing they added so you can create and add in one go.
    @ball_shape = @space.add_shape Visible::Circle.new(ball_body, radius, CP::ZERO_VEC_2) #CP::Shape::Circle.new(ball_body, radius, CP::ZERO_VEC_2)
    @ball_shape.e = 0.0
    @ball_shape.u = 0.9
  end

  def declare_visible_shapes
    @visible_shapes << @ground    
    @visible_shapes << @ball_shape
  end

#Update is called by the demo code each frame.
  def update(ticks = 0)
#  Chipmunk allows you to use a different timestep each frame, but it works much better when you use a fixed timestep.
#  An excellent article on why fixed timesteps for game logic can be found here: http://gafferongames.com/game-physics/fix-your-timestep/
#  cpSpaceStep(space, 1.0f/60.0f);
    @space.step 1.0/60.0
  end

end