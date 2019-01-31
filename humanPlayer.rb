require_relative "player"
require_relative "cursor"

class HumanPlayer < Player

  
  def make_move
    # cursor_pos = self.color == :blue ? [6,0] : [1,0]
    # c = Cursor.new(cursor_pos, board)
    # pos = display.cursor.cursor_pos
    start_pos = []
    end_pos = []
    c = nil

    while c == nil 
      
      c = self.display.cursor.get_input
      system("clear")
      self.display.render
      
    end
    start_pos = c

    c = nil
    while c == nil 
      c = self.display.cursor.get_input
      system("clear")
      self.display.render
    end
   
    end_pos = c

    [start_pos, end_pos]
  end  
end