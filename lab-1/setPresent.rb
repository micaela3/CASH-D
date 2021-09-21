# The plan for the method is to check if a set is present
# in the array of cards passed to the method before it
# is displayed to the user. The method returns an array
# containing a boolean indicating presence of set and
# an integer indicating number of sets possible in current
# array of cards to be displayed as hint

def setPresent(displayCards)

    # array to hold boolean and integer
    numOfSets = [false, 0]

    # Loop over each possible combination of cards
    for pos1 in 0..(displayCards.length-1) do
        for pos2 in (pos1+1)..(displayCards.length-1) do
            for pos3 in (pos2+1)..(displayCards.length-1) do
                isSet = checkIfSet(displayCards[pos1], displayCards[pos2], displayCards[pos3])
                # once a set is found no need to check for more
                if isSet
                    numOfSets[0] = true
                    numOfSets[1] = numOfSets[1] + 1 
                end
            end
        end
    end
    return numOfSets
end

