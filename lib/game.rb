class Game

  def initialize
    @board = Board.new
    @players = Players.new
    play_game
  end

  def play_game
    puts "Hello, and welcome to Connect 4."
    assign_player("r")
    assign_player("y")
    player1_number = determine_player_one
    @board.show
    turns(player1_number)
    determine_winner
  end

  private
  def assign_player(token)
    puts "Player, please enter your name."
    player_name = STDIN.gets.chomp
    player_name = check_name_validity(player_name)
    @players.add_player(Player.new("#{player_name}","#{token}"))
    puts "Welcome #{player_name}, your token is #{token}"
  end

  def turns(starting_player_number)
    while !check_for_winner? && !@board.full?
      puts "#{@players.players[starting_player_number].name}, please select a column."
      column = STDIN.gets.chomp
      column_new_integer = column.to_i

      while @board.check_if_column_full?(column_new_integer)
        puts "That column is full. Pick a new one"
        column = STDIN.gets.chomp
        column_new_integer = column.to_i
      end

      @board.make_move(column.to_i, @players.players[starting_player_number].token)
      @board.show
      if starting_player_number == 0
        starting_player_number += 1
      else
        starting_player_number -= 1
      end
    end
  end

  def check_name_validity(name)
    while !@players.unique?(name)
      puts "Please enter a unique name."
      name = STDIN.gets.chomp
    end
    name
  end

  def determine_player_one
    player_number = rand(2)
    puts "#{@players.players[player_number].name}, you will go first."
    player_number
  end

  def check_for_winner?
    @board.connect4_across != nil || @board.connect4_up != nil || @board.connect4_right_diagonal != nil || @board.connect4_left_diagonal != nil
  end

  def determine_winner
    winner = ""
    winner << @board.connect4_across.to_s
    winner << @board.connect4_up.to_s
    winner << @board.connect4_right_diagonal.to_s
    winner << @board.connect4_left_diagonal.to_s
    board_full = @board.full?.to_s
    if winner == "r"
      @players.players.each do |player|
        if player.token == "r"
          puts "Congratulations, #{player.name}! You've won!"
        end
      end
    elsif board_full = "true"
      puts "It's a tie! The board is full!"
    else
      @players.players.each do |player|
        if player.token == "y"
          puts "Congratulations, #{player.name}! You've won!"
        end
      end
    end
  end
end
