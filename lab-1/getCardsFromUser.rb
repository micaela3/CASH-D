# Number of cards to have the user input
CARDS_TO_PICK = 3

# Get three unique cards from the user
def getCardsFromUser(displayCards)
    cards = []
    # Get three cards
    for i in 1..CARDS_TO_PICK do
        input = gets.chomp!
        begin

            cardIndex = Integer(input)
            # Make sure its a proper index
            if cardIndex < 0 || cardIndex >= displayCards.length()
                puts "Card chosen must be between 0 and #{displayCards.length()}"
                redo
            end
            # Make sure it's not a duplicate
            if cards.include?(displayCards[cardIndex])
                puts "You already selected this card!"
                redo
            end
            # Add the selected card
            cards << displayCards[cardIndex]
        rescue ArgumentError
            # Not given an integer, it raised an error during conversion to integer
            puts "Please enter a card number!"
            redo
        end
    end
    # Return the selected cards
    return cards
end