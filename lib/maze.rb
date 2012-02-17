class Maze
  attr_reader :squares

  def initialize(width, height)
    @width    = width.to_i
    @height   = height.to_i
    @squares  = new_squares
    @explored = false

    invalid = @width == 0 || @height == 0

    raise Exception.new("Invalid parameters") if invalid
  end

  def explored?
    @explored
  end

  def to_html
    explore! unless explored?

    <<-HTML
      <!DOCTYPE html>
      <html>
      #{html_head}
      <body>
        #{html_maze}
      </body>
      </html>
    HTML
  end

  private

  def explore!(position = [0, 0], visited = [])
    return @explored = true unless position

    x, y = position
    @squares[x][y].visit!
    next_x, next_y = possible_moves(x, y).sample

    return explore!(visited.pop, visited) if next_x.nil?

    open_door = open_door(x, y, next_x, next_y)
    next_door = opposite_door(open_door)
    @squares[x][y].doors << open_door
    @squares[next_x][next_y].doors << next_door

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
    !@squares[x][y].visited?
  end

  def new_squares
    Array.new(@width) { Array.new(@height) { Square.new } }
  end

  def html_head
    <<-HTML
      <head>
      <title>Maze</title>
      <style type="text/css">
        * { margin: 0; padding: 0; }

        body { background: #eee; }
        #maze { margin: 20px; }
        .row { height: 20px; }

        .square {
          position: relative;
          float: left;
          background: #ddd;
          height: 20px;
          width: 20px;
        }

        .up, .left, .right, .down, .ul, .ur, .dl, .dr {
          position: absolute;
          background: #888;
        }

        .open { background: #ddd; }
        .gate { background: #f22; }

        .up, .down { width: 12px; height: 4px; left: 4px; }
        .up   { top: 0; }
        .down { bottom: 0; }

        .left, .right { width: 4px; height: 12px; top: 4px; }
        .left { left: 0; }
        .right { right: 0; }

        .ul, .ur, .dl, .dr { width: 4px; height: 4px; }
        .ul, .ur { top: 0px; }
        .dl, .dr { bottom: 0px; }
        .ul, .dl { left: 0px; }
        .ur, .dr { right: 0px; }
      </style>
      </head>
    HTML
  end

  def html_maze
    html = "<div id='maze'>"
    (0..@height - 1).each do |y|
      html += "<div class='row'>"
      (0..@width - 1).each do |x|
        html += html_square(x, y)
      end
      html += "</div>"
    end
    html += "</div>"
  end

  def html_square(x, y)
    square = @squares[x][y]
    html = "<div class='square'>"
    [:ul, :ur, :dl, :dr].each do |corner|
      html += "<div class='#{corner.to_s}'></div>"
    end

    [:up, :left, :right, :down].each do |edge|
      first = edge == :left && (x == 0 && y == 0)
      last = edge == :right && (x == @width - 1 && y == @height - 1)
      gate = first || last
      open = square.doors.include?(edge)
      style = "#{edge.to_s}#{' open' if open}#{' gate' if gate}"
      html += "<div class='#{style}'></div>"
    end
    html += "</div>"
  end
end
