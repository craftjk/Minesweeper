# require 'debugger'
require 'yaml'

class Tile
  attr_accessor :flagged
  attr_reader :bomb, :explored, :revealed, :position
  def initialize(position, bomb, board)
    @position = position
    @bomb = bomb
    @flagged = false
    @revealed = false
    @board = board
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
        tile = @board.tiles[adj_tile[0]][adj_tile[1]]
        tile.explore unless (tile.explored || tile.flagged)
      end
    end
    true
  end

  def display(game_over)
    if @revealed
      if adjacent_bombs > 0
        return " #{adjacent_bombs.to_s} "
      else
        return " _ "
      end
    else
      return " B " if @bomb && game_over
      return " * " unless @flagged
      return " F "
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
      neighbor[0] > @board.tiles.length - 1 || neighbor[0] < 0 || neighbor[1] > @board.tiles.first.length - 1 || neighbor[1] < 0
    end
    neighbors
  end

  def adjacent_bombs
    bomb_count = 0
    neighbors.each do |neighbor|
      bomb_count += 1 if @board.tiles[neighbor[0]][neighbor[1]].bomb
    end
    bomb_count
  end
end

class Board
  attr_accessor :tiles
  def initialize(size, num_mines)
    @size = size
    @num_mines = num_mines
    @tiles = generate_board
  end

  def generate_board
    mine_array = generate_bombs
    board = []
    @size[0].times do |row|
      row_arr = []
      @size[1].times do |col|
        row_arr << Tile.new([row, col], mine_array.pop, self)
      end
      board << row_arr
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
    # @board = generate_board
    revealed_bomb = false
    until won? || revealed_bomb

      display_board
      action = prompt_action
      tile_position = prompt_tile
      tile = @tiles[tile_position[0]][tile_position[1]]
      if action == "R"
        revealed_bomb = tile.bomb
        lose if revealed_bomb
        tile.explore
      elsif action == "F"
        tile.flagged = true
      elsif action == "SAVE"
        save
      else
        puts "Please input R or F for action."
        next
      end
    end
    display_board(true)
  end

  def display_board(game_over = false)
    @tiles.each do |row|
      row.each do |tile|
        print tile.display(game_over)
      end
      puts
    end
    puts
  end

  def won?
    all_revealed = true
    @tiles.each do |row|
      row.each do |tile|
        all_revealed = false if !tile.revealed && !tile.bomb
      end
    end
    puts "8)" if all_revealed
    all_revealed
  end

  def lose
    puts
    puts "You lose"
    puts "(x_x)"
    puts
  end

  def save
    board_yaml = self.to_yaml
    File.open('minesweeper_savegame', 'w') { |file| file.write(board_yaml) }
  end

  def self.load
    YAML::load(File.read('minesweeper_savegame'))
  end

  def prompt_action
    puts "[R]eveal or [F]lag?"
    gets.chomp.upcase
  end

  def prompt_tile
    puts "Which tile? (e.g. '2,3')"
    tile = gets.chomp.split(',').map(&:to_i)
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

# game = Board.new([16,16], 20)
# game.run

game = Board.load
game.run