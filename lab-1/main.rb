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

    # Array to hold the cards that will be displayed
    chosenCards = []


    # filldeck method to fill the deck with 81 cards

    # shuffle method to shuffle all the cards

    # pick first 12 cards from the array and call setpresent method
    # to check if a set exists. If it doesn't add 3 cards and check again

    # display the cards

    dealCards(chosenCards)

    # ask for user input
    puts "Input your response by inputting 1,2,3... seprated by a new line"

    # store user input in an array (possibly use integers as identifiers)
    input = []
    input[0] = gets.chomp
    input[1] = gets.chomp
    input[2] = gets.chomp

    # checkifset method checks if the user selected cards make a set



end

# call main method

main
