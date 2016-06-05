require 'Matrix'

class Board
  attr_reader :board

  def initialize
    @column_count = 7
    @row_count = 6
    @board = Matrix.build(@row_count, @column_count) { |row, column| Slot.new }
    @output = ""
  end

  def full?
    board.each do |slot|
      if slot.symbol == "o"
        return false
      end
    end
    return true
  end

  def make_move(column, token)
    column_array = board.column(column - 1).to_a
    column_array.reverse.each do |slot|
      if slot.empty?
        slot.drop_token("#{token}")
        return true
      end
    end
  end

  def connect4_across
    row = 6
    while row >= 0
      across_string = ""
      across_array = board.row(row).to_a
      across_array.each do |slot|
        across_string << slot.symbol
      end
      winner = check_connect4_strings(across_string)
      if !winner.nil?
        return winner
      end
      row -= 1
    end
    return nil
  end

  def connect4_up
    column = 7
    while column >= 0
      up_string = ""
      up_array = board.column(column).to_a
      up_array.each do |slot|
        up_string << slot.symbol
      end

      winner = check_connect4_strings(up_string)
      if !winner.nil?
        return winner
      end
      column -= 1
    end
    return nil
  end

  def connect4_right_diagonal
    winner = nil
    right_diagonals.each do |position|
      winner = check_connect4_strings(return_right_diagonal_string(position[0], position[1]))
      if !winner.nil?
        return winner
      end
    end
    return nil
  end

  def connect4_left_diagonal
    winner = nil
    left_diagonals.each do |position|
      winner = check_connect4_strings(return_left_diagonal_string(position[0], position[1]))
      if !winner.nil?
        return winner
      end
    end
    return nil
  end

  def show
    @output << "The Board \n"
    create_all_rows
    @output << "-----------------------------\n"
    @output << "| 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n\n"
    puts @output
  end

  def check_if_column_full?(column)
    counter = []
    column_array = board.column(column-1).to_a
    column_array.each do |slot|
      counter << slot.symbol
    end
    if !counter.include?("o")
      return true
    else
      return false
    end
  end

  private

  def right_diagonals
    right_diagonals = [
      [3,0],[4,0],[5,0],
      [5,1],[5,2],[5,3]
    ]
  end

  def left_diagonals
    left_diagonals = [
      [4,6],[5,6],[5,5],
      [5,4],[5,3],[3,6]
    ]
  end

  def return_right_diagonal_string(starting_row, starting_column)
    right_diagonal_string = ""
    row_count = starting_row
    column_count = starting_column
    while confirm_within_board?(row_count,column_count)
      right_diagonal_string << board.element(row_count,column_count).symbol
      column_count += 1
      row_count -= 1
    end
    right_diagonal_string
  end

  def return_left_diagonal_string(starting_row, starting_column)
    left_diagonal_string = ""
    row_count = starting_row
    column_count = starting_column
    while confirm_within_board?(row_count,column_count)
      left_diagonal_string << board.element(row_count,column_count).symbol
      column_count -= 1
      row_count -= 1
    end
    left_diagonal_string
  end

  def confirm_within_board?(row,column)
    row.between?(0, 5) && column.between?(0,6)
  end

  def check_connect4_strings(string)
    if string.include?("rrrr")
      return "r"
    elsif string.include?("yyyy")
      return "y"
    else
      return nil
    end
  end

  def create_all_rows
    count = 0
    while count < 6
      @output << create_row(count)
      count += 1
    end
    @output
  end

  def create_row(row_number)
    display_string = ""
    display_string << "|"
    board.row(row_number) do |slot|
      display_string << " #{slot.symbol} |"
    end
    display_string << "\n"
    display_string
  end
end
