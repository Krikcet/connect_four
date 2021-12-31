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
    board.grid.transpose.any? do |column|
      column.each_cons(4).any? do |spaces|
        spaces.all? { |sym| sym == symbol }
      end
    end
  end

  def descending_victory?(symbol)
    marked_spaces = board.grid.reduce([]) { |memo, row| memo << row.index(symbol) }
    marked_spaces.compact.each_cons(4).any? do |spaces|
      spaces.each_cons(2).all? { |first, second| second == first + 1 }
    end
  end

  def ascending_victory?(symbol)
    marked_spaces = board.grid.reduce([]) { |memo, row| memo << row.index(symbol) }
    marked_spaces.compact.each_cons(4).any? do |spaces|
      spaces.each_cons(2).all? { |first, second| second == first - 1 }
    end
  end

  def winner?(symbol)
    return true if row_victory?(symbol) ||
                   column_victory?(symbol) ||
                   ascending_victory?(symbol) ||
                   descending_victory?(symbol)

    false
  end

  def game_over?(symbol)
    return true if winner?(symbol) || board.grid.all? { |row| row.none? { |space| space == ' ' } }

    false
  end

  def display_end(player)
    board.display_board
    puts winner?(player.player_symbol) ? "#{player.player_symbol} wins!" : "It's a draw!"
  end

  def display_welcome
    puts 'Welcome to Connect Four. Choose a column! (1-7)'
  end

  def play_game
    player = player_one
    loop do
      board.display_board
      puts 'Choose a column'
      board.update_board(choose_column, player.player_symbol)
      return display_end(player) if game_over?(player.player_symbol)

      player = player == player_one ? player_two : player_one
    end
  end
end
