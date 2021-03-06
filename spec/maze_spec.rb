require 'maze_spec_helper'
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

    it 'raises exception with non-positve maze dimensions' do
      [[1.1, 0], [-1, 1], ['invalid', 5]].each do |x, y|
        lambda{ Maze.new(x, y) }.should raise_error("Invalid maze dimensions")
      end
    end
  end

  describe '#to_html' do
    subject { Maze.new(5, 10) }

    it 'explores the maze if unexplored' do
      subject.explored?.should == false
      subject.to_html
      subject.explored?.should == true
    end

    it 'returns html tags' do
      subject.to_html.should =~ /<html>/
      subject.to_html.should =~ /<head>/
      subject.to_html.should =~ /maze/
      subject.to_html.should =~ /square/
    end
  end

  describe '#explore!' do
    subject { Maze.new(5, 10) }

    it 'visits all squares' do
      subject.send(:explore!)
      subject.squares.each do |column|
        column.each do |square|
          square.visited?.should == true
        end
      end
    end

    it 'opens doors in each square' do
      subject.send(:explore!)
      subject.squares.each do |column|
        column.each do |square|
          square.doors.size.should > 0
        end
      end
    end

    it 'marks this maze as explored' do
      subject.explored?.should == false
      subject.send(:explore!)
      subject.explored?.should == true
    end
  end

  describe '#new_squares' do
    let(:width)  {  5 }
    let(:height) { 10 }

    subject { Maze.new(width, height).send(:new_squares) }

    it 'returns a new grid with the correct dimensions' do
      subject.size.should == width
      subject.first.size.should == height
    end

    it 'returns a grid containing unvisited squares' do
      subject.each do |column|
        column.each do |square|
          square.visited?.should == false
        end
      end
    end
  end

  describe '#possible_moves' do
    subject do
      #   _ _ _ _ _ _ _ _ _ _
      # 0|X|X|X|X| | | | | | |
      # 1| |X|X|X| | | | | | |
      # 2| | |X| | | | | | | |
      # 3| | | | | | | | | | |
      # 4| | | | | | | | | | |
      #   - - - - - - - - - -
      #   0 1 2 3 4 5 6 7 8 9
      maze = Maze.new(10, 5)
      [[0,0], [1,0], [2,0], [3,0], [3,1], [1,1], [2,1], [2,2]].each do |x, y|
        maze.squares[x][y].visit!
      end
      maze
    end

    it 'returns correct moves for open square' do
      expected = [[6,3], [4,3], [5,2], [5,4]]
      result   = subject.send(:possible_moves, 5, 3)
      compare_move_sets(expected, result)
    end

    it 'returns correct moves for square with one blocked side' do
      expected = [[2,3], [1,2], [3,2]]
      result   = subject.send(:possible_moves, 2, 2)
      compare_move_sets(expected, result)
    end

    it 'returns correct moves for square with two blocked sides' do
      expected = [[1,2], [0,1]]
      result   = subject.send(:possible_moves, 1, 1)
      compare_move_sets(expected, result)
    end

    it 'returns correct moves for fully blocked square' do
      expected = []
      result   = subject.send(:possible_moves, 2, 1)
      compare_move_sets(expected, result)
    end

    it 'returns correct moves for edge square' do
      expected = [[6,1], [5,0], [7,0]]
      result   = subject.send(:possible_moves, 6, 0)
      compare_move_sets(expected, result)
    end

    it 'returns correct moves for corner square' do
      expected = [[8,0], [9,1]]
      result   = subject.send(:possible_moves, 9, 0)
      compare_move_sets(expected, result)
    end
  end
end
