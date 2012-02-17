require './lib/square'
require './lib/maze'

if ARGV.size < 2
  puts "Usage: maze.rb [WIDTH] [HEIGHT]"
  raise Exception.new('Missing maze dimensions')
end

puts Maze.new(*ARGV).to_html
