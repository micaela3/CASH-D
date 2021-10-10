/* 
Global variable that defines current state of game:
0 - Starting Game
1 - Game in Progress
2 - Game Ending 
3 - Cards Being Selected
*/

var gameState = 0;

/* 
Global variable to show which player is currently picking cards:
1 - Player 1 Picking
2 - Player 2 Picking
Will be set to 1 as default.
*/

var playerPicking = 1;

// Global variable for player one.
var playerOne;

//Global variable for player two.
var playerTwo;

//Global variable for number of cards selected
var numCardsSelected = 0;

//Global variable for the deck (to refill chosen cards)
var deck = [];

//Global variable for the chosen cards (cards shown on screen)
var chosenCards = [];

//Globabl variable for the score limit until the game ends
const GAME_SCORE_LIMIT = 1;

// The variable that gets the button that starts the game
const gameStartButton = document.getElementById('gameStartButton');

//Gets the container that holds the button that starts the game
const gameStartContainer = document.getElementById('gameStart');

//Gets the container that holds the form for the player name inputs
const inputContainer = document.getElementById('input');

//Gets the form submit button for the player name input form
const formSubmitButton = document.getElementById('formSubmit');

//Gets the actual form element for the player name input
const form = document.getElementById('nameForm');

//Gets the container element that will hold the cards
const cardsContainer = document.getElementById('cardsContainer');

//The variable that gets the container element that holds the exit button 
const gameEndContainer = document.getElementById('gameEnd');

//Gets the container element for the control instructinos
const controlInstructionsContainer = document.getElementById('playerControlInstructions');

//Gets the container element for the select cards message
const pickCardsReminderContainer = document.getElementById('playerPickCards');

//Gets the span element containing the player 1 name in the controls
const controlPlayer1Name = document.getElementById('controlPlayer1Name');

//Gets the span element containing the player 2 name in the controls
const controlPlayer2Name = document.getElementById('controlPlayer2Name');

//Gets the span element containing the player name for picking cards
const playerPickName = document.getElementById('playerPickName');

//Gets the container element for the check set button
const checkSetContainer = document.getElementById('checkSetContainer');

//Gets the check set button 
const checkSetButton = document.getElementById('checkSetButton');

//Game End Message
const gameEndingMessage = document.getElementById('gameEndingMessage');

//Gets the container element for Player1 score p tag
const playerOneScoreContainer = document.getElementById('player1Score');

//Gets the container element for Player 2 score p tag
const playerTwoScoreContainer = document.getElementById('player2Score');

//Gets the player score container
const scoreContainer = document.getElementById('scoreContainer');

//Gets the winner score container
const winnerScoreContainer = document.getElementById('winnerScoreContainer');

//Gets the loser score container
const loserScoreContainer = document.getElementById('loserScoreContainer');

//Adds the eventlistener for click on the game start button
gameStartButton.addEventListener('click', event => {
	//Makes the container with the game start button invisible so that the next page of the game can be shown
	gameStartContainer.style.display = "none";

	//Displays the form for the player name input on screen
	inputContainer.style.display = "block";
	
	//Displays the game end container tat displays the exit game button
	gameEndContainer.style.display = "block";
});

//Adds the eventlistenere for click on the form submit button
formSubmitButton.addEventListener('click', event => {
	 

	var p1Name = form.playerOne.value;
	var p2Name = form.playerTwo.value;


	if (p1Name.length <= 15 && p2Name.length <= 15 && p1Name.length > 0 && p2Name.length > 0) {

		// Create your player objects with their names and starting score of 0.
		playerOne = new Player(p1Name,1,0);
		playerTwo = new Player(p2Name,2,0);

		//Makes the input container invisible so that the next page of the game can be shown
		inputContainer.style.display = "none";

		//Displays the card container on screen
		cardsContainer.style.display = "block";

		//Display player controls
		controlPlayer1Name.innerHTML = playerOne.name;
		controlPlayer2Name.innerHTML = playerTwo.name;
		controlInstructionsContainer.style.display = "block";

		//Player 1 and 2 score
		scoreContainer.style.display = "block";
		playerOneScoreContainer.innerHTML = playerOne.name + ": " + playerOne.score;
		playerTwoScoreContainer.innerHTML = playerTwo.name + ": " + playerTwo.score;

		//Fill Set card deck.
		deck = fillDeck();

		//Shuffle the deck.
		shuffleDeck(deck);

		chosenCards = chooseCards(deck);

		//Displays the cards on screen
		dealCards(chosenCards);

		//Set game state
		gameState = 1;
	} else {
		alert("Names cannot exceed 15 characters and cannot be blank.")
	}

	
});

document.addEventListener("keypress", function(event) {
    if (gameState == 1 && (event.key === "a" || event.key === "l")) {
        if (event.key === "a") {
		playerChoosing = 1;
		playerPickName.innerHTML = playerOne.name;
        } else if (event.key === "l") {
		playerChoosing = 2;
		playerPickName.innerHTML = playerTwo.name;
        }
	controlInstructionsContainer.style.display = "none";
	pickCardsReminderContainer.style.display = "block";
	
	//Displays the check set container on the page
	checkSetContainer.style.display = "block";


	//Update game state
	gameState = 3;
    }
});

