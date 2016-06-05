class Slot
  attr_reader :symbol

  def initialize
    @symbol = "o"
  end

  def empty?
    @symbol == "o"
  end

  def drop_token(color)
    @symbol = "#{color}"
  end
end
