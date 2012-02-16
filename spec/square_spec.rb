require 'square'

describe Square do
  subject { Square.new }

  describe 'attributes' do
    it 'has a left, right, up, and down connection' do
      subject.left.should  == nil
      subject.right.should == nil
      subject.down.should  == nil
      subject.up.should    == nil
    end

    it 'has a collection of doors' do
      subject.doors.should == []
    end
  end

  describe '#visited?' do
    it 'defaults to false' do
      subject.visited?.should == false
    end
  end

  describe '#visit!' do
    it 'marks this square as visited' do
      subject.visited?.should == false
      subject.visit!
      subject.visited?.should == true
    end
  end

  describe '#has_neighbor?' do
    it 'returns false when square has no neighbors' do
      subject.has_neighbor?.should == false
    end

    it 'returns false when subject has one visited neighbor' do
      subject.left = Square.new
      subject.left.visit!
      subject.has_neighbor?.should == false
    end

    it 'returns true when subject has one unvisited neighbor' do
      subject.left = Square.new
      subject.has_neighbor?.should == true
    end

    it 'returns true when subject has one unvisited and one visited neighbor' do
      subject.left  = Square.new
      subject.right = Square.new
      subject.right.visit!
      subject.has_neighbor?.should == true
    end
  end

  %w(left right down up).each do |dir|
    describe "#has_#{dir}_neighbor?" do
      it "returns false when square does not have a #{dir} neighbor" do
        subject.send("has_#{dir}_neighbor?").should == false
      end

      it 'returns true when square has a left neighbor' do
        subject.send("#{dir}=", Square.new)
        subject.send("has_#{dir}_neighbor?").should == true
      end
    end
  end
end
