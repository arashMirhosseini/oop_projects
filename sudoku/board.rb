require_relative "tile.rb"
require "byebug"
class Board
    

    def self.from_file(filename)
        rows = File.readlines(filename).map(&:chomp)
        tiles = rows.map do |row|
            nums = row.split("").map { |char| Integer(char) }
            nums.map { |num| Tile.new(num) }
        end
    end

    def self.empty_grid
        Array.new(9) do 
            Array.new(9) {Tile.new(0)}
        end
    end

    def initialize(grid = Board.empty_grid)
        @grid = grid 
    end

    def []=(position, new_value)
        x, y = position
        @grid[x][y].value=(new_value)
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    def solved? 
        solved_row? && solved_column? && solved_square? 
    end

    def solved_row?
        grid.all? do |row|
            arr = []
            row.each_with_index do |tile, i|
                arr << tile.value
            end
            arr.sort == (1..9).to_a
        end
    end

    def solved_column?
        grid_transpose = grid.transpose 
        grid_transpose.all? do |row|
            arr = []
            row.each_with_index do |tile, i|
                arr << tile.value
            end
            arr.sort == (1..9).to_a
        end
    end

    def solved_square?
        index = sub_square_index
        i_idx = index[0]
        j_idx = index[1]
        i_idx.length.times do |idx|
            arr = sub_square(i_idx[idx], j_idx[idx])
            return false if arr.sort != (1..9).to_a
        end
        return true
    end

    def sub_square_index
        i_idx =[]
        j_idx =[]
        i = 0
        while i < 9
            i_idx << i << i << i
            j = 0
            while j < 9
                j_idx << j
                j += 3
            end
            i += 3
        end
        [i_idx, j_idx]
    end


    def sub_square(i,j)
        arr = []
        (i...i+3).each do |r|
            (j...j+3).each do |c|
                arr << grid[r][c].value
            end
        end
        arr
    end

    def render
        # byebug
        puts "  #{(0..8).to_a.join(' ')}"
        grid.each_with_index do |row, i|
            puts "#{i} #{row.join(' ')}"
        end
    end

    def size
        grid.size
    end

    private
    attr_reader :grid
end
