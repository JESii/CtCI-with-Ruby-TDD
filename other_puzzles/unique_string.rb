# Programming challenge (real-time; no TDD)
# Write a method to identify the longest unique substring in a string
# E.g.,
#   'abcd'    -> 4
#   'abcdb'   -> 4
#   'abcdbef' -> 5

def unique(string)
  strary = string.split('')
  done = false
  maxlen = -1
  while !done do
    temp = []
    done = true
    strary.each_with_index do |e,i|
      temp << e
      if temp.size != temp.uniq.size
        temp.delete_at(i)
        strary.slice!(0,1+temp.find_index(strary[i]))
        done = false
        break
      end
      maxlen = temp.size if maxlen < temp.size
    end
  end
  maxlen = maxlen == -1 ? string.size : maxlen
end
def print_unique(str)
  puts "#{str} => #{unique(str)}"
end
  puts print_unique('')
  puts print_unique('ab')
  puts print_unique('abcde')
  puts print_unique('abcd')
  puts print_unique('abb')
  puts print_unique('abcdbefg')
  puts print_unique('abcdbbefg')
  

