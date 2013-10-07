#CtCI 4.3: 
#   "Given a sorted (increasing order) array with unique integer elements, 
#    write an algorithm to create a binary search tree with minimum height."
#   Cracking the Coding Interview, p86 

module BinaryTree
  BNode = Struct.new(:node, :left_tree, :right_tree) do

  end

  def create_tree array
    return nil if array.nil? || array.empty?
    if array.size == 1
      return BNode.new(array[0], nil, nil)
    elsif array.size == 2
      return BNode.new(array[1], BNode.new(array[0]), nil)
    elsif array.size == 3
      return BNode.new(array[1], BNode.new(array[0]),BNode.new(array[2]))
    else
      split = array.size / 2
      left_tree = array.take(split) 
      right_tree = array.drop(split + 1)
      return BNode.new(array[split], create_tree(left_tree), create_tree(right_tree))
    end
  end

end

require 'spec_helper'
include BinaryTree

describe "create_tree" do
  it "creates an empty tree" do
    expect(create_tree(nil)).to eq nil
    expect(create_tree([])).to eq nil
  end
  it "creates a tree with one node" do
    expect(create_tree([1])).to be_a BNode
  end
  it "creates a tree with one node and a left subtree" do
    tree = create_tree([1,2])
    expect(tree).to be_a BNode
    expect(tree.left_tree).to be_a BNode
    expect(tree.node).to eq 2
    expect(tree.left_tree.node).to eq 1
  end
  it "creates a tree with one node and left & right subtrees" do
    tree = create_tree [1,2,3]
    expect(tree.left_tree.node).to eq 1
    expect(tree.right_tree.node).to eq 3
    expect(tree.node).to eq 2
    pp tree
  end
  it "creates a tree with four elements" do
    tree = create_tree([1,2,3,4])
    expect(tree).to be_a BNode
    expect(tree.node).to eq 3
    expect(tree.left_tree.node).to eq 2
    pp tree
  end
  it "creates a long tree" do
    tree=create_tree([1,3,5,7,9,10,11])
    expect(tree.node).to eq 7
    expect(tree.left_tree.right_tree.node).to eq 5
    expect(tree.left_tree.right_tree.left_tree).to eq nil
    expect(tree.right_tree.left_tree.node).to eq 9
    expect(tree.right_tree.left_tree.right_tree).to eq nil
    pp tree
  end
end
