
# Code here uses the Node/LinkedList classes

class ClosestPair
  attr_accessor :name
  def initialize(name=nil)
    @name = name
    @nodes = []
  end
  def add_node(name,xpos,ypos)
    @nodes << Node.new(name, :xpos => xpos, :ypos => ypos)
  end
  def size
    @nodes.size 
  end
end

# Rspec code here
require 'spec_helper'

puts "================ closest_pair =================="

describe ClosestPair do
  it "creates a ClosestPair object" do
    cpair = ClosestPair.new
    expect(cpair.class).to eql ClosestPair
  end
  it "has a name" do
    cpair = ClosestPair.new("header")
    expect(cpair.name).to eql "header"
  end
  it "accepts a list of nodes for processing" do
    cpair = ClosestPair.new("two nodes")
    cpair.add_node("one",5,0.5)
    expect(cpair.size).to eql 1
  end
  it "accepts two nodes" do
    cpair = ClosestPair.new("two nodes")
    cpair.add_node("one", 5,0.5)
    cpair.add_node("two",3,1.2)
    expect(cpair.size).to eql 2
  end
end
require_relative '../chapter_02/2.x_linked_list.rb'
