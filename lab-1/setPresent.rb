# The plan for the method is to check if a set is present
# in the array of cards passed to the method before it
# is displayed to the user.

def setPresent(displayCards)

    pos = 0
    while pos < displayCards.length - 2 do
        while pos + 1 < displayCards.length - 1 do
            while pos + 2 < displayCards.length do
                isSet = checkifSet(displayCards[pos], displayCards[pos + 1], displayCards[pos + 2])
                pos = pos + 1
                
                # once a set is found no need to check for more
                if isSet == true

                    return isSet
   
                end
            end
        end
    end
    return isSet
end

