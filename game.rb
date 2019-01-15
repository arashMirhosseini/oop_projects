require_relative "board"
require_relative "tile"
require "byebug"

class Game
    def initialize
        @board = Board.new
        run
    end

    def run
        board.render
        until win?
            
            puts "choose a position on the board: "
            puts "Separate the coordinates with comma, ex: 3,4"
            pos = position(gets.chomp)
            if !valid_pos?(pos)
                raise "Your position is not in a valid range!"
            end
            puts "Reveal? or Flag?"
            puts "r or f?"
            user_move = gets.chomp 
            if !valid_move(user_move)
                raise "That's not valid! please enter r or f"
            end
            r_picked(pos) if user_move == 'r'
            board.render
            if board[pos].bombed?
                board.reveal_all
                board.render
                puts "GAME OVER!"
                return false
            end
        end
        puts "You win!"
    end

    def r_picked(pos)
        board[pos].reveal = true
    end
    
    def win? 
        10.times do |i|
            10.times do |j|
                # byebug
                pos = [i, j]
                if @board[pos].reveal == false || @board[pos].bombed?
                    return false
                end
            end
        end
        true
    end


    def position(str)
        pos = str.split(",")
        [pos[0].to_i, pos[1].to_i]
    end

    def valid_pos?(pos)
        pos[0].between?(0,9) && pos[1].between?(0,9)
    end

    def valid_move(c)
        c == "f" || c == "r"
    end

    attr_reader :board
end

# if __FILE__ ==$Program_Name
#     g = Game.new
# end
g = Game.new