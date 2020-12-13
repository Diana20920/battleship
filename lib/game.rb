class Game

  def initialize(comp_board, player_board)
    @comp_board = comp_board
    @player_board = player_board
  end

  def final_game
    menu_prompt
    play
  end

  def menu_prompt
    puts "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit."
    @menu_selection = gets.chomp
  end

  def create_ships
    @player_cruiser = Ship.new("Cruiser", 3)
    @comp_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @comp_submarine = Ship.new("Submarine", 2)
  end


  def play
    if @menu_selection == "p"
      comp_ok_to_place_submarine
      instructions
      display_comp_board
      player_ok_to_place_cruiser
      player_ok_to_place_submarine
      display_boards
      player_shot_feedback
      # computer_shot_feedback
      display_boards

    elsif @menu_selection == "q"
      puts "Quitter"
    end
  end

  def instructions
    puts "I have laid out my ships on the grid. \nYou now need to lay out your two ships. \nThe Cruiser is three units long and the Submarine is two units long."
  end

  def display_comp_board
    puts @comp_board.render(true)
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
    create_ships
    @valid_cruiser_placements = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["B1", "C1", "D1"], ["A2", "B2", "C2"], ["B2", "C2", "D2"], ["A3", "B3", "C3"], ["B3", "C3", "D3"], ["A4", "B4", "C4"], ["B4", "C4", "D4"]]
    @comp_cruiser_coords = @valid_cruiser_placements.sample
    @comp_board.place(@comp_cruiser, @comp_cruiser_coords)
  end

  def comp_submarine_placement_valid
    comp_cruiser_placement
    @valid_submarine_placements = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["B1", "C1"], ["C1", "D1"], ["A2", "B2"], ["B2", "C2"], ["C2", "D2"], ["A3", "B3"], ["B3", "C3"], ["C3", "D3"], ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
    @comp_submarine_coords = @valid_submarine_placements.sample
  end

  def comp_ok_to_place_submarine ####CEO METHOD
    comp_submarine_placement_valid
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
    @valid_targets = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @computer_shot = @valid_targets.sample
    @player_board.cells[@computer_shot].fire_upon
    @valid_targets.delete(@computer_shot)
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
    create_ships
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
    create_ships
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

  def ok_to_fire_at_comp ###CEO METHOD
    player_shot
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_fire_on_comp
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
      player_fire_on_comp
    else
      player_invalid_shot
    end
  end

  def player_shot_feedback
    ok_to_fire_at_comp
    if @comp_board.cells[@player_shot].empty? == true
      "Your shot on #{@player_shot} was a miss."
    elsif @comp_board.cells[@player_shot].empty? == false && @comp_board.cells[@player_shot].ship.sunk? == false
      "Your shot on #{@player_shot} was a hit."
    elsif @comp_board.cells[@player_shot].empty? == false && @comp_board.cells[@player_shot].ship.sunk? == true
      "Your shot on #{@player_shot} was a hit and sunk a ship."
    end
  end

  def computer_shot_feedback
    computer_shot
    if @player_board.cells[@comp_shot].empty? == true
      "My shot on #{@comp_shot} was a miss."
    elsif @player_board.cells[@comp_shot].empty? == false && @player_board.cells[@comp_shot].ship.sunk? == false
      "My shot on #{@comp_shot} was a hit."
    elsif @player_board.cells[@comp_shot].empty? == false && @player_board.cells[@comp_shot].ship.sunk? == true
      "My shot on #{@player_shot} was a hit and sunk a ship."
    end
  end


end
