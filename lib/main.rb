require_relative 'board'
require_relative 'piece'
require_relative 'chess'
require_relative 'game'

game = Game.new(Board.new(), true)

# game.start
game.game_loop



