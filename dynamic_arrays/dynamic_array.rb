require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    if(index >= @length)
      raise "index out of bounds"
    end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    if(@length == 0)
      raise "index out of bounds"
    else
      val = @store[@length - 1]
      @length -= 1
      val
    end

  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if(@length == @capacity)
      resize!
    end
    @store[@length] = val
    @length += 1
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    if(@length == 0)
      raise "index out of bounds"
    else
      val = @store[0]
      @store[0] = nil
      (@length - 1).times do |index|
        @store[index] = @store[index + 1]
      end
      # @store[1...@length].each_with_index do |value, index|
      #   @store[index] = value
      # end
      @length -= 1
      val
    end

  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if(@length == @capacity)
      resize!
    end
    @length.times do |index|
      @store[@length - index] = @store[@length - index - 1]
    end
    @store[0] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_store = Array.new(@capacity * 2)
    @length.times do |index|
      new_store[index] = @store[index]
    end
    # @store.each_with_index do |el, index|
    #   new_store[index] = el
    # end
    @store = new_store
    @capacity = @capacity * 2
  end
end
