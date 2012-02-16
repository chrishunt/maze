class Maze
  attr_reader :grid

  def initialize(width, height)
    @width    = width.to_i
    @height   = height.to_i
    @grid     = new_grid
    @explored = false
    invalid = @width == 0 || @height == 0

    raise Exception.new("Invalid parameters") if invalid
  end

  def explored?
    @explored
  end

  private

  def explore!(position = [0, 0], visited = [])
    return @explored = true unless position
    x, y = position

    @grid[x][y].visit!

    next_x, next_y = possible_moves(x, y).sample

    # Backtrack if we've reached a dead-end
    return explore!(visited.pop, visited) if next_x.nil?

    open_door = open_door(x, y, next_x, next_y)
    next_door = opposite_door(open_door)

    # Open a door from this square to the next
    @grid[x][y].doors << open_door
    @grid[next_x][next_y].doors << next_door

    # Explore the next square
    explore!([next_x, next_y], visited << [x, y])
  end

  def possible_moves(x, y)
    [[x,y-1], [x,y+1], [x-1,y], [x+1,y]].map do |x, y|
      [x, y] if square_open?(x, y)
    end.compact
  end

  def open_door(x, y, next_x, next_y)
    if x > next_x
      :left
    elsif x < next_x
      :right
    elsif y > next_y
      :up
    elsif y < next_y
      :down
    end
  end

  def opposite_door(door)
    case door
    when :left
      :right
    when :right
      :left
    when :up
      :down
    when :down
      :up
    end
  end

  def square_open?(x, y)
    x < @width  && x >= 0 &&
    y < @height && y >= 0 &&
    !@grid[x][y].visited?
  end

  def new_grid
    Array.new(@width) { Array.new(@height) { Square.new } }
  end
end
