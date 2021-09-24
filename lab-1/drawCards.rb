require 'gosu'

# Drawing constants
ROW_WIDTH = 9
MARGIN = 25
WHITE = Gosu::Color.new(0xFF, 0xFF, 0xFF, 0xFF)
# Like dealCards, but for drawing cards on the screen
def drawCards(chosenCards, startY, screenWidth, screenHeight)
    # Set row and column position for the card
    row = 0
    column = 0
    cardIndex = 0
    cellWidth = (screenWidth-MARGIN) / ROW_WIDTH
    cellHeight = (cellWidth * (3.5/2.5)) # Card dimensions are 3.5/2.5
    while chosenCards[cardIndex] != nil && cardIndex < 21
        # Get the card
        card = chosenCards[cardIndex]
        cardX1 = MARGIN + (column * cellWidth)
        cardX2 = ((column+1) * cellWidth)
        cardY1 = startY + (row * cellHeight)
        cardY2 = startY + ((row + 1) * cellHeight) - MARGIN
        card.image.draw_as_quad(cardX1, cardY1, WHITE, cardX2, cardY1, WHITE, cardX1, cardY2, WHITE, cardX2, cardY2, WHITE, 1)

        cardIndex += 1
        column += 1
        if column == ROW_WIDTH
            row += 1
            column = 0
        end
    end
end

def getClickedCard(chosenCards, startY, screenWidth, screenHeight, mouseX, mouseY)
    # Get mouse positions adjusted for left and top margins
    adjustedX = mouseX
    adjustedY = mouseY - startY
    # Get cell dimensions
    cellWidth = (screenWidth-MARGIN) / ROW_WIDTH
    cellHeight = (cellWidth * (3.5/2.5)) # Card dimensions are 3.5/2.5
    
    # Calculate row/column clicked
    column = (adjustedX / cellWidth).floor
    row = (adjustedY / cellHeight).floor
    # Calculate the top left and bottom right of cards, to make sure click is within bounds
    columnMinX = (column * cellWidth) + MARGIN
    columnMaxX = ((column + 1) * cellWidth)
    rowMinY = (row * cellHeight)
    rowMaxY = (((row + 1) * cellHeight) - MARGIN)
    
    if adjustedX < 0 || adjustedY < 0 || adjustedX < columnMinX || adjustedX > columnMaxX || adjustedY < rowMinY || adjustedY > rowMaxY
        # Clicked in the margin, no card clicked
        return nil
    end

    # Get the card clicked
    cardIndex = (row * ROW_WIDTH) + column
    chosenCards[cardIndex]
end