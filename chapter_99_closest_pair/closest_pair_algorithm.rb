
# Code here uses the Node/LinkedList classes

class ClosestPair
  attr_accessor :name
  def initialize(name=nil)
    @name = name
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
end
# require_relative '../chapter_02/2.x_linked_list.rb'
