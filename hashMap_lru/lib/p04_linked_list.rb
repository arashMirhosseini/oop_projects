class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self

  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return @head.next
  end

  def last
    return @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    if include?(key)
      node = head
      until node == tail.prev
        node = node.next
        return node.val if node.key == key
      end
    end
  end

  def include?(key)
    node = head
    until node == tail.prev
      node = node.next
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    if include?(key)
      update(key, val)
    else
      node = Node.new(key, val)
      node.prev = tail.prev
      node.next = tail
      tail.prev.next = node
      tail.prev = node
      
    end
  end

  def update(key, val)
    if include?(key)
      node = head
      until node == tail.prev
        node = node.next
        node.val = val if node.key == key
      end
    end
  end


  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end

    nil
  end

  def each
    node = head.next
    until node == tail
      yield node
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
