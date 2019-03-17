require_relative "board.rb"
class Game
    
    def initialize(board)
        @board = board
        play
    end

    def prompt
        puts "please enter your selected position: "
        pos_input = gets.chomp
        puts "Please enter your value: "
        val_input = gets.chomp 
        position = [pos_input[0].to_i, pos_input[1].to_i]
        if position[0] > 8 || position[0] < 0 || position[1] > 8 || position[1] < 0 
            puts "wrong range!"
        else
            value = val_input.to_i
           return [position, value]
        end
        prompt
    end
    
    def render
        @board.render 
    end

    def play
        render
        until @board.solved? 
            position_value = prompt
            position = position_value[0]
            value = position_value[1]
            @board[position] = value
            render
        end
    end
end

board = Board.new(Board.from_file("sudoku1.txt"))
Game.new(board)