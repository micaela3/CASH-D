# Require other files & their functions
require './checkIfSet'
require './dealCards'
require './fillDeck'
require './modifyChosenCards'
require './player'
require './setPresent'
require './shuffleDeck'
require './getCardsFromUser'

# main method for the set game

def main

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

      # check if the selection is a set 
      while (!isSet) do

        # tell the player that their selection was not a set
        puts "The cards #{input[0]}, #{input[1]}, #{input[2]} are not a set. Resuming play. Any player can select their letter and make a selection."

        puts "Would you like hint? Enter y or n:"
        hint = gets.chomp!

        # clear the screen of cluttered text and redisplay the cards
        system("clear")
        dealCards(displayCards)

        # check if the user wants a hint and can get one
        if hint == "y" && numOfHints == 0

          puts "Sorry no more hints available :("

          # print out the hint if available
        elsif hint == "y" && numOfHints > 0

          hintString = setPresent(displayCards)[1]
          puts "One of the cards in the set is #{hintString}"
          numOfHints = numOfHints - 1

          # if user does not want a hint
        else

          puts "No hint, Good Luck!"

        end

        # ask for player identifier input
        puts "Enter your letter:"
        alphabet = gets.chomp!

        # make sure that the user input a correct identifier
        while alphabet != "a" && alphabet != "o" do

          puts "Invalid input, please enter a valid input to continue:"
          alphabet = gets.chomp!

        end

        # collect user selection
        puts "Input your response by inputting 1,2,3... each separated by a new line."

        input = getCardsFromUser(displayCards)
        isSet = checkIfSet(input[0], input[1], input[2])

      end

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

  # gameTimer will kill game thread after 15 minutes has elapsed.
  gameTimer = Thread.new {sleep 900; gameThread.kill; puts "\nGame has ended, time expired."}
  # Wait for gameThread to finish or be killed.
  gameThread.join
end



# call main method

main


