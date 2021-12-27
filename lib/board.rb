# frozen_string_literal: true

require_relative '../lib/space'

# create board object for connect four
class Board
  attr_accessor :grid
  attr_reader :rows, :columns

  def initialize(rows: 6, columns: 7)
    @rows = rows
    @columns = columns
    @grid = create_grid(rows, columns)
    @space_array = Array.new(grid.flatten.count, Space.new)
  end

  def create_grid(rows, columns)
    result = []
    i = 0
    until i == rows
      result << Array.new(columns, ' ')
      i += 1
    end
    result
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


# board = Board.new
# board.update_board(6, 'X')
# board.display_board