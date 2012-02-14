require 'maze'

describe Maze do
  describe '#initialize' do
    it 'accepts a width and height' do
      lambda{ Maze.new(10, 10) }.should_not raise_error
    end

    it 'raises exception when missing parameters' do
      lambda{ Maze.new }.should raise_error
      lambda{ Maze.new(10) }.should raise_error
    end

    it 'raises exception when parameters are invalid' do
      lambda{ Maze.new(1.1, 0) }.should raise_error
      lambda{ Maze.new('invalid', 5) }.should raise_error
    end
  end
end
