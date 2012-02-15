class Maze
  attr_reader :width, :height, :start

  def initialize(width, height)
    @start  = Square.new
    @width  = width.to_i
    @height = height.to_i
    invalid = @width == 0 || @height == 0

    raise Exception.new("Invalid parameters") if invalid
  end

  def explore!(square = start, x = 0, y = 0)
    square.visit!
  end
end
