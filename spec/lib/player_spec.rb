require_relative "../spec_helper"

RSpec.describe Player do
  let (:player) { Player.new("Jane","r") }

  describe "#name" do
    it "player should have a reader for name" do
      expect(player.name).to eq ("Jane")
    end
  end

  describe "#token" do
    it "player should have a reader for token" do
      expect(player.token).to include ("r")
    end
  end
end
