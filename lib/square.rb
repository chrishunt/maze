class Square
  attr_accessor :left, :right, :up, :down, :doors

  def initialize
    @visited = false
    @doors   = []
  end

  def visited?
    @visited
  end

  def visit!
    @visited = true
  end

  def has_neighbor?
   left  && !left.visited?  ||
   right && !right.visited? ||
   up    && !up.visited?    ||
   down  && !down.visited?  ? true : false
  end
end
