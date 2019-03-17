require_relative "board.rb"
class Game
    
    def initialize(board)
        @board = board
        run
    end

    def run
        play_turn until solved?
        board.render
        puts "Congratulations, you win!"
    end

    def solved?
        board.solved?
    end

    def play_turn
        board.render
        pos = get_pos
        val = get_val
        board[pos] = val
    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
        puts "Please enter a position on the board (e.g., '3,4')"
        print "> "
        pos = parse_pos(gets.chomp)
        end
        pos
    end

    def get_val
        val = nil
        until val && valid_val?(val)
        puts "Please enter a value between 1 and 9 (0 to clear the tile)"
        print "> "
        val = parse_val(gets.chomp)
        end
        val
    end

    def parse_pos(string)
        string.split(",").map { |char| Integer(char) }
    end

    def parse_val(string)
        Integer(string)
    end

    def valid_pos?(pos)
        pos.is_a?(Array) &&
        pos.length == 2 &&
        pos.all? { |x| x.between?(0, board.size - 1) }
    end

    def valid_val?(val)
        val.is_a?(Integer) &&
        val.between?(0, 9)
    end
    
    def render
        board.render 
    end

    private
  
    attr_reader :board
end

board = Board.new(Board.from_file("sudoku1.txt"))
Game.new(board)