checkSetButton.addEventListener('click', event => {
	//Get all of the selected cards in an array
	let pickedCards = document.querySelectorAll('.card.select');

	//Indexes array to store the position of the cards on screen
	let indexes = [];

	//Checks if the amount of cards are equal to three and runs the code corresponding to it, else sends an alert to the player to let them know to pick three cards
	if(pickedCards.length == 3){

		//Iterates over all of the cards that are selected
		pickedCards.forEach(element => {
			//Pushes the index of each of the card on the screen to the indexes array
			indexes.push(Array.prototype.indexOf.call(cardsContainer.children, element));
		});

		//Checks if the selected cards are a set and runs the corresponding code, else lets the player know that the selected cards are not a set and resets the screen to let any player pick the cards
		if(checkIfSet(chosenCards[indexes[0]], chosenCards[indexes[1]], chosenCards[indexes[2]])){
			
			//If player 1 is the one who chose the cards
			if(playerChoosing == 1){

				/* increment player 1 score */
				playerOne.score++;

				/* display the name and score of player 1 */
				playerOneScoreContainer.innerHTML = playerOne.name + ": " + playerOne.score;
			
			//If player 2 is the one who chose the cards
			}else{

				/* increment player 2 score */
				playerTwo.score++;

				/* display the name and score of player 2 */
				playerTwoScoreContainer.innerHTML = playerTwo.name + ": " + playerTwo.score;
			}

			//Alert to let the player know that the cards selected are indeed a set
			alert("Congratulations, the cards you selected are indeed a set");

			//Checks if the score for any of the player has reached the threshold for the game to end
			if(playerOne.score < GAME_SCORE_LIMIT && playerTwo.score < GAME_SCORE_LIMIT){

				//Gets all of the cards currently being shown on the screen
				let cardsOnScreen = document.querySelectorAll('.card');

				//Iterates over each of the card elements on screen and removes them from the screen
				cardsOnScreen.forEach(element => {
					let parentNode = element.parentNode;
					parentNode.removeChild(element);
				});
				
				//Remove the selected cards from the chosenCards array
				removeCards(chosenCards, chosenCards[indexes[0]], chosenCards[indexes[1]], chosenCards[indexes[2]]);
				
				//Remove the selected cards from the deck array
				removeCards(deck, chosenCards[indexes[0]], chosenCards[indexes[1]], chosenCards[indexes[2]]);
				
				//Adds new cards to the chosenCards array
				chosenCards = refreshCards(chosenCards, deck);

				//Displays those cards on the screen
				dealCards(chosenCards);

				//Hides the check set button from the screen
				checkSetContainer.style.display = "none";

				//Displays the buttons for player input on screen
				controlInstructionsContainer.style.display = "block";

				//Hides the reminder for player to select three cards
				pickCardsReminderContainer.style.display = "none";

				//Changes the game state to in progress
				gameState = 1;

				//Resets the number of cards selected to 0
				numCardsSelected = 0;

			}else{
				//Hides the cards from the screen
				cardsContainer.style.display = "none";

				//Hides the exit button from the screen
				gameEndContainer.style.display = "none";

				//Hides the check set button from the screen
				checkSetContainer.style.display = "none";

				//Hides the reminder for players to select three cards from the screen
				pickCardsReminderContainer.style.display = "none";

				//Hides the player score container from the screen
				scoreContainer.style.display = "none";

				/* game ends */
				gameState = 2;

				/* display the game ending message */
				gameEndingMessage.style.display = "block";

				/* checking which player wins and printing the appropriate message with score */
				if (playerOne.score > playerTwo.score) {
				
					/* display player 1 won and the score of player 1. Also, display player 2 lost and score of player 2 */
					winnerScoreContainer.innerHTML = "The winner is " + playerOne.name + " with the score of " + playerOne.score;
					loserScoreContainer.innerHTML = playerTwo.name + " had the score of " + playerTwo.score; 
				}else{
					/* display player 2 won and the score for player 2. Also display player 1 lost and score of player 1 */
					winnerScoreContainer.innerHTML = "The winner is " + playerTwo.name + " with the score of " + playerTwo.score;
                                        loserScoreContainer.innerHTML = playerOne.name + " had the score of " + playerOne.score; 
				}
			}
		}else{
			//Sends an alert to the player that mentions that the selected cards were not in a set
			alert("The cards selected are not in a set");
			
			//Hides the check set button from the screen
			checkSetContainer.style.display = "none";

			//Displays the player input container on the screen
			controlInstructionsContainer.style.display = "block";

			//Hides the player reminder for selecting three cards from the screen
			pickCardsReminderContainer.style.display = "none";
			
			//Sets the game state to in progress
			gameState = 1;

			//Iterates over each of the selected cards
			pickedCards.forEach(element => {
				//Removes the class 'select' from the cards to get rid of the highlighted background
				element.classList.remove('select');
			});
			
			//Resets the number of cards selected to 0
			numCardsSelected = 0;
		}
	}else{
		//Sends an alert to the player to select three cards
		alert("Please select three cards");
	
		//Hides the check set button from the screen
		checkSetContainer.style.display = "none";

		//Displays the player input container on screen
		controlInstructionsContainer.style.display = "block";

		//Hides the player reminder for selecting three cards from the screen
		pickCardsReminderContainer.style.display = "none";

		//Sets the game state to in progress
		gameState = 1;

		//Iterates over each of the selected cards
		pickedCards.forEach(element => {
			//Removes the class 'select' from the cards to get rid of the highlighted background
			element.classList.remove('select');
		});

		//Resets the number of cards selected to 0
		numCardsSelected = 0;
	}	

});
