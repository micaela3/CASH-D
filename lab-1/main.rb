# Require other files & their functions
require './checkIfSet'
require './dealCards'
require './fillDeck'
require './generateHint.rb'
require './getCardsFromUser'
require './modifyChosenCards'
require './player'
require './setPresent'
require './shuffleDeck'
require './timer'

# main method for the set game
def main(timerLength, maxScore)

    # welcome message for the user
    puts "Welcome to the game of Set!"

    # ask user to start when ready by inputting Y or N

    puts "Are you ready to begin, y or n?"
    ready = gets.chomp!

    if ready != "y"

        puts "Invalid input or you've chosen not to play :("

        exit

    end

    # get names of the players and initialize the players 
    puts "Player 1: Enter your name."
    player1Name = gets.chomp!
    puts "Player 2: Enter your name."
    player2Name = gets.chomp!

    player1 = Player.new(player1Name, 1, 0)
    player2 = Player.new(player2Name, 1, 0)

    # Assign each player a letter to determine who chooses a set first
    puts "\n#{player1.name} you will press 'a' to make a selection."
    puts "\n#{player2.name} you will press 'o' to make a selection."
    puts "\nFirst player who sees a set will select their letter to make a selection."

    # initial deck to contain the 81 cards
    deck = []

    # filldeck method to fill the deck with 81 cards
    fillDeck(deck)

    # shuffle method to shuffle all the cards
    shuffleDeck(deck)



    # pick first 12 cards from the shuffled deck of cards and check if 
    # a set is present. If a set is not present, add 3 more cards and check
    # again. Continue adding a card until a set is present is in the deck.
    # A set is guranteed to be present when there are 21 cards in the deck.
    # Once a set is determined to be present, display the cards 
    displayCards = chooseCards(deck)    

    # Put main portion of game into a thread, timed to only last 15 minutes by the timer thread (game will automatically end after 15 minutes.)
    # Algorithm for threading taken from https://stackoverflow.com/questions/14250517/making-a-timer-in-ruby, answer from user Catnapper.
    gameThread = Thread.new do

        # continue the game until no cards are left, one player hasn't reached the score threshold, and they players don't want to play again
        while (((deck.length > 0) || (setPresent(displayCards))) && ((player1.score < 5) && (player2.score < 5))) do

            # display the cards
            dealCards(displayCards)

            # players are given a total of 5 hints that they can use during the game
            numOfHints = 5
            puts "Would you like hint? Enter y or n:"
            hint = gets.chomp!

            # check if user requests a hint and is able to get one
            if hint == "y" && numOfHints == 0

                puts "Sorry no more hints available :("

                # print out the hint if available
            elsif hint == "y" && numOfHints > 0

                hintString = setPresent(displayCards)[1]
                puts "One of the cards in a set is #{hintString}"
                numOfHints = numOfHints - 1

                # if hint not wanted
            else

                puts "No hint, Good Luck!"

            end

            # get user identifer input
            puts "\n\nEnter your letter:"
            alphabet = gets.chomp!


            # check for valid input of selection alphabet
            while alphabet != "a" && alphabet != "o" do

                puts "Invalid input! Please enter a valid input to continue:"
                alphabet = gets.chomp!

            end

            # ask for user input
            puts "Input your response by inputting 1,2,3... each separated by a new line."

            # store user input in an array (possibly use integers as identifiers)
            input = getCardsFromUser(displayCards)

            # checkifset method checks if the user selected cards make a set
            isSet = checkIfSet(input[0], input[1], input[2])

            # clear the screen of cluttered text and before scores and more cards are shown
            system("clear")

            # check if the selection is a set 
            if isSet
                # at this point, the user selection was a set, so increment the appropriate score
                if alphabet == "a"
                    player1.score += 1
                    puts "#{player1.name}'s score is now #{player1.score}"
                else
                    player2.score += 1
                    puts "#{player2.name}'s score is now #{player2.score}"
                end
    
                # remove the cards that a user selects that form a set
                removeCards(displayCards, input[0], input[1], input[2])
    
                # replace the cards that were taken out as a set
                refreshCards(displayCards, deck)
            else
                puts "The cards #{input[0]}, #{input[1]}, #{input[2]} are not a set. Resuming play. Any player can select their letter and make a selection."
            end
        end

        # at this point, the game has ended. Print out scores and say who won.
        puts "Game over, final scores:"
        puts "#{player1.name} (player 1): #{player1.score}"
        puts "#{player2.name} (player 2): #{player2.score}"
        if player1.score > player2.score
            puts "Result: #{player1.name} (player 1) wins!"
        elsif player1.score < player2.score
            puts "Result: #{player2.name} (player 2) wins!"
        else 
            puts "Result: Tie!"
        end
    end # end main while loop of game

    # gameTimer will kill game thread after timerLength seconds (defaults to 15 minutes) has elapsed.
    gameTimer = Thread.new {sleep timerLength/60; gameThread.kill; puts "\nGame has ended, time expired."} if timerLength > 0
    # Wait for gameThread to finish or be killed.
    gameThread.join
end

# Default game parameters
# 15 minute timer (60 fps)
maxTime = 15 * 60 * 60
maxScore = 5

# Get indexes, if they exist, of where each command line argument is specified
helpIndex = ARGV.index { |x| x.downcase == "--help"}
noGuiIndex = ARGV.index { |x| x.downcase == "--no-gui"}
maxTimeIndex = ARGV.index { |x| x.downcase.start_with? "--max-time="}
maxScoreIndex = ARGV.index { |x| x.downcase.start_with? "--max-score="}

if maxTimeIndex
    # If a max time is specified, get the string version of the value
    maxTimeString = ARGV[maxTimeIndex].downcase.delete_prefix("--max-time=")
    begin
        # Convert the string value to an integer, and multiply it by the fps, 60
        # If it's any negative integer, set it to 0 for no max time
        maxTime = Integer(maxTimeString) * 60
        maxTime = 0 if maxTime < 0
    rescue ArgumentError
        # Not given an integer, it raised an error during conversion to integer
        puts "Max time must be an integer, defaulting to #{maxTime / 60}!"
    end
end

if maxScoreIndex
    # If a max score is specified, get the string version of the value
    maxScoreString = ARGV[maxScoreIndex].downcase.delete_prefix("--max-score=")
    begin
        # Convert the string value to an integer
        # If it's any negative integer, set it to 0 for no max score
        maxScore = Integer(maxScoreString)
        maxScore = 0 if maxScore < 0
    rescue ArgumentError
        # Not given an integer, it raised an error during conversion to integer
        puts "Max score must be an integer, defaulting to #{maxScore}!"
    end
end

ARGV.clear
if helpIndex
    # Display help messsage
    puts "Usage: ruby main.rb [--help] [--no-gui] [--max-time=<seconds>] [--max-score=<score>]"
    puts "--help: Displays this help message"
    puts "--no-gui: Runs the game in text mode"
    puts "--max-time: Set the timer length, in seconds, or 0 for no timer"
    puts "--max-score: Set the max score, or 0 for no max score"
elsif noGuiIndex
    # Run main if --no-gui is supplied
    main maxTime, maxScore
else
    # Otherwise, attempt to run GUI version
    begin
        require './graphicalSetGame'
        puts "Run with --no-gui for text-based version, or --help for all options!"
        SetGame.new(maxTime, maxScore).show
    rescue LoadError
        # Gosu not installed, default to text version
        puts "Gosu not installed, defaulting to text game"
        puts "Check the README for installation instructions!"
        main maxTime, maxScore
    end
end
