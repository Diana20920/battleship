require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)

    assert_instance_of Ship, cruiser
  end

  def test_it_has_readable_attributes
    cruiser = Ship.new("Cruiser", 3)

    assert "Cruiser", cruiser.name
    assert 3, cruiser.length
    assert 3, cruiser.health
  end

  def test_ship_was_hit
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit

    assert_equal 2, cruiser.health
  end

  def test_ship_is_afloat
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit

    assert_equal false, cruiser.sunk?
  end
end
