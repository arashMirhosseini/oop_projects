require 'colorize'
class Tile
    attr_reader :value

    def initialize(val)
        @value = val
        @given = val == 0 ? false : true
    end

    def color
        @given? :blue : :red
    end

    def to_s
        if @value == 0
            " "
        else
            @given? @value.to_s.colorize(color) : @value.to_s.colorize(color)
        end
    end

    def value=(new_value)
        if @given
            puts "You can't change the value of a given tile."
        else
            @value = new_value
        end
    end
end