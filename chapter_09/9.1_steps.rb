# CtCI 9.1
#   "A child is running up a staircase with n steps, and can hop 1 step, 2 steps,
#    or 3 steps at a time. Implement a method to count how many possible ways
#    the child can run up the steps."

class Steps
  def initialize(num_steps)
    @num_steps = num_steps
  end
  def count
    p = []
    @num_steps.times { |n| p += [1,2,3].repeated_permutation(n+1).to_a }
    ways =  p.select { |a| a.inject { |sum,x| sum + x }  == @num_steps }
    puts "ways to climb the stairs (acceptable permutations): #{ways}"
    return ways.size
  end
  def sum ary
    ary.inject { |sum,x| sum + x }
  end
end

require 'spec_helper'

describe Steps do
  it "returns 1 for a 1-step staircase" do
    steps = Steps.new(1)
    expect(steps.count).to eq 1
  end
  it "returns 2 for a 2-step staircase" do
    steps = Steps.new(2)
    expect(steps.count).to eq 2
  end
  it "returns 4 for a 3-step staircase" do
    steps = Steps.new(3)
    expect(steps.count).to eq 4
  end
  it "returns 7 for a 4-step staircase" do
    steps = Steps.new(4)
    expect(steps.count).to eq 7
  end
  
end
