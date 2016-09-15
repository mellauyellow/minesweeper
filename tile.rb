class Tile
  attr_reader :value, :flagged, :revealed

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
end
