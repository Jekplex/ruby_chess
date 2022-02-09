require_relative 'board'
require_relative 'piece'
require_relative 'chess'
require_relative 'game'

game = Game.new(Board.new())
#game.start
# p game.board.at([1,0])
game.game_loop


###

# board = Board.new()
# p board
# board.print_board

# pos = "h5"
# white_king = Piece.new(:king, :white, board.boardpos_to_arraypos(pos), board)
# board.place_in(white_king)

# black_king = Piece.new(:king, :black, board.boardpos_to_arraypos("g6"), board)
# board.place_in(black_king)

# board.print_board
# board.print_moves_for("h5")

###

# p board.at(board.boardpos_to_arraypos(pos))


# game = Game.new(Board.new)

# game.setup_board(board)

# board.print_board

# board.setup
# board.print_board

# board.print_moves_for("a1")



# str = "h5"
# pos = board.board_pos_to_real_pos(str)
# #p pos

# white_king = Piece.new("king", "white", pos, Chess.icons[:white][:king])
# white_rook = Piece.new("rook", "white", board.board_pos_to_real_pos("d5"), Chess.icons[:white][:rook])

# black_king = Piece.new("king", "black", board.board_pos_to_real_pos("a5"), Chess.icons[:black][:king])

# board.place_in(white_king)
# board.print_board
# board.print_moves_for(str)
# board.place_in(white_rook)
# board.print_board
# board.print_moves_for("d5")
# board.place_in(black_king)
# board.print_moves_for("d5")

# p king.moves
# p king
# p board
# board.print_board

