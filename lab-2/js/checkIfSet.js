// Method that checks if 3 selected cards are a set or not.
function checkIfSet(c1,c2,c3) {

    // the numbers must all be the same or all different
    var countAllSame = (c1.countString == c2.countString) && (c2.countString == c3.countString);
    var countAllDiff = (c1.countString != c2.countString) && (c2.countString != c3.countString) && (c1.countString!= c3.countString);

    // the shapes must all be the same or all different
    var shapeAllSame = (c1.shapeString == c2.shapeString) && (c2.shapeString == c3.shapeString);
    var shapeAllDiff = (c1.shapeString != c2.shapeString) && (c2.shapeString != c3.shapeString) && (c1.shapeString != c3.shapeString);

    // the shadings must be the same or all different
    var shadingAllSame = (c1.shadingString == c2.shadingString) && (c2.shadingString == c3.shadingString);
    var shadingAllDiff = (c1.shadingString != c2.shadingString) && (c2.shadingString != c3.shadingString) && (c1.shadingString != c3.shadingString);

    // the colors must be the same or all different
    var colorAllSame = (c1.colorString == c2.colorString) && (c2.colorString == c3.colorString);
    var colorAllDif = (c1.colorString != c2.colorString) && (c2.colorString != c3.colorString) && (c1.colorString != c3.colorString);

    return (countAllSame || countAllDiff) && (shapeAllSame || shapeAllDiff) && (shadingAllSame || shadingAllDiff) && (colorAllSame || colorAllDif);
}
