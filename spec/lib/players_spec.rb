require_relative "../spec_helper"

RSpec.describe Players do
  let (:players) { Players.new }
  let (:player) { Player.new("Jane", "y") }

  describe "#initialize" do
    it "player should return an empty array upon initialization" do
      expect(players.players).to eq ([])
    end
  end

  describe "#add_player" do
    it "add_player should expect to return an array of player objects" do
      players.add_player(player)
      expect(players.players[0]).to be_kind_of(Player)
    end
  end
end
