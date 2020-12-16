class Game

  def initialize(comp_board, player_board)
    @comp_board = comp_board
    @player_board = player_board
    @valid_targets = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @player_shot = nil
    @comp_shot = nil
  end

  def final_game
    main_menu
    setup
    # turn
    # game_over?
    # end_game
  end
##MAIN MENU
  def main_menu
    puts "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit."
    @menu_selection = gets.chomp
    sleep(1)
  end

  def re_main_menu
    puts "You entered an invalid input. Please enter p to play or enter q to quit."
    @menu_selection = gets.chomp
    setup
    sleep(1)
  end

  def reset
    @comp_board = Board.new
    @player_board = Board.new
    @valid_targets = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @player_shot = nil
    @comp_shot = nil
  end


## SETUP
  def setup
    if @menu_selection == "p"
      instructions
      sleep(5)
      create_ships
      comp_ok_to_place_submarine
      display_comp_board
      sleep(1)
      player_ok_to_place_cruiser
      sleep(1)
      display_player_board
      player_ok_to_place_submarine
      sleep(1)
      turn
      game_over?
      end_game
    elsif @menu_selection == "q"
      puts "Thanks for stopping by - have a nice day!"
    else
      re_main_menu
    end
  end

  ##TURN
  def turn
    display_boards
    ok_to_fire_at_comp
    computer_shot
    player_shot_feedback
    computer_shot_feedback
    sleep(2)
    game_over?
  end

#### GAME OVER
  def game_over?
    if (comp_alive && player_alive) == true
      turn
    end
  end

  def comp_alive
    if (@comp_cruiser.sunk? == false || @comp_submarine.sunk? == false) == true
      true
    else
      false
    end
  end

  def player_alive
    if (@player_cruiser.sunk? == false || @player_submarine.sunk? == false) == true
      true
    else
      false
    end
  end

#### END GAME

  def end_game
    player_won
    comp_won
    sleep(2)
    reset
    final_game
  end

  def player_won
    if player_alive == true
      puts "You won!"
    end
  end

  def comp_won
    if comp_alive == true
      puts "I won!"
    end
  end


  # def play
  #   if @menu_selection == "p"
  #     instructions
  #     comp_ok_to_place_submarine
  #     display_comp_board
  #     player_ok_to_place_cruiser
  #     display_player_board
  #     player_ok_to_place_submarine
  #     display_boards
  #     shot_feedback

  #   elsif @menu_selection == "q"
  #     puts "Have a nice day!"
  #   else
  #     re_main_menu
  #   end
  # end

  # def shot_feedback
  #   computer_shot
  #   ok_to_fire_at_comp
  #   player_shot_feedback
  #   computer_shot_feedback
  # end

  def re_main_menu
    puts "You entered an invalid input. Please enter p to play or enter q to quit."
    @menu_selection = gets.chomp
    setup
  end

