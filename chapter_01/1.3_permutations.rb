# CtCI 1.3
#   "Given two strings, decide if one is a permutation of the other."
#   Cracking the Coding Interview, p 73
# 
# Use the general match definition of
#   Elements of A taken n at a time
# So if A = {a,b,c}, then the permuations of A are:
#   {a}, {b}, {c}, {a,b}, {a,c}, {b,c}, {a,b,c}; 
#   empty set = don't care, so make it a permuation
#
# Therefore, if B is longer than A, it cannot be a permutation
# Also, if B is empty, then it is the null set and thus make it a permutation

require'spec_helper'

def is_permutation?(a,b)
  return true if b.nil? or b.size == 0
  aa = a.split ""
  ba = b.split ""
  return false if b.size > a.size
  ba.each do |f|
    return false if ! aa.include?(f)
  end
  true
end

describe "is_permutation?" do
  it "returns true if B is empty" do
    expect(is_permutation?("123","")).to be true
    expect(is_permutation?("","")).to be true
  end
  it "returns false if B is longer than A" do
    expect(is_permutation?("123","12345")).to be false
    expect(is_permutation?("123","12323")).to be false
  end
  it "returns true if B is a single element of A" do
    expect(is_permutation?("123","1")).to be true
  end
end
