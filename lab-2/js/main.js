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

//Adds the eventlistener for click on the game start button
gameStartButton.addEventListener('click', event => {
	//Makes the container with the game start button invisible so that the next page of the game can be shown
	gameStartContainer.style.display = "none";

	//Displays the form for the player name input on screen
	inputContainer.style.display = "block";
});

//Adds the eventlistenere for click on the form submit button
formSubmitButton.addEventListener('click', event => {
	//WHOVER DOES THE FORM INPUT HANDLING. PLEASE EDIT THIS AND VALIDATE THE INPUT RECEIVED. THIS IS JUST FOR TESTING PURPOSES ON MY END (SHREY) 

	//Makes the input container invisible so that the next page of the game can be shown
	inputContainer.style.display = "none";

	//Displays the card container on screen
	cardsContainer.display = "block";

	//Displays the cards on screen
	displayCards();
});
