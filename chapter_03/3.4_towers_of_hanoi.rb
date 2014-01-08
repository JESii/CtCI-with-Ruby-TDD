# CtCI 3.4
#   "Implement a method to solve the Towers on Hanoi
#   Assume 3 towers (pegs)
### In-progress

puts "==================Towers of Hanoi===================="

require 'spec_helper'

#TODO: Think about using a 'Towers' class here
# =>Methods would be something like:
#     move_{right/left}       - return false if invalid move
#     can_move_{right/left}?  - see if the move is valid
#     is_done?                - have we completed the tower move?
# =>  ???more???

class Towers
  def initialize(height)
    @height = height
    @towers = Array.new(3) {Array.new}
    (0...height).each { |i| @towers[0][i] = i+1 }
  end

  def display_raw
    @towers.to_ary
  end

  def to_raw
    @towers.to_ary
  end

  def move_right(tower)
     @towers[tower].unshift @towers[tower-1].shift
  end

  def move_left(tower)
    @towers[tower-2].unshift @towers[tower-1].shift
  end
end

class TowersOfHanoi
  def initialize(height)
    @height = height
    @game = Towers.new(3)
  end

  def display_raw
    @game.to_raw
  end
end

describe "TowersOfHanoi" do
  it "displays the current position" do
    toh = TowersOfHanoi.new(3)
    expect(toh.display_raw).to eql([[1,2,3],[],[]])
  end

  describe "Towers game board" do

    it "uses a Game 'board'" do
      towers = Towers.new(3)
      expect(towers.display_raw).to eql([[1,2,3],[],[]])
    end

    it "can move an item to the right" do
      towers = Towers.new(3)
      towers.move_right(1)
      expect(towers.display_raw).to eql [[2,3],[1],[]]
    end

    it "can move an item to the right" do
      towers = Towers.new(3)
      towers.move_right(1)
      towers.move_right(2)
      towers.move_right(1)
      expect(towers.display_raw).to eql [[3],[2],[1]]
      towers.move_left(3)
      expect(towers.display_raw).to eql [[3],[1,2],[]]
    end
  end
end
