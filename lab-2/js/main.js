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

//Player1 score p tag
const playerOneScoreContainer = document.getElementById('player1Score');

//Player 2 score p tag
const playerTwoScoreContainer = document.getElementById('player2Score');

//player score div container
const scoreContainer = document.getElementById('scoreContainer');

//winner score container
const winnerScoreContainer = document.getElementById('winnerScoreContainer');

//loser score container
const loserScoreContainer = document.getElementById('loserScoreContainer');

//Adds the eventlistener for click on the game start button
gameStartButton.addEventListener('click', event => {
	//Makes the container with the game start button invisible so that the next page of the game can be shown
	gameStartContainer.style.display = "none";

	//Displays the form for the player name input on screen
	inputContainer.style.display = "block";

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
	let pickedCards = document.querySelectorAll('.card.select');
	let indexes = [];
	if(pickedCards.length == 3){
		pickedCards.forEach(element => {
			indexes.push(Array.prototype.indexOf.call(cardsContainer.children, element));
		});
		if(checkIfSet(chosenCards[indexes[0]], chosenCards[indexes[1]], chosenCards[indexes[2]])){
			if(playerChoosing == 1){
				playerOne.score++;
				playerOneScoreContainer.innerHTML = playerOne.name + ": " + playerOne.score;
			}else{
				playerTwo.score++;
				playerTwoScoreContainer.innerHTML = playerTwo.name + ": " + playerTwo.score;
			}

			if(playerOne.score < GAME_SCORE_LIMIT && playerTwo.score < GAME_SCORE_LIMIT){
				let cardsOnScreen = document.querySelectorAll('.card');
				cardsOnScreen.forEach(element => {
					let parentNode = element.parentNode;
					parentNode.removeChild(element);
				});

				removeCards(chosenCards, chosenCards[indexes[0]], chosenCards[indexes[1]], chosenCards[indexes[2]]);
				removeCards(deck, chosenCards[indexes[0]], chosenCards[indexes[1]], chosenCards[indexes[2]]);

				chosenCards = refreshCards(chosenCards, deck);

				dealCards(chosenCards);

				checkSetContainer.style.display = "none";
				controlInstructionsContainer.style.display = "block";
				pickCardsReminderContainer.style.display = "none";

				gameState = 1;

				numCardsSelected = 0;

			}else{
				cardsContainer.style.display = "none";
				gameEndContainer.style.display = "none";
				checkSetContainer.style.display = "none";
				pickCardsReminderContainer.style.display = "none";
				scoreContainer.style.display = "none";

				gameState = 2;

				gameEndingMessage.style.display = "block";

				if (playerOne.score > playerTwo.score) {
				
					winnerScoreContainer.innerHTML = "The winner is " + playerOne.name + " with the score of " + playerOne.score;
					loserScoreContainer.innerHTML = playerTwo.name + " had the score of " + playerTwo.score; 
				}else{

					winnerScoreContainer.innerHTML = "The winner is " + playerTwo.name + " with the score of " + playerTwo.score;
                                        loserScoreContainer.innerHTML = playerOne.name + " had the score of " + playerOne.score; 
				}
			}
		}else{
			alert("The cards selected are not in a set");
			
			checkSetContainer.style.display = "none";
			controlInstructionsContainer.style.display = "block";
			pickCardsReminderContainer.style.display = "none";

			gameState = 1;

			pickedCards.forEach(element => {
				element.classList.remove('select');
			});

			numCardsSelected = 0;
		}
	}else{
		alert("Please select three cards");
	}

});
