// Constant object for count values, similar to an enum
const COUNT = {
    ONE: 1,
    TWO: 2,
    THREE: 3
};

// Constant object for shape values, similar to an enum
const SHAPE = {
    DIAMOND: 1,
    SQUIGGLE: 2,
    OVAL: 3
};

// Constant object for shading values, similar to an enum
const SHADING = {
    SOLID: 1,
    STRIPED: 2,
    OPEN: 3
}

// Constant object for color values, similar to an enum
const COLOR = {
    RED: 1,
    GREEN: 2,
    PURPLE: 3
}

// Card class to keep track of card characteristics
class Card {
    // Create the card object
	constructor(count, shape, shading, color) {
        this.count = count;
        this.shape = shape;
        this.shading = shading;
        this.color = color;
	}

    // Get count as a string (retrieved with card.countString)
    get countString() {
        switch (this.count) {
            case COUNT.ONE:
                return "One";
            case COUNT.TWO:
                return "Two";
            case COUNT.THREE:
                return "Three";
        }
    }

    // Get shape as a string (retrieved with card.shapeString)
    get shapeString() {
        switch (this.shape) {
            case SHAPE.DIAMOND:
                return "Diamond";
            case SHAPE.SQUIGGLE:
                return "Squiggle";
            case SHAPE.OVAL:
                return "Oval";
        }
    }

    // Get shading as a string (retrieved with card.shadingString)
    get shadingString() {
        switch (this.shading) {
            case SHADING.SOLID:
                return "Solid";
            case SHADING.STRIPED:
                return "Striped";
            case SHADING.OPEN:
                return "Open";
        }
    }

    // Get color as a string (retrieved with card.colorString)
    get colorString() {
        switch (this.color) {
            case COLOR.RED:
                return "Red";
            case COLOR.GREEN:
                return "Green";
            case COLOR.PURPLE:
                return "Purple";
        }
    }

    // Return the card object as a string
    toString() {
        return this.countString + ' ' + this.colorString + ' ' + this.shadingString + ' ' + this.shapeString;
    }
};
