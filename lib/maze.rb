class Maze
  def initialize(width, height)
    @width  = width.to_i
    @height = height.to_i
    invalid = @width == 0 || @height == 0
    raise Exception.new("Invalid parameters") if invalid
  end
end
