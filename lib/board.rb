require 'pry'

class Board
  attr_reader :board

  def initialize
    @board = []
    6.times do
      row = []
      7.times do
        row << Slot.new
      end
      @board << row
    end
  end

  def full?
    full = []
    board.each do |row|
      row.each do |slot|
        if slot.empty?
          full << "empty"
        else
          full << "full"
        end
      end
    end
    !full.include?("empty")
  end

  def make_move(column, token)
    row_count = 5
    7.times do
      if board[row_count][column.to_i - 1].empty?
        board[row_count][column.to_i - 1].drop_token(token)
        return true
      end
      row_count -= 1
    end
    raise ColumnIsFullError, "That column is full. Pick a new one"
  end

  def connect4_across
    piece_count = 1
    winning_symbol = ""
    board.each do |row|
      last_piece = row[0].symbol
      row.each do |slot|
        if !slot.empty?
          if slot.symbol == last_piece
            last_piece = slot.symbol
            winning_symbol = slot.symbol
            piece_count += 1
            if piece_count >= 4 && winning_symbol != "o"
              return winning_symbol
            end
          else
            last_piece = slot.symbol
            piece_count = 1
          end
        else
          piece_count = 0
        end
      end
    end
    return nil
  end

  def connect4_up
    piece_count = 1
    column_count = 0
    last_piece = nil
    winning_symbol = ""

    while column_count < 7
      row_count = 0
      last_piece = board[row_count][column_count].symbol
      while row_count < 6
        if !board[row_count][column_count].empty?
          if last_piece == board[row_count][column_count].symbol
            last_piece = board[row_count][column_count].symbol
            winning_symbol = board[row_count][column_count].symbol
            piece_count += 1
            row_count += 1
            if piece_count >= 4 && winning_symbol != "o"
              return winning_symbol
            end
          else
            last_piece = board[row_count][column_count].symbol
            piece_count = 1
            row_count += 1
          end
        else
          row_count += 1
        end
      end
      column_count += 1
    end
    return nil
  end

  def connect4_right_diagonal
    piece_count = 1
    column_count = 0
    last_piece = nil

    while column_count < 7
      row_count = 5
      last_piece = board[row_count][column_count].symbol
      while row_count >= 0
        if !board[row_count][column_count].empty?
          if (row_count - 1).between?(0, 5) && (column_count + 1).between?(0,6) && board[row_count - 1][ column_count + 1].symbol == last_piece && !board[row_count - 1][ column_count + 1].symbol.empty?
            last_piece == board[row_count - 1][ column_count + 1]
            piece_count += 1
          end

          if (row_count - 2).between?(0, 5) && (column_count + 2).between?(0,6) && board[row_count - 2][ column_count + 2].symbol == last_piece && !board[row_count - 2][ column_count + 2].symbol.empty?
            last_piece == board[row_count - 2][ column_count + 2]
            piece_count += 1
          end

          if (row_count - 3).between?(0, 5) && (column_count + 3).between?(0,6) && board[row_count - 3][ column_count + 3].symbol == last_piece && !board[row_count - 3][ column_count + 3].symbol.empty?
            last_piece == board[row_count - 3][ column_count + 3]
            piece_count += 1
            if piece_count == 4
              return last_piece
            else
              return nil
            end
          end
        end
        row_count -= 1
      end
      column_count += 1
    end
  end

  def connect4_left_diagonal
    piece_count = 1
    column_count = 6
    last_piece = nil


    while column_count >= 0
      row_count = 5
      last_piece = board[row_count][column_count].symbol
      while row_count >= 0
        if !board[row_count][column_count].empty?
          if (row_count - 1).between?(0, 5) && (column_count - 1).between?(0, 6) && board[row_count - 1][ column_count - 1].symbol == last_piece && !board[row_count - 1][ column_count - 1].symbol.empty?
            last_piece == board[row_count - 1][ column_count - 1]
            piece_count += 1
          end

          if (row_count - 2).between?(0, 5) && (column_count - 2).between?(0, 6) && board[row_count - 2][ column_count - 2].symbol == last_piece && !board[row_count - 2][ column_count - 2].symbol.empty?
            last_piece == board[row_count - 2][ column_count - 2]
            piece_count += 1
          end

          if (row_count - 3).between?(0, 5) && (column_count - 3).between?(0, 6) && board[row_count - 3][ column_count - 3].symbol == last_piece && !board[row_count - 3][ column_count - 3].symbol.empty?
            last_piece == board[row_count - 3][ column_count - 3]
            piece_count += 1

            if piece_count == 4
              return last_piece
            else
              return nil
            end
          end
        end
        row_count -= 1
      end
      column_count -= 1
    end
  end

  def show
    output = "The Board \n"
    board.each do |row|
      output << "|"
      row.each do |slot|
        output << " #{slot.symbol} |"
      end
      output << "\n"
    end
    output << "-----------------------------\n"
    output << "| 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n\n"
    puts output
  end
end

class ColumnIsFullError < StandardError
end
