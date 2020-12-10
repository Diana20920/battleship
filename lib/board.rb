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

  def are_whole_coordinates_consecutive?(ship, coordinate_array)

  end



  # def valid_placement?(ship, coordinate_array)
    # if ship.length != array.count
    #   false
    # else
    #   true
    # end
    # coordinate_array.each do |coordinate|
    #   if @cells[coordinate].ship != nil
    #     false
    #     break
    #   end
    # end
  # end

end
