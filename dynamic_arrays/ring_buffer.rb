require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    if(index >= @length)
      raise "index out of bounds"
    end
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    if(@length == 0)
      raise "index out of bounds"
    else
      val = @store[(@start_idx + @length - 1) % @capacity]
      @length -= 1
      val
    end
  end

  # O(1) ammortized
  def push(val)
    if(@length == @capacity)
      resize!
    end
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
    @store
  end

  # O(1)
  def shift
    if(@length == 0)
      raise "index out of bounds"
    else
      val = @store[@start_idx]
      @start_idx = (@start_idx + 1) % @capacity
      @length -= 1
      val
    end
  end

  # O(1) ammortized
  def unshift(val)
    if(@length == @capacity)
      resize!
    end
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_store = Array.new(@capacity * 2)
    @length.times do |index|
      new_store[index] = @store[(@start_idx + index) % @capacity]
    end
    @start_idx = 0
    @store = new_store
    @capacity = @capacity * 2
  end
end
