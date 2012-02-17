class Square
  attr_reader :doors

  def initialize
    @visited = false
    @doors   = []
  end

  def visited?
    @visited
  end

  def unvisited?
    !@visited
  end

  def visit!
    @visited = true
  end
end
