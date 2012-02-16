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
    has_left_neighbor?  ||
    has_right_neighbor? ||
    has_down_neighbor?  ||
    has_up_neighbor?
  end

  %w(left right down up).each do |direction|
    define_method "has_#{direction}_neighbor?" do
      square = self.send(direction)
      !(square.nil? || square.visited?)
    end
  end
end
