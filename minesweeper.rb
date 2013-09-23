class Tile
  attr_reader :bomb, explored:, flagged:
  def initialize(position, bomb, tiles)
    @position = position
    @bomb = bomb
    @flagged = false
    @revealed = false
    @tiles = tiles
    @explored = false
  end


  def explore
    #recursively explore neighbor tiles
    if @flagged
      puts "You can't reveal a flagged tile."
      return
    end
    @revealed = true
    @explored = true

    if @bomb
      return false
    end

    if adjacent_bombs == 0
      neighbors.each do |adj_tile|
        tile = @tiles[adj_tile[0]][adj_tile[1]]
        tile.explore unless (tile.explored || tile.flagged)
      end
    end
    true
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

  private

  def neighbors
    #return list of neighbors
    neighbors = []
    [-1, 0, 1].each do |x|
      [-1, 0, 1].each do |y|
        next if x == 0 && y == 0
        neighbors << [@position[0] + x, @position[1] + y]
      end
    end
    neighbors.delete_if do |neighbor|
      neighbor[0] > @tiles.length || neighbor[0] < 0 || neighbor[1] > @tiles.first.length || neighbor[1] < 0
    end
    neighbors
  end

  def adjacent_bombs
    bomb_count = 0
    neighbors.each do |neighbor|
      bomb_count += 1 if @tiles[neighbor[0]][neighbor[1]].bomb
    end
    bomb_count
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
        row << Tile.new([row, col], mine_array.pop, @size)
      end
      board << row
    end
    board
  end


  def generate_bombs
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
    @tiles.each do |row|
      row.each do |tile|
        print tile.display
      end
      puts
    end
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