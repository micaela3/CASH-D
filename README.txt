Name of Project: 
- Ruby Implementation of "Set"

Description of the Game "Set":
- "Set" is a game that was designed by Marsha Falcon in 1974. The objective of the game is to find as many sets
as possible from a deck of cards. The deck of cards consists of 81 unique cards that have four disctinct features
that can each vary in three ways. 
   - Number of Shapes (one, two, three)
   - Color (red, green, purple)
   - Shading (solid, striped, open)
   - Shape (diamond, squiggle, oval)
A set is defined as a combination of three cards that satisfies all four of the conditions below:
   - They all have the same number or have three different numbers.
   - They all have the same color or have three different colors.
   - They all have the same shading or have three different shadings.
   - They all have the same shape or have three different shapes.

For example, the three cards below form a set:
   - one green open squiggle
   - one purple open diamond
   - one red open oval

The game usually consists of one dealer and two or more players (the dealer can also play as well). However,
a player could play by themselves and act as the dealer as well. The dealer deals out 12 cards to start and 
the players then try and find a set. If a player finds one, they must yell out "SET!" and take the three cards 
that they believe are part of a set. If the player is correct, the cards are removed and the dealer deals three 
more cards. If the player is incorrect, the cards are simply placed back with the rest of the dealt cards and 
play continues.

It's possible that there may not be a set in the initial 12 cards that are dealt. If that's the case, the dealer
continuously deals three extra cards (bring the total to 15, 18, 21, etc.) until a set can be
found. Once 21 cards have been dealt, there is guaranteed to be at least one set in the cards on the table.

The game can end in a multitude of ways. By default,
the game ends when there are no more cards to deal and there isn't a set on the table. At that point, whomever has
the most sets wins. However, players can also agree to a score threshold, a time limit, or both.


Description of Project:
- This game is an implementation of the game of "Set" using the Ruby on Rails programming language.
The game can either be played in a text-based command line interfaced style or with a graphical interface. It's worth noting that it's generally
easier for newer players to succeed in the game using the graphical interface. The game has a time limit of 15 minutes as well as a score threshold of 5
The game also features a hint generator, which tells the user how many sets are present in the available cards.


Installation Requirements:
- This game was developed using Ruby v2.7.4 and Rails v6.1.4. Therefore, a command line interface running those versions
(or higher) of Ruby and Rails is required.

- Additional requirements are necessary to run the graphical interface version of the game. More information is listed below in the 
"Installation Directions" section

Installation Directions:
- The game is located at https://github.com/cse-3901-sharkey/CASH-D.git inside the "lab-1" folder. To install it,
either clone the repository to your directory using the link above with the appropriate git command (below) or download
the zip file and unzip it to a desired location.
     - git clone https://github.com/cse-3901-sharkey/CASH-D.git

- To run the graphical version, the commands below must be run. Simply answer yes when it asks for installation permission and wait until everything has been downloaded. 
   - sudo apt-get install build-essential libsdl2-dev libgl1-mesa-dev libopenal-dev \libgmp-dev libfontconfig1-dev
   - gem install gosu


NOTE: The game will default to the text version. Once the above commands have been installed for the graphical version, the graphical version
will run everytime. To run the game without graphics, run the following command
   - ruby main.rb --no-gui

How to Run:
To run the game, type the command "ruby main.rb". Once the menu loads, a welcome message will display and players will be
asked if they wish to play the game. Once the players have selected "yes", the menu will ask for the names of the two players.
Once the names have been input, the menu will display instructions on  how each player is to validate their input and the game will begin 
(the timer will also start). During the game, textual information (or the cards themselves for the graphics version) for all of the cards
will be displayed to the players. If necessary, the players can ask for a hint and will be told one card that is part of a set.
For the text version, the player must input their indentifier and then the number of the card they wish to select followed by a new line 
(i.e. "a" <enter> "8" <enter> "9" <enter> "10" <enter>). For the graphics version, the player must input their identifier and then select 
the three cards they believe are in a set by clicking the mouse. The game will end under one of several conditions: the time limit runs out, 
there are no more cards to be dealt and/or there are no more sets available, or a player reaches the score threshold. At that moment, the 
menu will display a congratulatory message to the winner (or a different message if there's a tie) and then the game will terminate. If the 
players wish to terminate the game before reaching any of the game-ending conditions listed above, they simply have to press Ctrl + C.
