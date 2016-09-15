class Tile
  attr_reader :value, :flagged, :revealed

  def self.bomb
    Tile.new("b")
  end

  def initialize(value)
    @value = value
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def to_s
    return @value.to_s if @revealed
    return "F" if @flagged
    "*"
  end

  def is_blank?
    @value == 0
  end

  def bomb?
    @value == "b"
  end
end
