require_relative '00_tree_node'
class KnightPathFinder
  BOARD_SIZE = 8
  MOVE = [[-1, 2], [1,2],
          [2, 1], [2,-1],
          [1,-2], [-1,-2],
          [-2,1], [-2,-1]]
  def initialize (pos)
    @pos = pos
    @visited_positions = []
    @visited_positions += pos unless @visited_positions.include?(pos)
  end

  def valid_moves(pos)
    result = []
    #pos[0] = x, pos[1] = y
    MOVE.each do |x,y|
      move = pos[0]+x,pos[1]+y
      result << move if range_checker(move)
    end
  end

  def new_move_positions(pos)
    result = valid_moves(pos)
    remainder_moves = []
    result.each do |move|
      unless @visited_positions.include?(move)
        @visited_positions << move
        remainder_moves << move
      end
    end
    remainder_moves
  end

  def build_move_tree
    new_move = new_move_positions(@pos)
    queue = @visited_positions.map { |pos| PolyTreeNode.new(pos)}
    parent_index = 0
    queue.map.with_index do |child,index|
      next if index.zero?
      child.parent = queue[parent_index]
      parent_index += 1 if index.even?
    end
  end

  def find_path(end_pos)
    tree = build_move_tree
    tree.dfs(end_pos)

  end

  def range_checker(pos)
    pos[0].between?(0,BOARD_SIZE-1) && pos[1].between?(0, BOARD_SIZE-1)
  end


end

a = KnightPathFinder.new([0,0])
p a.find_path([7,7])
