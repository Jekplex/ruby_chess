require 'colorize'

class Game

  attr_accessor :board

  def initialize(board, bool_setup_board)
    
    if bool_setup_board
      @board = setup_board(board)
      @board.update_board_and_moves_on_all_pieces
    else
      @board = board
    end
    
    @player = 0

  end

  def start

    introduction

    # game play loop

    # player 1 picks a valid piece to move
    # print moves for the piece
    # player 1 picks new position for piece
    # switch player
    # player 2 picks a valid piece to move
    # print moves for the piece
    # player 2 picks new position for piece
    # switch back to player 1
    # loop this until checkmate.
  
  end

  def game_over?
    #false

    # game is over when a king is in check and the checked player has no legal moves to get out of check.
    # checkmate

    @board.update_board_and_moves_on_all_pieces

    if king_in_check? && !has_moves?(@player)
      puts "CHECKMATE #{@player}!"
      true
    else
      false
    end

  end

  def has_moves?(player)
    if player == 0 # white
      whites = @board.get_whites
      whites.each do |piece|
        if piece.moves.length == 0
          next
        else
          true
        end
      end
      false
    else
      blacks = @board.get_blacks
      blacks.each do |piece|
        if piece.moves.length == 0
          next
        else
          true
        end
      end
      false
    end

  end

  def king_in_check?(king_color = nil)

    # loop through every piece and check if it's moves contains an opposite coloured king.
    # if true, return true else return false.

    if king_color != nil 
      for i in 0..7
        for j in 0..7
          if @board.at([i, j]).to_s == "-"
            next
          else
            @board.at([i, j]).moves.each do |target|
              if @board.at(target).to_s == "-"
                next
              else
                if @board.at(target).color_sym == king_color && @board.at(target).type_sym == :king
                  return true
                else
                  next
                end
              end
            end
          end
        end
      end
      false
    else
      for i in 0..7
        for j in 0..7
          if @board.at([i, j]).to_s == "-"
            next
          else
            @board.at([i, j]).moves.each do |target|
              if @board.at(target).to_s == "-"
                next
              else
                if @board.at(target).color_sym != @board.at([i, j]).color_sym && @board.at(target).type_sym == :king
                  return true
                else
                  next
                end
              end
            end
          end
        end
      end
      false
    end   

  end

  def self.king_in_check?(king_color = nil, board)

    # loop through every piece and check if it's moves contains an opposite coloured king.
    # if true, return true else return false.

    if king_color != nil # given colour
      for i in 0..7
        for j in 0..7
          if board.at([i, j]).to_s == "-"
            next
          else
            # position is piece
            board.at([i, j]).moves.each do |target|
              if board.at(target).to_s == "-"
                next
              else
                if board.at(target).color_sym == king_color && board.at(target).type_sym == :king && (board.at(target).icon != board.at([i, j]).icon)
                  return true
                else
                  next
                end
              end
            end
          end
        end
      end
      false
    else
      for i in 0..7
        for j in 0..7
          if board.at([i, j]).to_s == "-"
            next
          else
            board.at([i, j]).moves.each do |target|
              if board.at(target).to_s == "-"
                next
              else
                if board.at(target).color_sym != board.at([i, j]).color_sym && board.at(target).type_sym == :king
                  return true
                else
                  next
                end
              end
            end
          end
        end
      end
      false
    end   

  end

  def game_loop
    piece_select until game_over?
  end

  def piece_select
    
    puts ""
    @board.print_board
    puts ""

    puts "Player #{@player+1}"
    puts "Select a piece... For example: 'e2'"
    selected_piece_pos = gets.chomp

    puts ""

    if selected_piece_pos == "SAVE"
      data = Marshal.dump(self)
      File.open("saved_game.txt", "w") { |f| f.write "#{data}" }
      exit
    elsif selected_piece_pos == "LOAD"
      data = File.open("saved_game.txt").read
      previous_game = Marshal.load(data)
      previous_game.game_loop
    end

    # validate selected piece

    if @board.validate_boardpos_string(selected_piece_pos) && @board.at(@board.boardpos_to_arraypos(selected_piece_pos)) != "-" && @board.at(@board.boardpos_to_arraypos(selected_piece_pos)).color_sym == current_color_player 
      # good input

      # good input but no moves
      if @board.at(@board.boardpos_to_arraypos(selected_piece_pos)).moves == []
        puts "Error! This piece has no available moves. Please try again.".red
        piece_select
      end

      # grab piece
      selected_piece = @board.at(@board.boardpos_to_arraypos(selected_piece_pos))

      # print movables for that position
      @board.print_moves_for(selected_piece_pos)

      if selected_piece.moves == []
        puts "Error! This piece has no available moves. Please try again.".red
        return
      end

      # select new pos
      puts ""
      puts "Player #{@player+1}"
      puts "Select new position... For example: 'e4'"

      new_pos = gets.chomp

      puts ""

      if @board.validate_boardpos_string(new_pos) &&  @board.validate_given_boardpos_to_options(new_pos, selected_piece.moves)

        # good input

        # move piece position
        #pos = @board.boardpos_to_arraypos(new_pos)
        
        @board.move(selected_piece_pos, new_pos)
        @board.update_board_and_moves_on_all_pieces
        switch_player

      else

        if new_pos == "" # peaking
          return
        end

        # bad input

        puts "Error! Please try again.".red
        piece_select

      end

    else
      # bad input

      # try again.
      puts "Error! Please try again.".red
      piece_select

    end

    #p @player

  end

  def current_color_player
    if @player == 0
      :white
    else
      :black
    end
  end

  def switch_player
    @player = (@player + 1) % 2
  end

  def introduction
    puts ""
    puts "Welcome to Jekplex's Chess"
    puts "Made for the command line using Ruby"
    puts ""
  end

  def setup_board_custom(board)
    white_rook1 = Piece.new(:rook, :white, board.boardpos_to_arraypos("a1"), board)
    board.place_in(white_rook1)
    return board
  end

  def setup_board(board)
    
    # pawns
    for i in 0..7

      white_pawn = Piece.new(:pawn, :white, [1, i], board)
      board.place_in(white_pawn)

      black_pawn = Piece.new(:pawn, :black, [6, i], board)
      board.place_in(black_pawn)

    end

    # rooks
    white_rook1 = Piece.new(:rook, :white, board.boardpos_to_arraypos("a1"), board)
    white_rook2 = Piece.new(:rook, :white, board.boardpos_to_arraypos("h1"), board)
    black_rook1 = Piece.new(:rook, :black, board.boardpos_to_arraypos("a8"), board)
    black_rook2 = Piece.new(:rook, :black, board.boardpos_to_arraypos("h8"), board)
    board.place_in(white_rook1)
    board.place_in(white_rook2)
    board.place_in(black_rook1)
    board.place_in(black_rook2)

    # knights
    white_knight1 = Piece.new(:knight, :white, board.boardpos_to_arraypos("b1"), board)
    white_knight2 = Piece.new(:knight, :white, board.boardpos_to_arraypos("g1"), board)
    black_knight1 = Piece.new(:knight, :black, board.boardpos_to_arraypos("b8"), board)
    black_knight2 = Piece.new(:knight, :black, board.boardpos_to_arraypos("g8"), board)
    board.place_in(white_knight1)
    board.place_in(white_knight2)
    board.place_in(black_knight1)
    board.place_in(black_knight2)

    # bishops
    white_b1 = Piece.new(:bishop, :white, board.boardpos_to_arraypos("c1"), board)
    white_b2 = Piece.new(:bishop, :white, board.boardpos_to_arraypos("f1"), board)
    black_b1 = Piece.new(:bishop, :black, board.boardpos_to_arraypos("c8"), board)
    black_b2 = Piece.new(:bishop, :black, board.boardpos_to_arraypos("f8"), board)
    board.place_in(white_b1)
    board.place_in(white_b2)
    board.place_in(black_b1)
    board.place_in(black_b2)

    # queens
    white_q = Piece.new(:queen, :white, board.boardpos_to_arraypos("d1"), board)
    black_q = Piece.new(:queen, :black, board.boardpos_to_arraypos("d8"), board)
    board.place_in(white_q)
    board.place_in(black_q)

    # kings
    white_king = Piece.new(:king, :white, board.boardpos_to_arraypos("e1"), board)
    black_king = Piece.new(:king, :black, board.boardpos_to_arraypos("e8"), board)
    board.place_in(white_king)
    board.place_in(black_king)

    return board

  end

end