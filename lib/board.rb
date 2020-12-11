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
    if valid_placement?(ship, coordinate_array) == true
      coordinate_array.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    # else
    #   return "Invalid placement"
    end
  end

  def split_return_letter_ordinal_value(ship, coordinate_array)
    @letter_ordinal_value_array = []
    coordinate_array.each do |coordinate|
      @letter_ordinal_value_array << coordinate[0].ord
    end
    @letter_ordinal_value_array
  end

  def split_return_number(ship, coordinate_array)
    @number_array =[]
    coordinate_array.each do |coordinate|
      @number_array << coordinate[1].to_i
    end
    @number_array
  end

  def coordinates_same_row?(ship, coordinate_array)
    split_return_letter_ordinal_value(ship, coordinate_array)
      if @letter_ordinal_value_array.all?(@letter_ordinal_value_array[0])
        true
      else
        false
      end
  end

  def coordinates_same_column?(ship, coordinate_array)
    split_return_number(ship, coordinate_array)
      if @number_array.all?(@number_array[0])
        true
      else
        false
      end
  end

  # def coordinates_diagonal?(ship, coordinate_array)
  #   if (coordinates_same_row?(ship, coordinate_array) == false && coordinates_same_column?(ship, coordinate_array) == false) || (coordinates_same_row?(ship, coordinate_array) == true && coordinates_same_column?(ship, coordinate_array) == true)
  #     true
  #   else
  #     false
  #   end
  # end

  def increments_by?(step, array)
    sorted_array = array.sort
    latest_number = sorted_array[0]
    sorted_array[1, (sorted_array.count - 1)].each do |number|
      if latest_number + step != number
        return false
      end
      latest_number = number
    end
    return true
  end

  def coordinates_consecutive_horizontal?(ship, coordinate_array)
    split_return_number(ship, coordinate_array)
    if coordinates_same_row?(ship, coordinate_array) == true && increments_by?(1, @number_array) == true
      true
    else
      false
    end
  end

  def coordinates_consecutive_vertical?(ship, coordinate_array)
    split_return_letter_ordinal_value(ship, coordinate_array)
    if coordinates_same_column?(ship, coordinate_array) == true && increments_by?(1, @letter_ordinal_value_array) == true
      true
    else
      false
    end
  end

  def coordinates_overall_consecutive?(ship, coordinate_array)
    if coordinates_consecutive_horizontal?(ship, coordinate_array) == true || coordinates_consecutive_vertical?(ship, coordinate_array) == true
      true
    else
      false
    end
  end

  def correct_length?(ship, coordinate_array)
    if ship.length != coordinate_array.count
      false
    else
      true
    end
  end

  def ship_overlap?(ship, coordinate_array)
    coordinate_array.each do |coordinate|
      if @cells[coordinate].empty? == true
        return false
      else
        return true
      end
    end
  end

  def valid_placement?(ship, coordinate_array)
    if ship_overlap?(ship, coordinate_array) == false && correct_length?(ship, coordinate_array) == true && coordinates_overall_consecutive?(ship, coordinate_array) == true
      return true
    else
      return false
    end
  end

  # def render(value = false)
  #   if value == false
  #     "  1 2 3 4 \n" +
  #     "A . . . . \n" +
  #     "B . . . . \n" +
  #     "C . . . . \n" +
  #     "D . . . . \n"
  #   else
  #     "  1 2 3 4 \n" +
  #     "A S S S . \n" +
  #     "B . . . . \n" +
  #     "C . . . . \n" +
  #     "D . . . . \n"
  #   end
  # end

  def render(value = false)
    if value == false
      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render(value = false)} #{@cells["A2"].render(value = false)} #{@cells["A3"].render(value = false)} #{@cells["A4"].render(value = false)} \n" +
      "B #{@cells["B1"].render(value = false)} #{@cells["B2"].render(value = false)} #{@cells["B3"].render(value = false)} #{@cells["B4"].render(value = false)} \n" +
      "C #{@cells["C1"].render(value = false)} #{@cells["C2"].render(value = false)} #{@cells["C3"].render(value = false)} #{@cells["C4"].render(value = false)} \n" +
      "D #{@cells["D1"].render(value = false)} #{@cells["D2"].render(value = false)} #{@cells["D3"].render(value = false)} #{@cells["D4"].render(value = false)} \n"
    else value == true
      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n" +
      "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n" +
      "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n" +
      "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n"
    end
  end
end
