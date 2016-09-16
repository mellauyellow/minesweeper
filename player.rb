class Player
  def initialize
  end

  def get_position
    puts "Please enter a position separated by a comma:"
    gets.chomp.split(",").map(&:to_i)
  end

  def get_command
    puts "Reveal or Flag? (R/F)"
    gets.chomp
  end
end
