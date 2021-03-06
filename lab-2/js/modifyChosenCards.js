// Minimum number of cards to choose
const MIN_CARDS = 12;

//Amount of cards to "refresh" after a set is made
const REFRESH_AMOUNT = 3;

/* Create a sub-array of cards from a deck
 such that there is at least one possible set
 and there is at least 12 cards*/
function chooseCards(deck) {
    const chosenCards = [];
    i = 0;
    /* Iterate at least 12 times for 12 cards,
     but also add cards as long as a set is not possible
     (ensuring the number of cards is a multiple of 3)*/
    while ((i < MIN_CARDS || !setPresent(chosenCards) || i % 3 != 0) && deck.length > 0) {
        /* Pop cards from the end of the deck, 
         so that the same cards will not be drawn again*/
        chosenCards.push(deck.pop());
        i++;
    }
    return chosenCards;
}

/* Chooses (at least) 3 more cards to replace
 3 cards that have been removed after making a set */
function refreshCards(chosenCards, deck) {
    let i = 0;
    /* Iterate at least 3 times to replace the used cards,
     but also add cards as long as a set is not possible
     (ensuring the number of cards is a multiple of 3)*/
    while ((i < REFRESH_AMOUNT || !setPresent(chosenCards) || i % 3 != 0) && deck.length > 0) {
        /* Pop cards from the end of the deck, 
         so that the same cards will not be drawn again*/
         chosenCards.push(deck.pop());
         i++;
    }
    return chosenCards;
}

/* Remove cards that have been used to make a set
 (must call checkIfSet first) */
function removeCards(chosenCards, card1, card2, card3) {
    //Delete each card from the chosen cards array
    chosenCards.splice(chosenCards.indexOf(card1), 1);
    chosenCards.splice(chosenCards.indexOf(card2), 1);
    chosenCards.splice(chosenCards.indexOf(card3), 1);
}