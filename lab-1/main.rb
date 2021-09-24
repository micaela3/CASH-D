# Require gems
require 'gosu'
# Require other files & their functions
require './checkIfSet'
require './dealCards'
require './drawCards'
require './fillDeck'
require './generateHint.rb'
require './getCardsFromUser'
require './modifyChosenCards'
require './player'
require './setPresent'
require './shuffleDeck'
require './timer'

# main method for the set game
def main

    # welcome message for the user
    puts "Welcome to the game of set!"


    # maybe display rules here

    # ask user to start when ready by inputting Y or N

    puts "Are you ready to begin, y or n?"
    ready = gets.chomp!

        if ready != "y"

          puts "Invalid input or you've chosen not to play :("

                exit

        end

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

        # continue the game until no cards are left
        while (((deck.length > 0) || (setPresent(displayCards))) && ((player1.score < 5) && (player2.score < 5))) do

            # display the cards
            dealCards(displayCards)
                    
            # players are given a total of 5 hints that they can use during the game
            numOfHints = 5
            puts "Would you like hint? Enter y or n:"
            hint = gets.chomp!

            # check if user requests a hint
            if hint == "y" && numOfHints == 0

              puts "Sorry no more hints available :("

            elsif hint == "y" && numOfHints > 0

              hintString = setPresent(displayCards)[1]
              puts "One of the cards in the set is #{hintString}"
              numOfHints = numOfHints - 1

            else

              puts "No hint, Good Luck!"
            
            end

            # check which player goes first 
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


              puts "The cards #{input[0]}, #{input[1]}, #{input[2]} are not a set. Resuming play. Any player can select their letter and make a selection."

              puts "Would you like hint? Enter y or n:"
              hint = gets.chomp!

              if hint == "y" && numOfHints == 0

                puts "Sorry no more hints available :("

              elsif hint == "y" && numOfHints > 0

                puts generateHint(displayCards)
                numOfHints = numOfHints - 1

              else

                puts "No hint, Good Luck!"
            
              end

              puts "Enter your letter:"
              alphabet = gets.chomp!

              while alphabet != "a" && alphabet != "o" do

                puts "Invalid input, please enter a valid input to continue:"
                alphabet = gets.chomp!

              end
              puts "Input your response by inputting 1,2,3... each separated by a new line."
            
              input = getCardsFromUser(displayCards)
              isSet = checkIfSet(input[0], input[1], input[2])

            end

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

    end

    # gameTimer will kill game thread after 15 minutes has elapsed.
    gameTimer = Thread.new {sleep 900; gameThread.kill; puts "\nGame has ended, time expired."}
    # Wait for gameThread to finish or be killed.
    gameThread.join
end


# call main method

# main

# Game states
module Game_State
    ENTER_NAME1 = 0
    ENTER_NAME2 = 1
    START = 2
    VIEW_CARDS = 3
    CHOOSE_CARDS = 4
    TALLY_RESULTS = 5
    SHOW_RESULTS = 6
    EXITED = 7
end

