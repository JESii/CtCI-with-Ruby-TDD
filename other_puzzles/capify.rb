# Given an arbitrary string, generate all the string combinations of upper- & lower-case 
# letters from the original string
# Example: given 'ab', generate 'ab', 'Ab', 'aB', 'AB'

def capify(str)
  str_size = str.length
  result = ['']
  str.each_char do |s| 
    tmp = result.clone
    result = []
    tmp.each do |as|
      result << as + s.upcase
      result << as + s.downcase
    end 
  end 
  return result
end

require 'rspec'

puts "=========capify============"
describe 'capify a string' do
  it "handles a string of length 1" do
    capify('a').should =~ ['a','A']
  end 
  it "handles a string of length 2" do
    capify('ab').should =~ %w{ab Ab aB AB}
  end 
  it "handles a string of length 3" do
    capify('abc').should =~ %w{abc Abc aBc abC ABc AbC aBC ABC}
  end 
end

