# CtCI 9.4
#   " Write a method to return all subsets of a set."
#   Cracking the Coding Interview, p 109
#   
# "All subsets of a set" is the power set
# This is an alternative (and cleaner, IMO) solution to the problem.


class Powerset

  def initialize()
  end

  def generate(set)
    return [[] , set].uniq if set.size <= 1
    tmp = generate(set[1..set.size])
    return [ tmp , tmp.map { |e| [ [set[0]] + [e]].flatten } ].flatten(1).uniq

  end
end

require 'spec_helper'

describe "Powerset" do
  it "handles the empty set" do
    ps = Powerset.new()
    expect(ps.generate([])).to eq [[]]
  end
  it "handles a set of one element" do
    ps = Powerset.new()
    ps.generate([1]).should =~ [[],[1]]
  end
  it "handles a set of two elements" do
    ps = Powerset.new()
    ps.generate([1,2]).should =~ [[], [1], [2], [1,2]]
  end
  it "handles a larger input set" do
    ps = Powerset.new()
    ps.generate([1,4,7]).should =~ [[], [1],[4],[7],[1,4],[1,7],[1,4,7],[4,7]]
  end
end
