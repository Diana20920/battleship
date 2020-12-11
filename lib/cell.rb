class Cell
  attr_reader :coordinate, :ship, :was_fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @was_fired_upon = false
  end

  def place_ship(ship_to_be_placed)
    @ship = ship_to_be_placed
  end

  def empty?
    return true if @ship == nil
  #   if @ship == nil
  #     return true
  #   else
  #     return false
  #   end
  end

  def fire_upon
    @was_fired_upon = true
    ship.hit if @ship != nil
  end

  def render(value = false)
    if value == false
      if @was_fired_upon == false
        "."
      elsif @was_fired_upon == true && @ship == nil
        "M"
      elsif @was_fired_upon == true && @ship.sunk? == true
        "X"
      elsif @was_fired_upon == true && @ship != nil
        "H"
      end
    else value == true
      if @was_fired_upon == false && @ship != nil
        "S"
      elsif @was_fired_upon == false
          "."
      elsif @was_fired_upon == true && @ship == nil
          "M"
      elsif @was_fired_upon == true && @ship.sunk? == true
          "X"
      elsif @was_fired_upon == true && @ship != nil
          "H"
      end
    end
  end
end
