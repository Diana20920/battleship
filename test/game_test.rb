require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new
    assert_instance_of Game, game
  end

  def test_final_game
    game = Game.new
    game.expects(:main_menu)
    game.expects(:setup)
    game.final_game
  end

  def test_turn
    game = Game.new
    game.expects(:display_boards)
    game.expects(:ok_to_fire_at_comp)
    game.expects(:player_shot_feedback)
    game.expects(:game_over_player?)
    game.turn
  end

  def test_computer_shot_sequence
    game = Game.new
    game.expects(:computer_shot)
    game.expects(:computer_shot_feedback)
    game.expects(:game_over_computer?)
    game.computer_shot_sequence
  end

  def test_end_game
    game = Game.new
    game.expects(:reset)
    game.expects(:final_game)
    game.end_game
  end

  def test_create_ships
    game = Game.new
    assert_instance_of Ship, game.create_ships
  end

end
