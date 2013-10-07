#CtCI 11.2
#   "Sort an array of strings so that all anagrams are next to each other."
#   Cracking the Coding Interview, p 121
#
#   This implementation returns the results with the words sorted by the 
#   character list and by the words within each anagram group

class AnagramSort
  def sort_by_anagram ary
    return ary if ary.size <= 2
    result = {}
    hash = Hash[ary.zip ary]
    hash = hash.each { |k,v| hash[k]=v.split('').sort.join('') }
    hash.each do |k,v|
      result[v] ||= []
      result[v] << k
    end
    return Hash[result.sort].map do |k,v|
      result[k].sort
    end.flatten
  end
end

require 'spec_helper'

describe AnagramSort do
  before :each do
    @asort = AnagramSort.new
  end
  it "returns an empty array when given an empty array" do
    expect(@asort.sort_by_anagram [] ).to eq []
  end
  it "returns the original array when given an array with two entries" do
    ary = %w{cword aword}
    expect(@asort.sort_by_anagram ary ).to eq ary
  end
  it "sorts multiple anagrams together with one anagram group" do
    ary = %w{cat ball act fact}
    expect(@asort.sort_by_anagram ary ).to eq %w{ball fact act cat}
  end
  it "sorts with multiple anagram groups" do
    ary = %w{cat ball act fact tar bird rat art}
    expect(@asort.sort_by_anagram ary).to eq %w{ball fact act cat art rat tar bird}
  end
end
