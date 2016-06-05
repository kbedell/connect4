require_relative "../spec_helper"

RSpec.describe Board do
  let (:board) { Board.new }
  let (:player) { Players.new }

  describe "#initialize" do
    it "expect a board to be a board object" do
      expect(board).to be_kind_of(Board)
    end

    it "expect a board to be a matrix" do
      expect(board.board).to be_kind_of(Matrix)
    end

    it "expect a board to be a matrix with 7 columns" do
      expect(board.board.column_count).to eq (7)
    end

    it "expect a board to be a matrix with 6 rows" do
      expect(board.board.row_count).to eq (6)
    end

    it "expect a board to be a matrix filled with slot items" do
      expect(board.board.element(0,0)).to be_kind_of(Slot)
    end
  end

  describe "#full?" do
    it "returns true if the board is full" do
      board_full = Board.new
        board_full.board.each do |slot|
          slot.drop_token("y")
        end
      expect(board_full.full?).to eq (true)
    end

    it "returns false if the board is not full" do
      expect(board.full?).to eq (false)
    end
  end

  describe "#make_move" do
    it "should allow a player to select a column, and fill the column" do
      expect(board.make_move(2, "r")).to eq (true)
    end
  end

  describe "#connect4_across" do
    it "returns the winning symbol 'r' for across connect 4" do
      board.make_move(1,"r")
      board.make_move(2,"r")
      board.make_move(3,"r")
      board.make_move(4,"r")
      expect(board.connect4_across).to eq ("r")
    end

    it "returns nil since there is no connect 4 across" do
      board.make_move(1,"r")
      board.make_move(2,"r")
      board.make_move(5,"r")
      board.make_move(6,"r")
      expect(board.connect4_across).to eq (nil)
    end
  end

  describe "#connect4_up" do
    it "returns the winning symbol 'y' for column connect 4 vertically" do
      board.make_move(1,"y")
      board.make_move(1,"y")
      board.make_move(1,"y")
      board.make_move(1,"y")
      expect(board.connect4_up).to eq ("y")
    end

    it "returns nil since there is no connect 4 vertically" do
      board.make_move(1,"y")
      board.make_move(1,"y")
      board.make_move(1,"r")
      board.make_move(2,"y")
      expect(board.connect4_up).to eq (nil)
    end
  end

  describe "#connect4_right_diagonal" do
    it "returns 'y' since there is a connect 4 diagonally to the right" do
      board.make_move(1,"y")
      board.make_move(2,"r")
      board.make_move(2,"y")
      board.make_move(3,"r")
      board.make_move(3,"r")
      board.make_move(3,"y")
      board.make_move(4,"r")
      board.make_move(4,"r")
      board.make_move(4,"r")
      board.make_move(4,"y")
      expect(board.connect4_right_diagonal).to eq ("y")
    end

    it "returns nil since there is no connect 4 diagonally to the right" do
      board.make_move(1,"y")
      board.make_move(2,"r")
      board.make_move(2,"y")
      board.make_move(3,"r")
      board.make_move(3,"r")
      board.make_move(3,"y")
      board.make_move(4,"r")
      board.make_move(4,"r")
      board.make_move(4,"r")
      board.make_move(4,"r")
      expect(board.connect4_right_diagonal).to eq (nil)
    end
  end

  describe "#connect4_left_diagonal" do
    it "returns 'r' since there is a connect 4 diagonally to the left" do
      board.make_move(7,"r")
      board.make_move(6,"y")
      board.make_move(6,"r")
      board.make_move(5,"y")
      board.make_move(5,"y")
      board.make_move(5,"r")
      board.make_move(4,"y")
      board.make_move(4,"y")
      board.make_move(4,"y")
      board.make_move(4,"r")
      expect(board.connect4_left_diagonal).to eq ("r")
    end

    it "returns nil since there is no connect4 diagonally to the left" do
      board.make_move(7,"r")
      board.make_move(6,"y")
      board.make_move(6,"r")
      board.make_move(5,"y")
      board.make_move(5,"y")
      board.make_move(5,"r")
      board.make_move(4,"y")
      board.make_move(4,"y")
      board.make_move(4,"y")
      board.make_move(4,"y")
      expect(board.connect4_left_diagonal).to eq (nil)
    end
  end


  describe "#show" do
    it "outputs a board to the screen'" do
      board.make_move(1,"r")
      board.make_move(2,"r")
      board.make_move(5,"r")
      board.make_move(6,"r")
      expect { board.show }.to output("The Board \n| o | o | o | o | o | o | o |\n| o | o | o | o | o | o | o |\n| o | o | o | o | o | o | o |\n| o | o | o | o | o | o | o |\n| o | o | o | o | o | o | o |\n| r | r | o | o | r | r | o |\n-----------------------------\n| 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n\n").to_stdout
    end
  end

  describe "#check_if_column_full?" do
    it "returns true because the column is full" do
      board.make_move(1,"r")
      board.make_move(1,"r")
      board.make_move(1,"r")
      board.make_move(1,"r")
      board.make_move(1,"r")
      board.make_move(1,"r")      
      expect(board.check_if_column_full?(1)).to eq (true)
    end

    it "returns false because the column is not full" do
      board.make_move(1,"r")
      expect(board.check_if_column_full?(1)).to eq (false)
    end
  end
end
