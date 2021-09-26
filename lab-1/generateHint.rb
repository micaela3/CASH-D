require './setPresent.rb'

# Generate a hint
def generateHint(displayCards)
    hintString = setPresent(displayCards)[1]
    "One of the cards in the set is #{hintString}"
end