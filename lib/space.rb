# frozen_string_literal: true

# create space objects that will populate the board for connect four
class Space
  def initialize
    @value = ' '
    @neighbors = {
      vertical: nil,
      horizontal: nil,
      left_diagonal: nil,
      right_diagonal: nil
    }
  end
end
