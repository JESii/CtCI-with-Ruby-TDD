# CtCi 3.3
#   "Imagine a (literal) stack of plates. If the stack gets too high, it might topple.
#    Therefore, in real life, we would likely start a new stack when the previous tack
#    exceeds some threshold. Implement a data structure SetOfStacks that mimics
#    this. SetOfStacks should be composed of several stacks and should create a
#    new stack once the previous one exceeds capacity. SetOfStacks.push() and
#    SetOfStacks.pop() should behave identically to a single stack (that is, pop()
#    should return the same values as it would if there were just a single stack."
#   Cracking the Coding Interview, p 80

class StackNode < Struct.new(:next, :data)
end

class SetOfStacks
  attr_reader :threshold, :stack_set_count

  def initialize(threshold)
    @threshold = threshold
    @stack = nil
    @stack_set = []
    @stack_set_count = 0
    @stack_elements = 0
  end

  def peek
    @stack.data
  end

  def push(data)
    @stack = checked_stack_for_push
    if @stack.nil?
      @stack_set_count += 1
      @stack = StackNode.new(nil,data)
    else
      @stack = StackNode.new(@stack, data)
    end
    @stack_elements += 1
    @stack
  end

  def pop
    @stack = checked_stack_for_pop
    return nil if @stack.nil?
    result, @stack = @stack.data, @stack.next
    @stack_elements -= 1
    result
  end

  def checked_stack_for_push
     if @stack_elements == @threshold
       @stack_set[@stack_set_count] = @stack
       @stack = nil
       @stack_elements = 0
     end
    @stack
  end

  def checked_stack_for_pop
    if @stack_elements == 0
      @stack_set_count -= 1
      @stack = @stack_set[@stack_set_count]
      @stack_elements = 3
    end
    @stack
  end

end

require 'spec_helper'

describe SetOfStacks do
  before do
    @stack3 = SetOfStacks.new(3)
  end
  it "creates a new stack with a threshold" do
    expect(@stack3.threshold).to eq 3
  end
  it "adds a new element to the top of the stack" do
    @stack3.push("a")
    expect(@stack3.peek).to eq "a"
  end
  it "adds two elements to the stack" do
    @stack3.push("a")
    @stack3.push("b")
    expect(@stack3.peek).to eq "b"
  end
  it "adds a new stack when creating the threshold entry" do
    @stack3.push('a')
    @stack3.push('b')
    @stack3.push('c')
    @stack3.push('d')
    expect(@stack3.peek).to eq 'd'
    expect(@stack3.stack_set_count).to eq 2
  end
  it "adds a 3rd stack when creating the second threshold entry" do
    %w{a b c d e f g}.each { |data| @stack3.push data }
    expect(@stack3.peek).to eq 'g'
    expect(@stack3.stack_set_count).to eq 3
  end
  it "pops the most recent entry off the stack" do
    @stack3.push('a')
    expect(@stack3.pop).to eq 'a'
  end
  it "pops the most recent entry with multiple pushed entries" do
    %w{a b c}.each { |d| @stack3.push d }
    expect(@stack3.pop).to eq 'c'
  end
  it "returns the most recent entry with multiple stacks" do
    %w{a b c d e f g}.each { |data| @stack3.push data }
      expect(@stack3.pop).to eq 'g'
      expect(@stack3.pop).to eq 'f'
      expect(@stack3.pop).to eq 'e'
      expect(@stack3.stack_set_count).to eq 2
  end
  it "returns nil when all entries have been popped" do
    %w{a b c}.each { |d| @stack3.push d }
    expect(@stack3.pop).to eq 'c'
    expect(@stack3.pop).to eq 'b'
    expect(@stack3.pop).to eq 'a'
    expect(@stack3.pop).to be_nil
    expect(@stack3.stack_set_count).to eq 0
  end
  it "returns nil when all inner stacks have been popped" do
    %w{a b c d e f g}.each { |data| @stack3.push data }
    7.times { @stack3.pop }
    expect(@stack3.pop).to be_nil
    expect(@stack3.stack_set_count).to eq 0
  end
end
