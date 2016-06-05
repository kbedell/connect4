require 'pry'

class Players
  attr_reader :players

  def initialize
    @players = []
  end

  def add_player (player)
    players << player
  end

  def unique?(name)
    players.each do |player|
      if player.name == name
        return false
      end
    end
    return true
  end
end
