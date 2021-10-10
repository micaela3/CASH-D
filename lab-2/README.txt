Name of Project:
- JavaScript Implementation of "Set"

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

The game will end when one player reaches the score threshold of 5 points.


Description of Project:
- This game is an implementation of the game of "Set" using the JavaScript programming language, along with HTML and CSS.
The game has a score threshold of 5, so after one player reaches a score of 5 the game will end with the player at 5 points declared as the winner.


Installation Directions:
- The game is located at https://github.com/cse-3901-sharkey/CASH-D.git inside the "lab-2" folder. To install it,
either clone the repository to your directory using the link above with the appropriate git command (below) or download
the zip file and unzip it to a desired location.
     - git clone https://github.com/cse-3901-sharkey/CASH-D.git


How to Run:
To run the game, open the index.html in a web browser.
Once the menu loads, a welcome message will display and players can click the play button if they wish to play the game.
Once the players have clicked the play button, the game will ask for the names of the two players.
Once the names have been input, the menu will display instructions on  how each player is to validate their input and the game will begin.
There will also be the score of the 2 players displayed at the top of the screen, along with an exit button if players wish to exit
the game before it is finished. During the game, images of the cards currently "in play" will be displayed to the players.
Once a player thinks they have identified a set, the player must input their identifier and then select  the three cards they believe are in a set by clicking the
three cards they believe are a set and then clicking the "next" button. If the cards are NOT a set, a pop up will display that says the cards are not a set,
and then any player can guess a set again. If the cards selected are a set, a pop up will display that says the cards selected were a set, and the user
who guessed the set will have their score incremented. The game will end when a player reaches the score threshold of 5 points.
At that moment, the game will display a congratulatory message to the winner and show the scores of both players. The players then have the option to play
again by pressing the "Play Again" button, or they can exit out of the web browser and be done with the game.

If the players wish to terminate the game before reaching the end of the game, they simply have to press the exit button in the top-right of the screen.
