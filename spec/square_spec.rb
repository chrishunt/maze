require 'square'

describe Square do
  subject { Square.new }

  describe 'attributes' do
    it 'has a collection of doors' do
      subject.doors.should == []
    end

    it 'doors can be added' do
      subject.doors << :left
      subject.doors.should == [:left]
    end
  end

  describe '#visited?' do
    it 'defaults to false' do
      subject.visited?.should == false
    end
  end

  describe '#unvisited?' do
    it 'defaults to true' do
      subject.unvisited?.should == true
    end
  end

  describe '#visit!' do
    it 'marks this square as visited' do
      subject.visited?.should == false
      subject.visit!
      subject.visited?.should == true
    end
  end
end
