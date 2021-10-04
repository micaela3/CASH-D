//Function that takes an array of cards and does in place shuffling of the array
function shuffleDeck(array) {
	// Got it from stackoverflow Fisher-Yates algorithm
	for(let i = array.length - 1; i > 0; i--) {
		let j = Math.floor(Math.random() * (i + 1));
		let t = array[i]; 
		array[i] = array[j];
		array[j] = t;
	};
}
