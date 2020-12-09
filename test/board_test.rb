require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_board_has_sixteen_cells
    board = Board.new

    assert_equal 16, board.cells.count
  end

  def test_valid_coordinate
    board = Board.new

    assert board.valid_coordinate?("B4")
  end

  def test_invalid_coorindate
    board = Board.new

    refute board.valid_coordinate?("E7")
  end

  def test_valid_placement_ship_length_not_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2"])
  end

  def test_valid_placement_ship_length_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert board.valid_placement?(submarine, ["A1", "A2"])
  end

  def test_valid_placement_not_in_line
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2"])
  end

  # def test_valid_placement_no_overlap
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #
  #   assert_equal true, board.valid_placement?(cruiser, ["A1", "A2"])
  # end
end
