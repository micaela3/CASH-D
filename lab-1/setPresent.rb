# The plan for the method is to check if a set is present
# in the array of cards passed to the method before it
# is displayed to the user. The method returns an array
# containing a boolean indicating presence of set,
# and a string indicating one card in the deck that is
# part of set that is present

def setPresent(displayCards)

    # array to hold boolean and integer
    numOfSets = [false,""]

    # Loop over each possible combination of cards
    for pos1 in 0..(displayCards.length-1) do
        for pos2 in (pos1+1)..(displayCards.length-1) do
            for pos3 in (pos2+1)..(displayCards.length-1) do
                isSet = checkIfSet(displayCards[pos1], displayCards[pos2], displayCards[pos3])
                # once a set is found no need to check for more
                if isSet
                    numOfSets[0] = true
                    numOfSets[1] = displayCards[pos1].to_s
                end
            end
        end
    end
    return numOfSets
end

