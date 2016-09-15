class Board
  attr_reader :grid

  def self.from_random(rows, columns, bombs)
    size = rows * columns
    bombs_arr = self.randomize_bombs(size, bombs)

    grid_skeleton = self.transform_2d(bombs_arr, rows, columns)

    Board.new(grid_skeleton)
  end

  def initialize(grid)
    @grid = grid
  end

  def neighbors(pos)
    neighbor_arr = []

    (-1..1).to_a.each do |row|
      (-1..1).to_a.each do |col|
         new_pos = [row + pos[0], col + pos[1]]
         neighbor_arr << new_pos unless new_pos == pos
       end
    end

    neighbor_arr
  end

  def populate_grid
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
