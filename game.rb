require_relative 'board'
require_relative 'tile'

class Game
  def initialize(board)
    @board = board
  end

  def run
    @board.render

    until over?
      take_turn
      @board.render
    end
  end

  def take_turn
    pos = get_position
    until @board.valid_pos?(pos)
      puts "Invalid position! Try again"
      pos = get_position
    end

    command = get_command
    until valid_command?(command)
      puts "Invalid command! Try again"
      command = get_command
    end

    if command == "R"
      @board.reveal(pos)
    else
      @board.flag(pos)
    end
  end

  def over?
    if @board.won?
      puts "Congratulations, you won!"
      true
    elsif @board.lost?
      puts "You need your wisdom shoes mate!"
      true
    else
      false
    end
  end

  def get_position
    puts "Please enter a position separated by a comma:"
    gets.chomp.split(",").map(&:to_i)
  end

  def get_command
    puts "Reveal or Flag? (R/F)"
    gets.chomp.upcase
  end

  def valid_command?(command)
    ["R", "F"].include?(command)
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.from_random(5, 6, 4)
  game = Game.new(board)
  game.run
end
