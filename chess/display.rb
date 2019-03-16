require "colorize"
require_relative "board"
require_relative "cursor"

class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    8.times do |i|
      8.times do |j|
        if @cursor.cursor_pos == [i, j]
          print "  " + board[[i,j]].symbol.colorize(:yellow)
        elsif !@board.empty?([i,j])
          print "  " + board[[i,j]].symbol
        else
          print "  " + @board.sentinel.symbol 
        end
      end
      puts
    end
  end

  
end

#  b = Board.new
#  d = Display.new(b)
# d.render
# b.move_piece!([0,1], [2,0])
# d.render
# b.move_piece!([2,0], [4,1])
# d.render