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
		controlInstructionsContainer.style.display = "block";

		//Fill Set card deck.
		var deck = fillDeck();

		//Shuffle the deck.
		shuffleDeck(deck);

		//Displays the cards on screen
		dealCards(deck);

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
        } else if (event.key === "l") {
            playerChoosing = 2;
        }
        controlInstructionsContainer.style.display = "none";
        pickCardsReminderContainer.style.display = "block";

		//Update game state
		gameState = 3;
    }
});