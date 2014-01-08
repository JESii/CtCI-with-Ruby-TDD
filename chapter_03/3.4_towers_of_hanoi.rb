# CtCI 3.4
#   "Implement a method to solve the Towers on Hanoi
#   Assume 3 towers (pegs)
### TODO: In-progress
# Patterns that solve the game
# 1. Unstack until the largest disk is on tower #2
#    - tower #2 is empty and tower #3 has all other disks
#    - noted as position (*) below
# 2. Restack disks until on tower #2
#    - conceptually a 'reverse' of the previous moves
# - Moves are made in groups of three where 3ach group has three moves
# - Eeach group moves the 'top' disk left or right two places
#   and then moves one other disk into an open space
#   Thus, the #1RRxx or #1LLxx pattern
# Hmmm: is it as simple as bounce the smaller and make the ONLY move possible?
# 3-disks
# #1RR#1R | #3LL#2R | #1RR#1R  => [[],[3],[1,2]] (*)
# | #3LL#3L | #1R
# 4-disks
# #1RR#1R | #3LL#2R | #1RR#1R 
# #3LL#3L | #1RR#2L | #3LL#2R => [[1,2,4],[],[3]] (1)
# #1RR#1R | #3LL#2R | #1RR#1R => [[],[4],[1,2,3]] (*)
# #3LL#3L | #1RR#2L | #1LL#3L => [[1,2],[3,4],[]]
# #1RR#1R | #3L
# 5-disks
# #1RR#1R | #3LL#2R | #1RR#1R 
# #3LL#3L | #1RR#2L | #3LL#2R => [[1,2,4,5],[],[3]] (2)
# #1RR#1R | #3LL#2R | #1RR#1R => [[5],[4],[1,2,3]] 
# #3LL#3L | #1RR#2L | #3LL#3L => [[1,2,5],[3,4],[]]
# #1RR#1R | #3LL#2R | #1RR#2L => [[3,5],[4],[1,2]]
# #1LL#3L | #1RR#2L | #1LL#2R => [[1,2,3,5],[],[4]] (1)
# ... 9 more groups of 3      => [[],[5],[1.2.3.4]] (*)

puts "==================Towers of Hanoi===================="

require 'spec_helper'

#TODO: Add methods to the Towers class?
#     can_move_{right/left}?  - see if the move is valid
#     move                    - make the next available move
#     is_done?                - have we completed the tower move?
#     ???more???

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

  def move_next
    big = self.biggest
    small = self.smallest
    self.move(small,big)
  end

  def biggest
    biggest = index = 0
    @towers.each_with_index do |e,i|
      next if e[0] == 1
      if e[0].nil?
        index = i
        break
      end
      if e[0] > biggest
        biggest = e[0]
        index = i
      end
    end
    index
  end
  def smallest
    smallest = 99999
    index = 0
    @towers.each_with_index do |e,i|
      next if e[0] == 1
      next if e[0].nil?
      if e[0] < smallest[0]
        smallest = e
        index = i
      end
    end
    index
  end
  def move(from,to)
    @towers[to].unshift @towers[from].shift
  end
  def bounce_right
    move(0,2)
  end
  def bounce_left
    move(2,0)
  end
  def solve?
    false
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

    it "can move an item to the left" do
      towers = Towers.new(3)
      towers.move_right(1)
      towers.move_right(2)
      towers.move_right(1)
      expect(towers.display_raw).to eql [[3],[2],[1]]
      towers.move_left(3)
      expect(towers.display_raw).to eql [[3],[1,2],[]]
    end

    it "makes the next available move" do
      towers = Towers.new(3)
      towers.move_right(1)
      towers.move_right(2)
      towers.move_next()
      expect(towers.display_raw).to eql [[3],[2],[1]]
      towers.move_left(3)
      towers.move_left(2)
      towers.move_right(3)
      expect(towers.display_raw).to eql [[1,3],[],[2]]
    end
    it "can 'bounce' the 1 from left to right" do
      towers = Towers.new(3)
      towers.bounce_right
      expect(towers.display_raw).to eql [[2,3],[],[1]]
    end
    it "can 'bounce' the 1 from right to left" do
      towers = Towers.new(3)
      towers.bounce_right
      towers.move_next
      towers.bounce_left
      expect(towers.display_raw).to eql [[1,3],[2],[]]
    end
    it "detects a winning position" do
      towers = Towers.new(3)
      towers.bounce_right
      towers.move_next
      puts "#{towers.display_raw}"
      expect(towers.solve?).to be_false
      towers.bounce_left
      towers.move_next
      puts "#{towers.display_raw}"
      expect(towers.solve?).to be_false
      towers.bounce_right
      towers.move_next
      puts "#{towers.display_raw}"
      towers.bounce_left
      towers.move_next
      puts "#{towers.display_raw}"
      expect(towers.solve?).to be_true
    end
  end
end
