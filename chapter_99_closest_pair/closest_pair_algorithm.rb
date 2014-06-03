require 'pry'
require_relative '../linked_list'

# Code here uses the Node/LinkedList classes

class ClosestPair
  attr_accessor :name
  def initialize(name=nil)
    @name = name
    @nodes = []
  end
  def add_node(name,xpos,ypos)
    @nodes << Node.new(name, nil, :xpos => xpos, :ypos => ypos)
  end
  def size
    @nodes.size 
  end
  def [](item)
    @nodes[item-1]
  end
  def distance(node1,node2)
   Math::sqrt( (node1.xpos - node2.xpos)**2 + (node1.ypos - node2.ypos)**2 )
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
  it "returns the requested node" do
    cpair = ClosestPair.new("return nodes")
    cpair.add_node("one", 5,0)
    cpair.add_node("two",0,3)
    expect(cpair[1].data).to eql "one"
    expect(cpair[2].data).to eql "two"
  end
  describe "calculates pair distances" do
    it "for two nodes" do
      cpair = ClosestPair.new("calculate distance")
      cpair.add_node("one",0,0)
      cpair.add_node("two",3,4)
      expect(cpair.distance(cpair[1],cpair[2])).to eql 5.0
    end
    it "for another set of two nodes" do
      cpair = ClosestPair.new("calculate simple distance")
      cpair.add_node("one",0,0)
      cpair.add_node("two",1,1)
      expect(cpair.distance(cpair[1],cpair[2])).to eql(Math::sqrt 2)
    end
  end
  
end
