# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'

# create game instance of connect four
class Game
  attr_reader :player_one, :player_two
  attr_accessor :board

  def initialize
    @board = Board.new
    @player_one = Player.new('X')
    @player_two = Player.new('O')
  end

  def verify_input(input)
    return input if input.between?(1, 7) && board.grid.first[input - 1] == ' '
  end

  def choose_column
    loop do
      column = gets.chomp.to_i
      verified_column = verify_input(column)
      return verified_column if verified_column

      puts 'Please choose a different column.'
    end
  end

  def row_victory?(symbol)
    board.grid.any? do |row|
      row.each_cons(4).any? do |spaces|
        spaces.all? { |sym| sym == symbol }
      end
    end
  end

  def column_victory?(symbol)
    board.grid.transpose.any? do |row|
      row.each_cons(4).any? do |spaces|
        spaces.all? { |sym| sym == symbol }
      end
    end
  end

  # diagonal victory

  def winner?(symbol)
    return true if row_victory?(symbol) || column_victory?(symbol)

    false
  end
end
