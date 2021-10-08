/* This function will take an array of cards and display those cards on the screen for the user.
 * Additionally, it will also add an event lister to each of the cards that checks to see if they
 * have been clicked. If they haven't been clicked, the background will change to a different color.
 * If they have been clicked, the background will change back to the original color.
 */

function dealCards(chosenCards) {
	var pos = 0;

        //the loop will run will there are still cards left and no more than 21 cards have been displayed
        while ((chosenCards[pos] != undefined) && pos < 21)  {

		//add a new div element to the cardsContainer using the image of the right card	
		cardsContainer.innerHTML += "<div class='card'><img src='img/" + chosenCards[pos].toString + ".png' /> </div>";
		pos++;
        }

        //Gets all the card divs in the form of an array
        const cards = document.querySelectorAll('.card');

        //Loops over each of the card divs
        cards.forEach(item => {
                //Adds a click event listener to the card div
                item.addEventListener('click', event => {
                        //Checks if the card has already been clicked and if not then adds the select class which changes the background color of the card to give user feedback
                        if(item.classList.contains('select')) {
                                //Removes the select class from the classlist if the card was already clicked
                                item.classList.remove('select');
                        }else{
                                //Adds the class to the classlist if the card has not been clicked before
                                item.classList.add('select');
                        };
                });
        });
};
