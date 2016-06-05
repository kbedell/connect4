require_relative "players"
require_relative "player"
require_relative "slot"
require_relative "board"
require_relative "game"

require 'pry'
board = Board.new
game = Game.new(board)
game.assign_players
game.turns
