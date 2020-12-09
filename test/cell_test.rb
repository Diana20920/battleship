require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_readable_attributes
    cell = Cell.new("B4")
  
    assert_equal "B4", cell.coordinate
    assert_nil cell.ship
    assert_equal false, cell.was_fired_upon
  end

  def test_place_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end

  def test_cell_is_empty
    cell = Cell.new("B4")

    assert cell.empty?
  end

  def test_cell_is_not_empty
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    refute cell.empty?
  end

  def test_fire_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal 2, cruiser.health
    assert cell.was_fired_upon
  end

  def test_render_no_fire
    cell = Cell.new("B4")

    assert_equal ".", cell.render
  end

  def test_render_fire_no_ship
    cell = Cell.new("B4")
    cell.fire_upon

    assert_equal "M", cell.render
  end

  def test_render_fire_ship_hit
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal "H", cell.render
  end

  def test_render_fire_ship_sunk
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    cell.ship.hit
    cell.ship.hit
    cell.ship.sunk?

    assert_equal "X", cell.render
  end

  def test_render_ship_location
    cell = Cell.new("A1")
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal "S", cell.render(true)
  end

end
