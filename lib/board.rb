# frozen_string_literal: true

# create board object for connect four
class Board
  attr_accessor :grid, :space_array
  attr_reader :rows, :columns

  def initialize(rows: 6, columns: 7)
    @rows = rows
    @columns = columns
    @grid = create_grid(rows, columns)
  end

  def create_grid(rows, columns)
    Array.new(rows) { Array.new(columns, ' ') }
  end

  def display_board
    grid.each { |row| p row }
  end

  def update_board(input, symbol)
    i = -1
    i -= 1 until grid[i][input - 1] == ' '
    grid[i][input - 1] = symbol
  end
end
