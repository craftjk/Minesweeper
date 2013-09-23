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

  def display
    if @revealed
      if adjacent_bombs > 0
        return adjacent_bombs
      else
        return "_"
      end
    else
      return "*" unless @flagged
      return "F"
    end
  end
end

class Board
  def initialize(size, num_mines)
    @size = size
    @num_mines = num_mines
    @tiles = generate_board
  end

  def generate_board
    mine_array = generate_bombs
    board = []
    size[0].times do |row|
      row = []
      size[1].times do |col|
        row << Tile.new([row, col], mine_array.pop)
      end
      board << row
    end
    board
  end


  def generate_bombs
    #  one dimensional array
    #  eg 64 long false false flase
    #  randomly change 10 to true
    mine_array = Array.new(@size[0] * @size[1]) { false }
    @num_mines.times do
      index = rand(0...mine_array.length)
      while mine_array[index] == true
        index = rand(0...mine_array.length)
      end
      mine_array[index] = true
    end
    mine_array
  end

  def run
    #  setup board
    #    generate board
    #    generate bombs
    #  until won? || lost?
    #    prompt
    #    (flag)
    #    reveal_tile
    #      explore if empty
    #      lose if bomb
    #    display_board
    #  end
    #
  end

  def display_board
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