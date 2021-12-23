# frozen_string_literal: true

# create board object for connect four
class Board
  attr_reader :grid

  def initialize(rows: 6, columns: 7)
    @grid = create_grid(rows, columns)
  end

  def create_grid(rows, columns)
    Array.new(rows, Array.new(columns, ' '))
  end
end
