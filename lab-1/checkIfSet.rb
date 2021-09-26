# Method that checks if 3 selected cards are a set or not.
def checkIfSet(c1,c2,c3)

    # the numbers must all be the same or all different
    countAllSame = (c1.count == c2.count) && (c2.count == c3.count)
    countAllDiff = (c1.count != c2.count) && (c2.count != c3.count) && (c1.count != c3.count)

    # the shapes must all be the same or all different
    shapeAllSame = (c1.shape == c2.shape) && (c2.shape == c3.shape)
    shapeAllDiff = (c1.shape != c2.shape) && (c2.shape != c3.shape) && (c1.shape != c3.shape)

    # the shadings must be the same or all different
    shadingAllSame = (c1.shading == c2.shading) && (c2.shading == c3.shading)
    shadingAllDiff = (c1.shading != c2.shading) && (c2.shading != c3.shading) && (c1.shading != c3.shading)

    # the colors must be the same or all different
    colorAllSame = (c1.color == c2.color) && (c2.color == c3.color)
    colorAllDif = (c1.color != c2.color) && (c2.color != c3.color) && (c1.color != c3.color)

    isSet = (countAllSame || countAllDiff) && (shapeAllSame || shapeAllDiff) && (shadingAllSame || shadingAllDiff) && (colorAllSame || colorAllDif)
end
