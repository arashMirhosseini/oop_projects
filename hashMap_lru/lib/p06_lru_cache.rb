require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :max, :prc

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      node = map[key]
      update_node!(node)
      node.val
    else
      calc!(key)
      
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  # private
  attr_reader :store, :map
  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    node_val = @prc.call(key)
    map[key] = @store.append(key, node_val)

    eject! if count > self.max
    node_val
  end

  def update_node!(node)
    node.remove
    map[node.key] = @store.append(node.key, node.val)
  
  end

  def eject!
    node = store.first
    key = node.key
    node.remove
    map.delete(key)
    nil
  end
end
