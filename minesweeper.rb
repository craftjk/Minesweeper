class Tile
  def initialize(position, bomb)
    @position = position
    @bomb = bomb
    @flagged = false
    @revealed = false
  end

  def explore
    #recursively explore neighbor tiles
  end

  def neighbors
    #return list of neighbors
  end

  def adjacent_bombs
  end
end

class Board
  def initialize(size, num_mines)
    @size = size
    @num_mines = num_mines
    @tiles = generate_board
  end

  def generate_board
  end

  def run
  end

  def won?
  end

  def lost?
  end

  def save
  end

  def self.load
  end

  def prompt
  end
end

class Player
  def initialize
  end

  def reveal_tile(position)
  end

  def flag_tile(position)
  end
end