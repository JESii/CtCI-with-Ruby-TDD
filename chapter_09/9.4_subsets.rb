# CtCI 9.4
#   " Write a method to return all subsets of a set."
#   Cracking the Coding Interview, p 109
#
#   Sets are implemented with arrays for this exercise.
#   Mathematically speaking, the empty set is always a subset.
#   It's not included in these results, but can be trivially added.
#
#   Implementations
#   ---------------
#   (1) return_subsets() method
#   Ruby makes this a rather easy exercise because of the core
#   repeated_combination method.
#
#   (2) return_subsets_raw() method
#   So I implemented it without that ruby method, using a recursive approach.
#   Rather than the 'additive' approach used in CtCI, I instead use what I'll
#   call a 'reductive' approach in that I start with the full set and repeatedly
#   remove an element from the candidate set, capturing subsets along the way.
# 
# NOTE: An alternative solution can be found in 9.4a_subsets.rb

class Subsets
  def initialize set
    @set = set.uniq
  end
  def return_subsets
    @result ||= []
    (1..@set.size).each { |n| @set.repeated_combination(n) { |c| @result << c unless c.uniq.size != c.size}}
    @result
  end
  def return_subsets_raw
    @result_raw = []
    ss_raw(@set)
    @result_raw.uniq
  end
  def ss_raw set
    @result_raw << set
    return if set.size == 1
    set.each_index do |i|
      tmp = set.clone
      tmp.delete_at i
      ss_raw(tmp)
    end
  end
end

require 'spec_helper'

describe "Subsets" do
  %w{return_subsets return_subsets_raw}.each do |method|
    it "returns the element for a set of one element" do 
      set = Subsets.new [1]
      expect(set.__send__(method)).to eq [[1]]
    end
    it "returns three subsets for a set of two elements" do
      set = Subsets.new [1,2]
      set.__send__(method).should =~ [[1],[2],[1,2]]
    end
    it "returns all subsets for a set of three elements" do
      set = Subsets.new [1,2,3]
      set.__send__(method).should =~ [[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]]
    end
  end
end
