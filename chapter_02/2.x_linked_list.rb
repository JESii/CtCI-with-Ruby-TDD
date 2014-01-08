# CtCi 2.x
#   Create a linked-list class and test it
# =>Used for CtCI Chapter 2 problems...

puts "Start of LinkedList program"
puts "Interface based on http://www.cs.cmu.edu/~adamchik/15-121/lectures/Linked%20Lists/linked%20lists.html"

class Node
  attr_accessor :data
  attr_accessor :next

  def initialize(data,link=nil)
    @data = data
    @next = link
  end
end

class LinkedList
  def initialize(data, link=nil)
    @head = Node.new(data,link)
  end
  def head()
    return @head
  end
  def linked_list(value, cell)
    return Node.new(value, cell)
  end
  def recursive_print(node=@head)
    #Prints from the specified node; defaults to the head node
    if node.next == nil then
      return node.data
    else
      return node.data + ' > ' + recursive_print(node.next) 
    end
  end
  def addFirst(node)
    #Add a node at the beginning of the list
    ntemp = @head
    @head = node
    @head.next = ntemp
  end
  def addLast(node)
    #Add a node at the end of the list
    #For now, we simply interate through the list...
    niter = @head
    niter = niter.next while niter.next != nil
    niter.next = Node.new(node.data,node.next)
  end
  def insertAfter
    #Insert the node after the given location
  end
  def insertBefore
    #Insert the node before the given location
  end
  def remove(data)
    #Find the node containing the data value and delete it
    niter = @head
    while niter.data != data
      return false if niter.next.nil?
      piter = niter
      niter = niter.next
    end
    piter.next = niter.next
    return true
  end
  def find(data)
    niter = @head
    while niter.data != data
      return nil if niter.next.nil?
      niter = niter.next
    end
    return niter
  end
  def remove_dups()
    # Approach: scan list; keep found items in hash; check and delete if seen again
    # Approach: sort list and then scan; only need to keep most recent item in memory
    found = {}
    niter = self.head
    while niter.next != nil
      if found[niter.data].nil? then
        found[niter.data] = 1    # count occurrences
        niter = niter.next
      else
        # Delete an 'isolated' node in a linked list
        # ...Simply replace this node with next and delete next
        # (CtCI2.3; had to peek at solution)
        found[niter.data] += 1
        niter.data = niter.next.data
        niter.next = niter.next.next
      end
    end
  end
  def remove_node(node)
    #CtCI2.3 - Delete (isolated) node in middle of list
    raise "Can't remove isolated last node" if node.next.nil?
    node.data = node.next.data
    node.next = node.next.next
  end
  def remove_kth_from_last(k)
    #Approach: starter = find kth item; save head as kth_pointer
    #          performer = index through list, increment kth_pointer in tandem
    node = self.find_kth_from_last(k)
    self.remove_node(node)
  end
  def find_kth_from_last(k)
    kth_pointer = niter = self.head
    i = 1
    while i < k do    ### starter function
      niter = niter.next
      i += 1
    end
    while niter.next != nil do
      niter = niter.next
      kth_pointer = kth_pointer.next
    end
    #kth_pointer.data = kth_pointer.next.data
    #kth_pointer.next = kth_pointer.next.next
    kth_pointer
  end
  def copy
    #Clone the whole list
  end
  def clear
    #Set the whole list to a pristine state
  end
  def included?
    #Return true/false if the node exists
  end
end

require'spec_helper'

describe Node do
  it "is properly initialized" do
    node = Node.new("test",nil)
    expect(node.data).to eq "test"
    expect(node.next).to eq nil
  end
end
describe LinkedList do
  it "initializes properly" do
    llist = LinkedList.new("test2")
    expect(llist.head.data).to eq "test2"
    expect(llist.head.next).to be_nil
  end
  it "adds a back node successfully" do
    llist = LinkedList.new("test3")
    llist.addLast(Node.new("linked item #1"))
    expect(llist.head.data).to eq "test3"
    expect(llist.head.next.data).to eq "linked item #1"

  end
  it "adds a front node successfully" do
    llist = LinkedList.new("test4")
    llist.addFirst(Node.new("linked item #2"))
    expect(llist.head.data).to eq "linked item #2"
    expect(llist.head.next.data).to eq "test4"
  end
  describe "handles multiple elements" do
    before(:each) do
      @llist = LinkedList.new("head")
      @llist.addLast(Node.new("one"))
      @llist.addLast(Node.new("two"))
      @llist.addLast(Node.new("three"))
    end
    it "prints the full list" do
      llist = LinkedList.new("test5")
      llist.addFirst(Node.new("first #1"))
      llist.addLast(Node.new("last #1"))
      llist.addLast(Node.new("last #2"))
      expect(llist.recursive_print).to eq "first #1 > test5 > last #1 > last #2"
      puts llist.recursive_print
    end
    it "removes an entry" do
      @llist.remove("two")
      expect(@llist.recursive_print).to eq "head > one > three"
      puts @llist.recursive_print
    end
    it "finds an entry when present" do
      node = @llist.find("two")
      expect(node.data).to eq "two"
    end
    it "returns nil when attempting find an element that is not present" do
      node = @llist.find "four"
      expect(node).to be_nil
    end
    it "removes duplicates (based on data) from a list" do
      #CtCI 2.1
      @llist.addLast(Node.new("one"))
      @llist.addLast(Node.new("two"))
      @llist.addLast(Node.new("four"))
      @llist.remove_dups()
      expect(@llist.recursive_print).to eq "head > one > two > three > four"
    end
    it "removes the kth to last element from a list" do
      #CtCI 2.2 - misread to 'delete'
      @llist.addLast(Node.new("four"))
      @llist.addLast(Node.new("five"))
      @llist.addLast(Node.new("six"))
      @llist.remove_kth_from_last(2)
      expect(@llist.recursive_print).to eq "head > one > two > three > four > six"
    end
    it "finds the kth to last element from a list" do
      #CtCI 2.2
      @llist.addLast(Node.new("four"))
      @llist.addLast(Node.new("five"))
      @llist.addLast(Node.new("six"))
      node = @llist.find_kth_from_last(2)
      expect(node.data).to eq "five"
    end
    it "raises exception if attempt to delete 'isolated' node at end of list" do
      @list = LinkedList.new(Node.new("head"))
      @list.addLast(Node.new("last"))
      expect {
        @list.remove_node(@list.find_kth_from_last(1))
      }.to raise_exception "Can't remove isolated last node"
    end
    it "removes a node from list using remove_node" do
      node = @llist.find_kth_from_last(2)
      @llist.remove_node(node)
      expect(@llist.recursive_print).to eq "head > one > three"
    end
  end
end
