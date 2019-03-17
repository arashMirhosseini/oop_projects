require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    
  end
  
  def losing_node?(evaluator)
    if board.over?
      # Note that a loss in this case is explicitly the case where the
      # OTHER person wins: a draw is NOT a loss. Board#won? returns
      # false in the case of a draw.
      return board.won? && board.winner != evaluator
    end
    if evaluator == self.next_mover_mark
 
      children.all? {|child| child.losing_node?(evaluator)}
    else

      children.any? {|child| child.losing_node?(evaluator)}
    end
  
  end

  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator
    end
    if evaluator == self.next_mover_mark
      children.any? {|child| child.winning_node?(evaluator)}
    else
      children.all? {|child| child.winning_node?(evaluator)}
    end
  end

  def children
    children = []
    # mark = :x
    # mark = :o if @next_mover_mark == :x 
    positions = [0,1,2].product([0,1,2])
    positions.each do |pos|
      if @board.empty?(pos)
        new_board = @board.dup
        new_board[pos] = self.next_mover_mark
        next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
        children << TicTacToeNode.new(new_board, next_mover_mark, pos)
      end
    end
    children  
  end

end

# board = Board.new
# mark = :x
# node = TicTacToeNode.new(board, mark)
# node.children
# node = TicTacToeNode.new(Board.new, :x)
# node.board[[0, 0]] = :o
# node.board[[2, 2]] = :o
# node.board[[0, 2]] = :o
