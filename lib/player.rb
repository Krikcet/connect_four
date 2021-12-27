# frozen_string_literal: true

require_relative '../lib/board'

# create player objects for use in connect four
class Player
  attr_reader :player_symbol

  def initialize(symbol)
    @player_symbol = symbol
  end
end
