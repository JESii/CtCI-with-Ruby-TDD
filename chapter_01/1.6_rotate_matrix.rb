# CtCI 1.6
#   "Given an image represented by an NxN matrix, where each pixel in the image is 4 bytes,
#    write a method to rotate the image by 90 degress. Can you do this in place?"
#   Cracking the Coding Interview, p 73
#
# =>#TODO# This performs the task when each pixel is 1 byte
#   It can be modified for 4-byte images by first transforming the array into a
#   structure pointing to 4-byte pixels.
#
# Rotate an MxN matrix by 90 degrees;
# Perform in-place if possible

# swap in ruby => a,b = b,a
# m[r][c] for accessing a matrix without the Matrix class
# Swapping counter-clockwise; this means that:
#    First R   = Last C 
#    First+1 R = Last-1 C
# Therefore: iterate i from 0 to C-1
#    First+i R = Last-j C (for all j columns)

require'spec_helper'

class MyMatrix
  def self.build(r,c, &block)
    m = Array.new(r) do |i|
      Array.new(c) do |j|
        yield i, j
      end
    end
  end
  def self.rotate(m)
  r = m.size
  c = m[0].size
  result = []
  (0...c).each do |j|
    result[j] ||= []
    (0...r).each do |i|
      jj = c - j - 1
      result[j] << m[i][jj]
    end
    puts "jth row: #{j}; #{pp result[j]}"
  end
  result
  end
end

describe MyMatrix do
  it "rotates a 2x2 matrix" do
    m = MyMatrix.build(2,2) { |r,c| r - c }
    pp m
    o = MyMatrix.build(2,2) { 0 }
    r = MyMatrix.build(2,2) { 0 }
    r[0][0] = -1; r[1][1] = 1
    pp r
    expect(MyMatrix.rotate(m)).to eq r
  end
  it "rotates a 3x3 matrix" do
    # Generate a 'serial' matrix from 0-8
    # Better way to calculate this?
    m = MyMatrix.build(3,3) {|r,c| ((r+1*c+1)+r*2)-1 }
    pp m
    o = MyMatrix.build(3,3) { 0 }
    r = MyMatrix.build(3,3) { 0 }
    r[0] = [2,5,8] ; r[1] = [1,4,7] ; r[2] = [0,3,6]
    pp r
    expect(MyMatrix.rotate(m)).to eq r
  end
end
