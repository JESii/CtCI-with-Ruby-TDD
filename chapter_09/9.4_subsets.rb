# CtCI 9.4
#   " Write a method to return all subsets of a set."
#   Cracking the Coding Interview, p 109
#
#   Sets are implemented with arrays for this exercise.
#   Mathematically speaking, the empty set is always a subset.
#   It's not included in these results, but can easily be added.
#   (Ruby makes this trivial :=)

class Subsets
  def initialize set
    @set = set
  end
  def return_subsets
    @result ||= []
    (1..@set.size).each { |n| @set.repeated_combination(n) { |c| @result << c unless c.uniq.size != c.size}}
    @result
  end
end

require 'spec_helper'

describe "Subsets" do
  it "returns the element for a set of one element" do
    set = Subsets.new [1]
    expect(set.return_subsets).to eq [[1]]
  end
  it "returns three subsets for a set of two elements" do
    set = Subsets.new [1,2]
    set.return_subsets.should =~ [[1],[2],[1,2]]
  end
  it "returns all subsets for a set of three elements" do
    set = Subsets.new [1,2,3]
    set.return_subsets.should =~ [[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]]
  end
end

