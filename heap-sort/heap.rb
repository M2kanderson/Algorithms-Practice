require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @prc = prc
    @store = Array.new
  end

  def count

  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    el = @store.pop
    BinaryMinHeap.heapify_down(@store,0)
    el
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store,@store.length - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children = []
    children.push(2*parent_index + 1) if 2*parent_index + 1 < len
    children.push(2*parent_index + 2) if 2*parent_index + 2 < len
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if(child_index == 0)
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new do |el1, el2|
        (el1 <=> el2)
    end
    parent = array[parent_idx]
    child_indices = self.child_indices(len, parent_idx)
    if(child_indices.length == 0)
      return array
    end
    smallest_child_index = child_indices[0]
    if(child_indices[1])
      smallest_child_index = prc.call(array[child_indices[0]],array[child_indices[1]]) > 0 ? child_indices[1] : child_indices[0]
    end
    if(prc.call(array[smallest_child_index],parent) < 0)
      array[smallest_child_index], array[parent_idx] = array[parent_idx], array[smallest_child_index]
      self.heapify_down(array, smallest_child_index, &prc)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new do |el1, el2|
        (el1 <=> el2)
    end
    return array if child_idx == 0
    child = array[child_idx]
    parent_idx = self.parent_index(child_idx)
    parent = array[parent_idx]
    if(prc.call(child,parent) < 0)
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      self.heapify_up(array, parent_idx, &prc)
    end
    array
  end
end
