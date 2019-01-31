require_relative "piece"
require "singleton"
require "colorize"

class NullPiece < Piece
  include Singleton 

  attr_reader :symbol, :color
  def initialize
    @symbol = '_'.colorize(:white)
    @color = :white
  end

  def moves
  end

  
end