class Board
attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A1"),
      "A3" => Cell.new("A1"),
      "A4" => Cell.new("A1"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def place(ship, coordinate_array)
    coordinate_array.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def valid_placement?(ship, array)
    if ship.length != array.count
      false
    else
      true
    end
  end

end
