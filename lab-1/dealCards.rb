# Assume that you have been passed an array named "chosenCards" of size 21 that has at 
# least 12 (maybe up to 21) cards in it.

# The plan for the method is to use a single loop to generate the output. In this
# loop, we concatenate three cards worth of information into one string, print
# that to the terminal, and repeat until we have reached a nil element in the array
# (meaning that we are dealing less than 21 cards) or we hit the end of the array.

def dealCards(chosenCards)
    
    # control variable for while loop and output string
    pos = 0;
    outputString = "";
    
    # this while loop assumes that either it will hit a nil element in the 
    # array, or the end of the array
    while chosenCards[pos] != nil && pos < 21
        
        # line constructs the output to be like this: 1. One Red Striped Squiggle
        outputString << sprintf("%-33s", "#{pos.to_s} #{chosenCards[pos].to_s} ")
        # outputString = outputString + pos.to_s + " " + chosenCards[pos].count_string + " " +
        # chosenCards[pos].color_string + " " + chosenCards[pos].shading_string + " " + chosenCards[pos].shape_string
        # + "\t";
         
        pos = pos + 1;
        
        # we want the lines of output to have three cards each, so print out
        # (and clear) the string everytime we have a multiple of three
        if (pos % 3 == 0)
            puts outputString + "\n";
            outputString = "";
        end
    
    end
end