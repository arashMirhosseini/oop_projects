require_relative "piece"
require "colorize"

class Pawn < Piece

  def symbol
    '♙'.colorize(color)
  end

  def moves
    moves = []
    move_dirs.each do |dx, dy|
      moves.concat(move_forward_not_blocked(dx, dy))
    end
    side_attacks.each do |dx, dy|
      moves.concat(attack_moves(dx,dy))
    end
    moves
  end

  def move_dirs
    self.color == :blue ? [[-1,0], [-2,0]] : [[1,0], [2,0]]
  end

  def side_attacks
    self.color == :blue ? [[-1,1], [-1,-1]] : [[1,-1], [1,1]]
  end

  def move_forward_not_blocked(dx, dy)
    moves = []
    x, y = self.position
    x, y = x+dx, y+dy
    new_position = [x, y]
    if dx.abs != 2
      if @board.empty?(new_position) && @board.valid_pos?(new_position)
        moves << new_position
        position = new_position
      end
    else
      if @board.empty?(new_position) && (self.position[0] == 1 || self.position[0] == 6)
        moves << new_position
        position = new_position
      end
    end
    moves
  end

  def attack_moves(dx, dy)
    moves = []
    x, y = self.position
    x, y = x+dx, y+dy
    position = [x, y]
    if @board.valid_pos?(position)
      if @board[position].color != self.color
        moves << position
      end
    end
    moves
  end

  
end