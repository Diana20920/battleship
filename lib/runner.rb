# require 'minitest/autorun'
# require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

comp_board = Board.new
player_board = Board.new
comp_cruiser = Ship.new("Cruiser", 3)
comp_sub = Ship.new("Submarine", 2)
player_cruiser = Ship.new("Cruiser", 3)
player_sub = Ship.new("Submarine", 2)
game = Game.new(comp_board, player_board)

# game.menu_prompt
# game.play
# game.display_boards
game.player_place_cruiser
# game.player_add_submarine
