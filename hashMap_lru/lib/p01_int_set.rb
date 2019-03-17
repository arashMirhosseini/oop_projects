require "byebug"
class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @max = max
    @store = Array.new(@max){false}
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    end
  end

  def remove(num)
    if include?(num)
      @store[num] = false
    end
  end

  def include?(num)
    if is_valid?(num)
     @store[num] == true
    end
  end

  private

  def is_valid?(num)
    if num >= @max || num < 0
      raise "Out of bounds"
    end
    true
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    idx = num % num_buckets
    @store[idx] << num
    # p @store
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      if @count < 20 
        self[num] << num
      else
        resize!
        self[num] << num
      end
      @count += 1
    end
    
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
  
    store_temp = Array.new(num_buckets) {Array.new}
  
    @store += store_temp 
 
    @store[0...num_buckets/2].each do |bucket|
      bucket.length.times do 
        num = bucket.shift
        self[num] << num
      end
        

    end
  end
end
