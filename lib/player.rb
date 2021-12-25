# frozen_string_literal: true

# create player objects for use in connect four
class Player
  attr_reader :player_symbol

  def initialize(symbol)
    @player_symbol = symbol
  end

  def verify_input(input)
    return input if input.between?(1, 7)
  end

  def choose_column
    loop do
      column = gets.chomp.to_i
      verified_column = verify_input(column)
      return verified_column if verified_column
      
      puts 'Please choose a different column.'
    end

  end
end
