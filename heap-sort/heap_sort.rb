require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new do |el1, el2|
      -1 * (el1 <=> el2)
    end
    #Call the buildMaxHeap() function on the list. Also referred to as heapify(),
    #this builds a heap from a list in O(n) operations.
    heap = BinaryMinHeap.new
    range = self.length
    while(self.length > 0)
      heap.push(self.pop)
    end
    #extract from the heap until fully extracted
    while(range > 0)
      self.push(heap.extract)
      range -= 1
    end
    self
  end
end
