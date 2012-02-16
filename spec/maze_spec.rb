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

  describe 'attributes' do
    subject { Maze.new(5, 10) }

    it 'has a width' do
      subject.width.should == 5
    end

    it 'has a height' do
      subject.height.should == 10
    end

    it 'has a start square' do
      subject.start.class.should == Square
    end
  end

  describe '#explore!' do
    subject { Maze.new(5, 10) }

    it 'marks start as visited' do
      subject.explore!
      subject.start.visited?.should == true
    end

    it 'marks passed-in square as visited' do
      square = Square.new
      square.visited?.should == false
      subject.explore!(square)
      square.visited?.should == true
    end

    it 'accepts an x and y coordinate' do
      square = Square.new
      lambda{ subject.explore!(square, 0, 0) }.should_not raise_error
    end
  end
end
