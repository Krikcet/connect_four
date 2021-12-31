# frozen_string_literal: true

require_relative '../lib/game'

# driver for Connect Four game

game = Game.new
game.display_welcome
game.play_game
