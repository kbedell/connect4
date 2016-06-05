require_relative "../spec_helper"

RSpec.describe Slot do

  let(:slot) { Slot.new }

  describe "#initialize" do
    it "creates an empty slot" do
      expect(slot.symbol).to eq ("o")
    end

    it "There should be a reader for symbol" do
      slot.drop_token("r")
      expect(slot.symbol).to eq ("r")
    end

    it "There shouldn't be a writer for symbol" do
      slot.drop_token("r")
      expect { slot.symbol = "w" }.to raise_error (NoMethodError)
    end
  end

  describe "#empty?" do
    it "checks to confirm that slot is empty" do
      expect(slot.empty?).to eq (true)
    end

    it "checks to confirm that slot is not empty" do
      slot.drop_token("r")
      expect(slot.empty?).to eq (false)
    end
  end

  describe "#drop_token" do
    it "change the token symbol" do
      slot.drop_token("y")
      expect(slot.symbol).to eq ("y")
    end
  end
end
