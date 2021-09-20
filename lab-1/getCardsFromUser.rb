# Number of cards to have the user input
CARDS_TO_PICK = 3

# Get three unique cards from the user
def getCardsFromUser(displayCards)
    cards = []
    for i in 1..CARDS_TO_PICK do
        input = gets.chomp!
        begin
            cardIndex = Integer(input)
            if cardIndex < 0 || cardIndex >= displayCards.length()
                puts "Card chosen must be between 0 and #{displayCards.length()}"
                redo
            end
            if cards.include?(displayCards[cardIndex])
                puts "You already selected this card!"
                redo
            end
            cards << displayCards[cardIndex]
        rescue ArgumentError
            puts "Please enter a card number!"
            redo
        end
    end
    return cards
end