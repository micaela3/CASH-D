# The plan for the method is to check if a set is present
# in the array of cards passed to the method before it
# is displayed to the user.

def setPresent(displayCards)
    # Loop over each possible combination of cards
    for pos1 in 0..(displayCards.length-1) do
        for pos2 in (pos1+1)..(displayCards.length-1) do
            for pos3 in (pos2+1)..(displayCards.length-1) do
                isSet = checkIfSet(displayCards[pos1], displayCards[pos2], displayCards[pos3])
                # once a set is found no need to check for more
                if isSet
                    return isSet
                end
            end
        end
    end
    return isSet
end

