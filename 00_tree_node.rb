class PolyTreeNode
  attr_reader :parent, :value, :children

  def initialize(value)
    @parent = nil
    @value = value
    @children = []
  end

  def parent=(input_parent)
    return @parent = input_parent if input_parent == nil
    @parent.children.delete(self) if @parent
    @parent = input_parent
    input_parent.children << self unless input_parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Node is not a child" unless self.children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      first = queue.shift
      return first if first.value == target_value
      queue.concat(first.children) #unless first.children.empty?
    end
    nil
  end
end
