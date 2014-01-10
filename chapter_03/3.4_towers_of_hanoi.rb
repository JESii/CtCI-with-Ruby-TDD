# CtCI 3.4
#   "Implement a method to solve the Towers on Hanoi
# 
# Development/TDD:
# I decided to leave this in an unfinished state in that I haven't
# done any refactoring. This could be useful to other folks to see how
# TDD sometimes goes. I started off with simple methods such as #move_left
# and #move_right. However, as I progressed and learned more about how the
# game worked, these methods became superfluous. Refactoring would remove
# these methods (and probably others as well), along with the supporting
# specs.
# 
# Algorithm:
# Examine the moves in detail and there are lots of mini-patterns,
#   (guaranteed to throw you off-track for a bit)
# but the algorithm to solve any game is deceptively simple:
# 1. "bounce" the smallest disk all the way to right
# 2. make the ONLY move possible
# 3. "bounce" the smallest disk all the way to left
# 4. make the only move possible
# 5. repeat 1-4, testing for a solvable position before every "make the only..."
# 6. "solvable" positions have [1] and [2] on first/third towers

puts "==================Towers of Hanoi===================="

require 'spec_helper'

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
      if e[0] < smallest
        smallest = e[0]
        index = i
      end
    end
    index
  end

  # move routine uses array indexes, not tower positions
  def move(from,to)
    @towers[to].unshift @towers[from].shift
  end
  
  def bounce_right
    move(0,2)
  end

  def bounce_left
    move(2,0)
  end

  def solved?
    if @towers[0].size == 1 && @towers[2].size == 1
      test = []
      test << @towers[0][0] << @towers[2][0]
      test.sort!
      if test == [1,2]
        move_next
        move_one_and_done
        true
      end
    else
      false
    end
  end

  def move_one_and_done
    if @towers[0].empty?
      move(2,1)
    else
      move(0,1)
    end
  end
end

class TowersOfHanoi

  def initialize(height)
    @height = height
    @game = Towers.new(height)
  end

  def display_raw
    @game.to_raw
  end

  def solve
    while 1
      @game.bounce_right
      break if @game.solved?
      @game.move_next
      @game.bounce_left
      break if @game.solved?
      @game.move_next
    end
  end
end

describe "TowersOfHanoi" do

  it "displays the current position" do
    toh = TowersOfHanoi.new(3)
    expect(toh.display_raw).to eql([[1,2,3],[],[]])
  end

  it "solves the puzzle using the alorithm" do
    toh = TowersOfHanoi.new(4)
    toh.solve
    expect(toh.display_raw).to eql [[],[1,2,3,4],[]]
  end
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
    towers.move_next
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
    expect(towers.solved?).to be_false
    towers.bounce_left
    towers.move_next
    expect(towers.solved?).to be_false
    towers.bounce_right
    towers.move_next
    towers.bounce_left
    expect(towers.solved?).to be_true
  end

  it "makes next move with larger tower" do
    t = Towers.new(4)
    t.bounce_right
    t.move_next
    expect(t.display_raw).to eql [[3, 4], [2], [1]]
    t.bounce_left
    t.move_next
    expect(t.display_raw).to eql [[1, 3, 4], [], [2]]
    t.bounce_right
    expect(t.display_raw).to eql [[3, 4], [], [1,2]]
    t.move_next
    expect(t.display_raw).to eql [[4], [3,], [1,2]]
  end
end
