class Square
  attr_reader :doors

  def initialize
    @visited = false
    @doors   = []
  end

  def visited?
    @visited
  end

  def visit!
    @visited = true
    self
  end
end
