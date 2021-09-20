# Constants for the card's count attribute
module Count
    ONE = 1
    TWO = 2
    THREE = 3
end

# Constants for the card's shape attribute
module Shape
    DIAMOND = 1
    SQUIGGLE = 2
    OVAL = 3
end

# Constants for the card's shading attribute
module Shading
    SOLID = 1
    STRIPED = 2
    OPEN = 3
end

# Constants for the card's color attribute
module Color
    RED = 1
    GREEN = 2
    PURPLE = 3
end

# Card class
class Card
    # Initialize it and set all of the attributes
    def initialize(count, shape, shading, color)
        @count = count
        @shape = shape
        @shading = shading
        @color = color
    end

    # Return the card count
    def count
        return @count
    end

    # Return a human-readable string of the card count
    def count_string
        case @count
        when 1
            "One"
        when 2
            "Two"
        when 3
            "Three"
        end
    end

    # Return the card shape
    def shape
        return @shape
    end

    # Return a human-readable string of the card shape
    def shape_string
        case @shape
        when 1
            "Diamond"
        when 2
            "Squiggle"
        when 3
            "Oval"
        end
    end

    # Return the card shading
    def shading
        return @shading
    end

    # Return a human-readable string of the card shading
    def shading_string
        case @shading
        when 1
            "Solid"
        when 2
            "Striped"
        when 3
            "Open"
        end
    end

    # Return the card color
    def color
        return @color
    end

    # Return a human-readable string of the card color
    def color_string
        case @color
        when 1
            "Red"
        when 2
            "Green"
        when 3
            "Purple"
        end
    end

    # Return a human-readable version of the card
    def to_s
        return "#{count_string} #{color_string} #{shading_string} #{shape_string}"
    end
end
