require_relative "piece"
require_relative "slidingPiece"
require "colorize"

class Queen < Piece
  include SlidingPiece

  def symbol
    '♕'.colorize(color)
  end

  def move_dirs
     [[-1, -1],[1, -1],[-1, 1], [1, 1],
    [-1, 0], [1, 0], [0, -1], [0, 1]]
  end
  
end