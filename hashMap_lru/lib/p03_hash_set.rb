class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !include?(key)
      if @count < 8
        self[key] << key
      else
        resize!
        self[key] << key
      end
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store1 = Array.new(2 * num_buckets) {Array.new}
    @store += store1
    @store[0...num_buckets/2].each do |bucket|
      bucket.length.times do |ele|
        self[ele] << ele
      end
    end
  end
end
