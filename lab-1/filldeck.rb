#The number of possible types for each card attribute.
NUM_TYPES = 3

#Fills Set Deck with all cards needed to play one game.
def fillDeck
    deck = []

    #Create each card so that each card is unique and there is a combination of every possible type of card.
    for a in 1..NUM_TYPES do
        for b in 1..NUM_TYPES do
            for c in 1..NUM_TYPES do
                for d in 1..NUM_TYPES do
                    deck << Card.new(a,b,c,d)
                end
            end
        end
    end

    return deck
end