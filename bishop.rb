require_relative "piece"
require_relative "slidingPiece"
require "colorize"

class Bishop < Piece
  include SlidingPiece

  def symbol
    '♝'.colorize(color)
  end
  
  def move_dirs
    [[-1, -1],[1, -1],[-1, 1], [1, 1]]
  end
end