# frozen_string_literal: true

require_relative 'game'
require_relative 'board'

game = Game.new(Board.new, true)
game.start
