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

end
