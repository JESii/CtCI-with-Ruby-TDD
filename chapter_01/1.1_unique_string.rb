# CtCI 1.1
#   "Implement an algorithm to determine if a string has all unique characters.
#    What if you cannot use additional data structures?"
#   Cracking the Coding Interview, p73 
require'spec_helper'

def hasDups?(s)
  return false if s.size <= 1
  s.split('').uniq.size != s.split('').size
end

describe "hasDups?" do
  it "returns false for an empty or one-element string" do
    expect(hasDups?("")).to be false
    expect(hasDups?("a")).to be false
  end
  it "returns false for a string with no dups" do
    expect(hasDups?("12")).to be false
    expect(hasDups?("123")).to be false
  end
  it "returns true for a string with dups" do
    expect(hasDups?("aa")).to be true
    expect(hasDups?("abacdea")).to be true
  end
  it "properly handles embedded newlines" do
    expect(hasDups?("abc\n456")).to be false
    expect(hasDups?("abc\n456c")).to be true
    expect(hasDups?("abc\n456\n")).to be true
  end
end