#####################
  def create_ships
    @player_cruiser = Ship.new("Cruiser", 3)
    @comp_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @comp_submarine = Ship.new("Submarine", 2)
  end

  def instructions
    puts "I have laid out my ships on the grid. \nYou now need to lay out your two ships. \nThe Cruiser is three units long and the Submarine is two units long."
  end

  def display_comp_board
    puts @comp_board.render
  end

  def display_player_board
    puts @player_board.render(true)
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    display_comp_board
    puts "==============PLAYER BOARD=============="
    display_player_board
  end


  #####COMPUTER SHIP PLACEMENT

  def comp_cruiser_placement
    # create_ships
    @valid_cruiser_placements = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["B1", "C1", "D1"], ["A2", "B2", "C2"], ["B2", "C2", "D2"], ["A3", "B3", "C3"], ["B3", "C3", "D3"], ["A4", "B4", "C4"], ["B4", "C4", "D4"]]
    @comp_cruiser_coords = @valid_cruiser_placements.sample
    @comp_board.place(@comp_cruiser, @comp_cruiser_coords)
  end

  def refine_valid_submarine_placements
    comp_cruiser_placement
    @valid_submarine_placements = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["B1", "C1"], ["C1", "D1"], ["A2", "B2"], ["B2", "C2"], ["C2", "D2"], ["A3", "B3"], ["B3", "C3"], ["C3", "D3"], ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
    @valid_submarine_placements.delete_if do |placement|
      placement.include?(@comp_cruiser_coords[0]) || placement.include?(@comp_cruiser_coords[1]) || placement.include?(@comp_cruiser_coords[2])
    end
    @comp_submarine_coords = @valid_submarine_placements.sample
  end

  # def comp_submarine_placement_valid
  #   comp_cruiser_placement
  #   @valid_submarine_placements = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["B1", "C1"], ["C1", "D1"], ["A2", "B2"], ["B2", "C2"], ["C2", "D2"], ["A3", "B3"], ["B3", "C3"], ["C3", "D3"], ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
  #   @comp_submarine_coords = @valid_submarine_placements.sample
  # end

  def comp_ok_to_place_submarine ####CEO METHOD
    refine_valid_submarine_placements
    if @comp_board.valid_placement?(@comp_submarine, @comp_submarine_coords) == true
      comp_place_submarine
    else
      comp_reselect_submarine_cords
    end
  end

  def comp_place_submarine
    @comp_board.place(@comp_submarine, @comp_submarine_coords)
  end

  def comp_reselect_submarine_cords
    @comp_submarine_coords = @valid_submarine_placements.sample
    comp_ok_to_place_submarine_redo
  end

  def comp_ok_to_place_submarine_redo
    if @comp_board.valid_placement?(@comp_submarine, @comp_submarine_coords) == true
      comp_place_submarine
    else
      comp_reselect_submarine_cords
    end
  end

  ### COMPUTER SHOT

  def computer_shot
    @comp_shot = @valid_targets.sample
    @player_board.cells[@comp_shot].fire_upon
    # @valid_targets.delete(@comp_shot)
    @valid_targets.delete_if do |target|
      target == @comp_shot
    end
  end

  def computer_shot_feedback
    # computer_shot
    # if @player_board.cells[@comp_shot].empty? == false && @player_board.cells[@comp_shot].ship.sunk? == true
    #   puts "My shot on #{@comp_shot} was a hit and sunk a ship."
    # elsif @player_board.cells[@comp_shot].empty? == false && @player_board.cells[@comp_shot].ship.sunk? == false
    #   puts "My shot on #{@comp_shot} was a hit."
    if @player_board.cells[@comp_shot].empty? == true
      puts "My shot on #{@comp_shot} was a miss. \n"
    elsif @player_board.cells[@comp_shot].ship.sunk? == false
      puts "My shot on #{@comp_shot} was a hit. \n"
    else
      puts "My shot on #{@comp_shot} was a hit and it sunk a ship. \n"
    end
  end

  ####PLAYER CRUISER PLACEMENT

  def player_ok_to_place_cruiser ####CEO METHOD
    player_cruiser_coords
    if @player_board.valid_placement?(@player_cruiser, @p_cruiser_coords.split(" ").to_a) == true
      player_place_cruiser
    else
      player_cruiser_invalid_coords
    end
  end

  def player_cruiser_coords
    # create_ships
    puts "Enter the squares for the Cruiser (3 spaces):"
    @p_cruiser_coords = gets.chomp
    @p_cruiser_coords.split(" ").to_a
  end

  def player_cruiser_invalid_coords
    puts "Those are invalid coordinates. Please try again:"
    @p_cruiser_coords = gets.chomp
    @p_cruiser_coords.split(" ").to_a
    player_ok_to_place_cruiser_redo
  end

  def player_ok_to_place_cruiser_redo
    if @player_board.valid_placement?(@player_cruiser, @p_cruiser_coords.split(" ").to_a) == true
      player_place_cruiser
    else
      player_cruiser_invalid_coords
    end
  end

  def player_place_cruiser
    @player_board.place(@player_cruiser, @p_cruiser_coords.split(" ").to_a)
  end

  ####### PLAYER SUBMARINE PLACEMENT#####

  def player_ok_to_place_submarine ###CEO METHOD
    player_submarine_coords
    if @player_board.valid_placement?(@player_submarine, @p_submarine_coords.split(" ").to_a) == true
      player_place_submarine
    else
      player_submarine_invalid_coords
    end
  end

  def player_submarine_coords
    # create_ships
    puts "Enter the squares for the Submarine (2 spaces):"
    @p_submarine_coords = gets.chomp
    @p_submarine_coords.split(" ").to_a
  end

  def player_submarine_invalid_coords
    puts "Those are invalid coordinates. Please try again:"
    @p_submarine_coords = gets.chomp
    @p_submarine_coords.split(" ").to_a
    player_ok_to_place_submarine_redo
  end

  def player_ok_to_place_submarine_redo
    if @player_board.valid_placement?(@player_submarine, @p_submarine_coords.split(" ").to_a) == true
      player_place_submarine
    else
      player_submarine_invalid_coords
    end
  end

  def player_place_submarine
    @player_board.place(@player_submarine, @p_submarine_coords.split(" ").to_a)
  end

  ######Turn

  #Player Shot

  # def ok_to_fire_at_comp ###CEO METHOD
  #   player_shot
  #   player_already_fired_on_cell
  #   if @comp_board.valid_coordinate?(@player_shot) == true
  #     player_fire_on_comp
  #   else
  #     player_invalid_shot
  #   end
  # end

  def ok_to_fire_at_comp ###CEO METHOD
    player_shot
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_already_fired_on_cell
    else
      player_invalid_shot
    end
  end

  def player_shot
    puts "Enter the coordinate for your shot:"
    @player_shot = gets.chomp
  end

  def player_invalid_shot
    puts "Please enter a valid coordinate:"
    @player_shot = gets.chomp
    player_ok_to_fire_at_comp_redo
  end

  def player_fire_on_comp
    @comp_board.cells[@player_shot].fire_upon
  end

  def player_ok_to_fire_at_comp_redo
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_already_fired_on_cell
    else
      player_invalid_shot
    end
  end

  def ok_to_fire_at_comp_same_cell
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_fire_on_comp
    else
      player_invalid_shot
    end
  end

  def player_already_fired_on_cell
    if @comp_board.cells[@player_shot].was_fired_upon == true
      puts "You have already fired upon that cell. Please enter a different cell to fire upon:"
      @player_shot = gets.chomp
      ok_to_fire_at_comp_after_same_shot_prompt
    else
      ok_to_fire_at_comp_same_cell
    end
  end

  def ok_to_fire_at_comp_after_same_shot_prompt
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_already_fired_on_cell
    else
      player_invalid_shot
    end
  end

  def player_shot_feedback
    # ok_to_fire_at_comp
    # if @comp_board.cells[@player_shot].empty? == false && @comp_board.cells[@player_shot].ship.sunk? == true
    #   puts "Your shot on #{@player_shot} was a hit and sunk a ship."
    # elsif @comp_board.cells[@player_shot].empty? == false && @comp_board.cells[@player_shot].ship.sunk? == false
    #   puts "Your shot on #{@player_shot} was a hit."
    if @comp_board.cells[@player_shot].empty? == true
      puts "Your shot on #{@player_shot} was a miss."
    elsif @comp_board.cells[@player_shot].ship.sunk? == false
      puts "Your shot on #{@player_shot} was a hit."
    else
      puts "Your shot on #{@player_shot} was a hit and it sunk a ship."
    end
  end

end
