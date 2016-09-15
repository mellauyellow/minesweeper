require_relative "tile"

class Board
  attr_reader :grid

  def self.from_random(rows, columns, bombs)
    size = rows * columns
    bombs_arr = self.randomize_bombs(size, bombs)

    grid_skeleton = self.transform_2d(bombs_arr, rows, columns)

    Board.new(grid_skeleton)
  end

  def initialize(grid_skeleton)
    @grid = Array.new(grid_skeleton.length) { Array.new(grid_skeleton[0].length) }
    populate_grid(grid_skeleton)
  end

  def num_rows
    @grid.length
  end

  def num_cols
    @grid[0].length
  end

  def neighbors(pos)
    neighbor_arr = []

    (-1..1).to_a.each do |row|
      (-1..1).to_a.each do |col|
         new_pos = [row + pos[0], col + pos[1]]
         neighbor_arr << new_pos unless new_pos == pos || !valid_pos?(new_pos)
       end
    end

    neighbor_arr
  end

  def valid_pos?(pos)
    row, col = *pos
    return false unless (0...num_rows).include?(row)
    return false unless (0...num_cols).include?(col)
    true
  end

  def populate_grid(grid_skeleton)
    grid_skeleton.each_with_index do |line, row|
      line.each_with_index do |_, col|
        pos = [row, col]
        if grid_skeleton[row][col] == 1
          self[pos] = Tile.new("b")
        else
          neighbor_arr = neighbors(pos)
          bombs = neighbor_arr.inject(0) { |sum, el| grid_skeleton[el[0]][el[1]] + sum }

          self[pos] = Tile.new(bombs)
        end
      end
    end
  end

  def render
    puts "  #{(0...num_cols).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      puts "#{i} #{row.map(&:to_s).join(" ")}"
    end
  end

  def [](pos)
    row, col = *pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = *pos
    @grid[row][col] = mark
  end

  private

  def self.randomize_bombs(size, bombs)
    (Array.new(bombs) { 1 } + Array.new(size - bombs) { 0 }).shuffle
  end

  def self.transform_2d(array, rows, columns)
    grid = []

    until array.empty?
      grid << array.take(columns)
      array = array.drop(columns)
    end

    grid
  end
end

board = Board.from_random(3, 3, 3)
board.render
