//The number of possible types for each card attribute
var NUM_TYPES = 3;
// Fills Set deck with all cards needed to play one game.
function fillDeck(deck) {

    //Create each card so that each card is unique and there is a combination of every possible type of card.
    for (var a = 1; a <= NUM_TYPES; a++) {
        for (var b = 1; b <= NUM_TYPES; b++) {
            for (var c = 1; c <= NUM_TYPES; c++) {
                for (var d = 1; d <= NUM_TYPES; d++) {
                    deck.push(new Card(a,b,c,d));
                }
            }
        }
    }

    return deck;
}
