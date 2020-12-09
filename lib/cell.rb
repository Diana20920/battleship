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
    if @ship == nil
      true
    else
      false
    end
  end

  def fire_upon
    @was_fired_upon = true
    if @ship != nil
      ship.hit
    end
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
    else
      if @was_fired_upon == false && @ship != nil
        "S"
      end
    end
  end
end
