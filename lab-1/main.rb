# main method for the set game

def main

    # welcome message for the user
    puts "Welcome to the game of set"

    # maybe display rules here

    # ask user to start when ready by inputting Y or N
    puts "Are you ready to begin, Y or N?"
    ready = gets.chomp
        if ready != "Y"
                puts "Incorrect response, ending the game"
                exit
        end
    
    puts "Player 1: Enter your name"
    player1 = gets.chomp
    puts "Player 2: Enter your name"
    player2 = gets.chomp

    # Assign each player an alphabet to determine who chooses a set first
    puts "#{player1} you will press 'A' to make a selection"
    puts "#{player2} you will press 'O' to make a selection"
    puts "First player who sees a set will select their alphabet to make a selection"

    # Array to hold the cards that will be displayed
    chosenCards = []


    # filldeck method to fill the deck with 81 cards

    # shuffle method to shuffle all the cards

    # pick first 12 cards from the array and call setpresent method
    # to check if a set exists. If it doesn't add 3 cards and check again

    # display the cards
    dealCards(chosenCards)

    
    # check which player goes first 
    puts "Enter your alphabet:"
    alphabet = get.chomp

    while (alphabet != "A" || alphabet != "O")

        puts "Invalid input!, Please enter a valid input to continue:"
        alphabet = get.chomp
    
    end

    # ask for user input
    puts "Input your response by inputting 1,2,3... seprated by a new line"

    # store user input in an array (possibly use integers as identifiers)
    input = []
    input[0] = gets.chomp
    input[1] = gets.chomp
    input[2] = gets.chomp

    # checkifset method checks if the user selected cards make a set

    checkifSet(input)

end

# call main method

main
                
