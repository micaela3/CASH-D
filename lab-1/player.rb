# Player Class
class Player
  #Initialize function to set the name, id, and score of the player
  def initialize(name, id, score)
    @name = name
    @id = id
    @score = score
  end

  # Return the player name
  def name
    return @name
  end

  # Return the player id
  def id
    return @id
  end

  # Return the player score
  def score
    return @score
  end
end

