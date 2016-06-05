class Game

  def initialize (board)
    @board = board
    @players = nil
    @players = Players.new
  end

  def assign_players
    puts "Hello, and welcome to Connect 4. Player 1, please enter your name."
    player_name = STDIN.gets.chomp
    player1 = Player.new("#{player_name}","r")
    @players.add_player(player1)
    puts "#{player_name}, your color is 'red' or 'r'"

    puts "Player 2, please enter your name."
    player_name2 = STDIN.gets.chomp
    player2 = Player.new("#{player_name2}","y")
    while !@players.unique?(player_name2)
      puts "Please enter a unique name"
      player_name2 = STDIN.gets.chomp
    end

    @players.add_player(player2)
    puts "#{player_name2}, your color is 'yellow' or 'y'"
  end

  def turns
    player_count = 0
    @board.show
    while !@board.full? && @board.connect4_across == nil && @board.connect4_up == nil && @board.connect4_right_diagonal == nil && @board.connect4_left_diagonal == nil
      puts "#{@players.players[player_count].name} your turn"
      puts "Select your column"
      column = STDIN.gets.chomp
      @board.make_move(column, @players.players[player_count].token)
      @board.show
      if player_count == 0
        player_count += 1
      else
        player_count -= 1
      end
    end

    if @board.connect4_across != nil
      @players.players.each do |player|
        if player.token == @board.connect4_across
          puts "Congratulations #{player.name}, you've won!"
        end
      end
    elsif @board.connect4_up != nil
      @players.players.each do |player|
        if player.token == @board.connect4_up
          puts "Congratulations #{player.name}, you've won!"
        end
      end
    elsif @board.connect4_right_diagonal != nil
      @players.players.each do |player|
        if player.token == @board.connect4_right_diagonal
          puts "Congratulations #{player.name}, you've won!"
        end
      end
    elsif @board.connect4_left_diagonal != nil
      @players.players.each do |player|
        if player.token == @board.connect4_left_diagonal
          puts "Congratulations #{player.name}, you've won!"
        end
      end
    end
  end
end
