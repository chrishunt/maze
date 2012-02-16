def compare_move_sets(expected, result)
  result.size.should == expected.size
  expected.each do |move|
    result.include?(move).should == true
  end
end
