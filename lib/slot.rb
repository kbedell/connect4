class Slot
  attr_reader :symbol

  def initialize (symbol="o")
    @symbol = symbol
  end

  def empty?
    symbol == "o"
  end

  def drop_token(color)
    @symbol = "#{color}"
  end
end
