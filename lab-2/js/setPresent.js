/* The function takes in an array of cards to check if a set is present
 * in the array of cards passed to the method before it
 * is displayed to the user. The method returns a boolean which indicates
 * if a set is present in the cards to be displayed
 */

function setPresent (displayCards){

	/* array to hold boolean */
	let numOfSets = false;
	
	/* Loop over each possible combination of cards */
	for(let pos1 = 0; pos1 < displayCards.length - 1; pos1++){
		for(let pos2 = pos1 + 1; pos2 < displayCards.length-1; pos2++){
			for(let pos3 = pos2 + 1; pos3 < displayCards.length-1; pos3++){
		
				let isSet = checkIfSet(displayCards[pos1], displayCards[pos2], displayCards[pos3]);
				
				/* if a set is present, reflect that in numOfSets to be used for identification if a
				 * set is present before displaying the cards 
				 */
				if (isSet){

					numOfSets = true;
				}
			}

		}
	
	}

	return numOfSets;

}
