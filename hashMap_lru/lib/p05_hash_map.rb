require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store.any? {|link| link.include?(key)}
  end

  def set(key, val)
    if count <= 8
      if bucket(key).include?(key)
        bucket(key).update(key, val)
      else
        bucket(key).append(key, val)
        @count += 1
     end
    else
      resize!
      if bucket(key).include?(key)
        bucket(key).update(key, val)
      else
        bucket(key).append(key, val)
        @count += 1
      end
    end

  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |link|
      if !link.empty?
        link.each do |node|
          yield [node.key, node.val]
        end
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    stor1 = Array.new(num_buckets) {LinkedList.new}
    
    @store += stor1
    
    @store[0...num_buckets/2].each do |link|
      if !link.empty?
        link.each do |node|
          key = node.key
          val = link.get(key)
          # link.remove(key)
          bucket(key).append(key, val)
        end
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