# Game class
class SetGame < Gosu::Window
    # Screen Dimensions
    SCREEN_WIDTH = 1280
    SCREEN_HEIGHT = 720
    # 30 frame cursor blink rate
    CURSOR_BLINK_RATE = 30 
    # 15 minute timer (60 fps)
    TIMER_LENGTH = 1 * 60 * 60

    # Initialize game
    def initialize
      super SCREEN_WIDTH, SCREEN_HEIGHT
      self.caption = "Set Game"
      # Set state to enter names
      @state = Game_State::ENTER_NAME1
      @gameName = Gosu::Image.from_text("CASH'D SET GAME", 80)
      @cursor = Gosu::Image.new("Cursor.png", :tileable => false)
      # Player 1 name prompt
      @player1NamePrompt = Gosu::Image.from_text("Enter player 1's name: ", 40)
      @player1Input = Gosu::TextInput.new()
      self.text_input = @player1Input
      @player1Font = Gosu::Font.new(25)
      # Text cursor for names
      @cursorTime = 0
      @cursorBlink = false
    end
    
    # Handle game updates (mostly state changes)
    def update
        if @state == Game_State::START
            # Set up players
            @player1 = Player.new(@player1Name, 1, 0)
            @player2 = Player.new(@player2Name, 1, 0)
            # Create instructions
            @instructions = [
            Gosu::Image.from_text("To play, each player will look at the cards and try to be the first to find a set.", 20),
            Gosu::Image.from_text("A set is three cards with all the same or different of each of property:", 20),
            Gosu::Image.from_text("Number, color, shading, and shape.", 20)
            ]
            @controls = Gosu::Image.from_text("Player 1 will press 'A' to select a set, and Player 2 will press 'L'. Press 'H' to receive a hint.", 20)
            @mistakeText = Gosu::Image.from_text("Cards chosen did not make a set, try again!", 20)

            # Scores
            @player1Score = Gosu::Font.new(30)
            @player2Score = Gosu::Font.new(30)

            # Timer
            @timerDisplay = Gosu::Font.new(40)

            # Hints
            @hintsLeft = Gosu::Font.new(30)

            # initial deck to contain the 81 cards
            @deck = []
            
            # Set timer to 0
            @timer = 0

            # Set hints to 5
            @hintsAvailable = 5
            @currentHint = nil

            # filldeck method to fill the deck with 81 cards
            fillDeck(@deck)

            # shuffle method to shuffle all the cards
            shuffleDeck(@deck)

            # pick first 12 cards from the shuffled deck of cards and check if 
            # a set is present. If a set is not present, add 3 more cards and check
            # again. Continue adding a card until a set is present is in the deck.
            # A set is guranteed to be present when there are 21 cards in the deck.
            # Once a set is determined to be present, display the cards 

            @displayCards = chooseCards(@deck)  

            # No incorrect sets chosen
            @mistake = false

            # Set game state to view cards
            @state = Game_State::VIEW_CARDS
        elsif @state == Game_State::VIEW_CARDS || @state == Game_State::CHOOSE_CARDS 
            @timer += 1
            if @timer >= TIMER_LENGTH
                # Timer has went past max game length, end the game
                @state = Game_State::TALLY_RESULTS
            end
        end
        if @state == Game_State::CHOOSE_CARDS && @chosenCards.length == 3
            # checkifset method checks if the user selected cards make a set
            isSet = checkIfSet(@chosenCards[0], @chosenCards[1], @chosenCards[2])

            if isSet
                @player1.score += 1 if @playerChoosing == 1
                @player2.score += 1 if @playerChoosing == 2
                # remove the cards that a user selects that form a set
                removeCards(@displayCards, @chosenCards[0], @chosenCards[1], @chosenCards[2])

                # replace the cards that were taken out as a set
                refreshCards(@displayCards, @deck)

                #Reset mistake tracker
                @mistake = false

                if !setPresent(@displayCards) || @player1.score >= 5 || @player2.score >= 5
                    # No more possible sets, or a player has enough points, end the game now
                    @state = Game_State::TALLY_RESULTS
                end
            else
                # Show the user that they made a mistake
                @mistake = true
            end
            @currentHint = nil
            @state = Game_State::VIEW_CARDS
        end
        if @state == Game_State::TALLY_RESULTS
            @winnerText = Gosu::Image.from_text("Player 1 wins!", 60) if @player1.score > @player2.score
            @winnerText = Gosu::Image.from_text("Player 2 wins!", 60) if @player1.score < @player2.score
            @winnerText = Gosu::Image.from_text("It's a tie!", 60) if @player1.score == @player2.score
            @state = Game_State::SHOW_RESULTS
        end
    end
    
    # Update the screen depending on game state
    def draw
        # Draw background (a nice light green color)
        draw_rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, Gosu::Color.new(0xFF, 0xA8, 0xF0, 0xB6))
        @cursor.draw(mouse_x-4, mouse_y-4, 10)
        if @state == Game_State::ENTER_NAME1 || @state == Game_State::ENTER_NAME2
            # Draw game name
            @gameName.draw(320, 50, 1, 1, 1, 0xff_000000)
            # Increment blinker counter
            @cursorTime += 1
            if @cursorTime == CURSOR_BLINK_RATE
                @cursorTime = 0
                @cursorBlink = !@cursorBlink
            end
            # Set blinker character
            blinker = "|" if @cursorBlink
            blinker = " " if !@cursorBlink
        end
        if @state == Game_State::ENTER_NAME1
            # State for entering player 1 name
            # Name prompt
            @player1NamePrompt.draw(445, 200, 1, 1, 1, 0xff_000000)
            # Draw current entered name
            @player1Font.draw_text("> #{@player1Input.text[0, @player1Input.caret_pos]}#{blinker}#{@player1Input.text[@player1Input.caret_pos..]}", 445, 240, 1, 1, 1, 0xff_000000)
        elsif @state == Game_State::ENTER_NAME2
            # Draw game name, previous name, and prompt
            @gameName.draw(320, 50, 1, 1, 1, 0xff_000000)
            @player1NamePrompt.draw(445, 200, 1, 1, 1, 0xff_000000)
            @player1Font.draw_text("#{@player1Input.text}", 445, 240, 1, 1, 1, 0xff_000000)
            # Name prompt
            @player2NamePrompt.draw(445, 320, 1, 1, 1, 0xff_000000)
            # Draw current entered name
            @player2Font.draw_text("> #{@player2Input.text[0, @player2Input.caret_pos]}#{blinker}#{@player2Input.text[@player2Input.caret_pos..]}", 445, 360, 1, 1, 1, 0xff_000000)
        elsif @state == Game_State::VIEW_CARDS || @state == Game_State::CHOOSE_CARDS
            for i in 0..(@instructions.length-1) do
                @instructions[i].draw(50, 20+(i*25), 1, 1, 1, 0xff_000000)
            end
            drawCards(@displayCards, 20+((@instructions.length+2) * 25), SCREEN_WIDTH, SCREEN_HEIGHT)
            @player1Score.draw_text("Player 1: #{@player1.score}", SCREEN_WIDTH - 400, 60, 1, 1, 1, 0xff_000000)
            @player2Score.draw_text("Player 2: #{@player2.score}", SCREEN_WIDTH - 400, 110, 1, 1, 1, 0xff_000000)
            @hintsLeft.draw_text("Hints: #{@hintsAvailable}", SCREEN_WIDTH - 150, 85, 1, 1, 1, 0xff_000000)
            @timerDisplay.draw_text("Time remaining: #{getTimerString(TIMER_LENGTH - @timer)}", SCREEN_WIDTH - 400, 10, 1, 1, 1, 0xff_000000)
            if @state == Game_State::VIEW_CARDS
                @controls.draw(50, 20+(@instructions.length*25), 1, 1, 1, 0xff_000000)
                if @mistake
                    @mistakeText.draw(50, 20+((@instructions.length+1)*25), 1, 1, 1, 0xff_000000)
                elsif @currentHint
                    @currentHint.draw(50, 20+((@instructions.length+1)*25), 1, 1, 1, 0xff_000000)
                end
            else
                cardText = "cards" if (3 - @chosenCards.length) != 1
                cardText = "card" if (3 - @chosenCards.length) == 1
                @choosePrompt.draw_text("Player #{@playerChoosing}, select #{3 - @chosenCards.length} more #{cardText}", 50, 20+(@instructions.length*25), 1, 1, 1, 0xff_000000)
            end
        elsif @state == Game_State::SHOW_RESULTS
            @winnerText.draw(500, 300, 1, 1, 1, 0xff_000000)
        end
    end

    # Handle mouse / keyboard input
    def button_down(id)
        super
        if id == Gosu::KB_RETURN
            # Enter key
            if @state == Game_State::ENTER_NAME1
                if @player1Input.text.length > 0
                    # Save player 1's name
                    @player1Name = @player1Input.text
                    # Get player 2's name
                    @player2NamePrompt = Gosu::Image.from_text("Enter player 2's name: ", 40)
                    @player2Input = Gosu::TextInput.new()
                    self.text_input = @player2Input
                    @player2Font = Gosu::Font.new(25)
                    @state = Game_State::ENTER_NAME2
                end
            elsif @state == Game_State::ENTER_NAME2
                # Save player 2's name
                @player2Name = @player2Input.text
                # Start the game
                @state = Game_State::START
            end
        elsif (id == Gosu::KB_A || id == Gosu::KB_L) && @state == Game_State::VIEW_CARDS
            # Player wants to select cards
            # Set the player choosing
            @playerChoosing = 1 if id == Gosu::KB_A
            @playerChoosing = 2 if id == Gosu::KB_L

            # "Player (X) choose (Y) cards"
            @choosePrompt = Gosu::Font.new(20)
            
            # Array for chosen cards
            @chosenCards = []

            # Update the game state
            @state = Game_State::CHOOSE_CARDS
        elsif id == Gosu::KB_H && @state == Game_State::VIEW_CARDS && !@currentHint && @hintsAvailable > 0
            # Give a hint
            @currentHint = Gosu::Image.from_text(generateHint(@displayCards), 20)
            @hintsAvailable -= 1
            @mistake = false
        elsif id == Gosu::MS_LEFT && @state == Game_State::CHOOSE_CARDS
            clickedCard = getClickedCard(@displayCards, 20+((@instructions.length+2) * 25), SCREEN_WIDTH, SCREEN_HEIGHT, mouse_x, mouse_y)
            if clickedCard && !@chosenCards.include?(clickedCard)
                @chosenCards << clickedCard
            end
        end
    end

    # Handle user closing game
    def close
        # Redirect stderr because it would seem that gosu has a bug on some platforms where exiting causes a segfault
        $stderr.reopen(IO::NULL, "w")
        @state = Game_State::EXITED
        self.close!
    end
end

SetGame.new.show
