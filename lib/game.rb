require_relative 'piece'
require 'colorize'

class Game

  attr_accessor :board, :player

  def initialize(board, setup_board_q, is_test = false)
    
    if setup_board_q
      @board = setup_board(board)
      @board.update_board_for_all_pieces
    else
      @board = board
    end
    
    @player = 0
    @is_test = is_test

  end

  def start

    introduction
    game_loop

  end

  def game_over?

    @board.update_board_and_moves_on_all_pieces

    if king_in_check?

      if !@is_test
        puts ""
        puts "CHECK!".red
      end

      if !has_moves?(@player)

        if !@is_test
          puts ""
          puts "CHECKMATE!".red
        end

        return true

      end
      
    end 

    return false

  end

  def end_game(current_player)

    if current_player == 0 
      # black wins
      puts "BLACK (".red + Chess.icons[:black][:king] + ") WINS!".red
    else
      # white wins
      puts "WHITE (".red + Chess.icons[:white][:king] + ") WINS!".red
    end

    puts ""
    puts "Thank you for playing :)".green
    puts ""

    exit

  end

  def has_moves?(player)

    @board.update_board_and_moves_on_all_pieces

    if player == 0 # white

      whites = @board.get_whites
      
      whites.each do |piece|

        # remove invalid self checking moves.
        @board.remove_self_checking_moves(piece)

        # puts "#{piece.icon} - #{piece.moves}" # for testing

        if piece.moves.length == 0
          next
        else
          return true
        end

      end

      return false

    else

      blacks = @board.get_blacks
      
      blacks.each do |piece|

        @board.remove_self_checking_moves(piece)

        # puts "#{piece.icon} - #{piece.moves}" # for testing

        if piece.moves.length == 0
          next
        else
          return true
        end

      end

      return false

    end

  end

  def king_in_check?(king_color = nil)

    Game.king_in_check?(king_color, @board)

  end

  def self.king_in_check?(king_color = nil, board)

    # loop through every piece and check if it's moves contains an opposite coloured king.
    # if true, return true else return false.

    if king_color != nil # if king_color is given...

      for i in 0..7
        for j in 0..7

          if board.at([i, j]).to_s == "-"
            next
          else
            # a piece is found
            if board.at([i, j]).color_sym == king_color # if piece is same colour as finding king then skip.
              next
            else
              # a opposite color piece is found
              board.at([i, j]).moves.each do |target|
                
                if board.at(target).to_s == "-"
                  next
                else
                  if board.at(target).color_sym == king_color && board.at(target).type_sym == :king
                    return true
                  else
                    next
                  end
                end

              end

            end     
          end

        end
      end

      return false
      
    else # a king color was not given...
      for i in 0..7
        for j in 0..7
          if board.at([i, j]).to_s == "-"
            next
          else
            # a piece is found...
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
      return false
    end  

  end

  def game_loop
    piece_select until game_over?
    end_game(@player)
  end

  def print_board
    puts ""
    @board.print_board
    puts ""
  end

  def is_selected_piece_pos_valid?(selected_piece_pos)
    if @board.validate_boardpos_string(selected_piece_pos) && @board.at(@board.boardpos_to_arraypos(selected_piece_pos)) != "-" && @board.at(@board.boardpos_to_arraypos(selected_piece_pos)).color_sym == current_color_player 
      true
    else
      false
    end
  end

  def is_new_pos_valid?(new_pos, piece_moves_arr)
    if @board.validate_boardpos_string(new_pos) &&  @board.validate_given_boardpos_to_options(new_pos, piece_moves_arr)
      true
    else
      false
    end
  end

  def piece_select

    @board.update_board_and_moves_on_all_pieces
    
    print_board

    # grab the piece that the player wants to move
    puts "Player #{@player+1}"
    puts "Select a piece... For example: 'e2'"
    selected_piece_pos = gets.chomp
    puts ""

    # SAVING AND LOADING FEATURE
    if selected_piece_pos == "SAVE"
      data = Marshal.dump(self)
      File.open("saved_game.txt", "w") { |f| f.write "#{data}" }
      exit
    elsif selected_piece_pos == "LOAD"
      data = File.open("saved_game.txt").read
      previous_game = Marshal.load(data)
      previous_game.game_loop
    end

    
    if is_selected_piece_pos_valid?(selected_piece_pos)
      
      # selected_piece_pos input is valid

      piece = @board.at(@board.boardpos_to_arraypos(selected_piece_pos))

      # need to remove self checking moves here because...
      # it's doesn't really work in piece.rb even tho it belongs in there... :/
      @board.remove_self_checking_moves(piece)

      # selected piece has no moves
      if !piece.has_moves?
        puts "Error! This piece has no available moves. Please try again.".red
        return
      end

      # selected piece has moves...

      # show moves to player:
      @board.print_moves_for(selected_piece_pos)

      # grab new position for the piece from player
      puts ""
      puts "Player #{@player+1}"
      puts "Select new position... For example: 'e4'"
      new_pos = gets.chomp
      puts ""

      if is_new_pos_valid?(new_pos, piece.moves)
        @board.move(selected_piece_pos, new_pos)
        @board.update_board_and_moves_on_all_pieces
        switch_player
      else

        if new_pos == "" # peaking
          return
        end

        # new_pos is bad
        puts "Error! Please try again.".red
        return
      
      end

    else

      # bad input for selected_piece_pos
      puts "Error! Please try again.".red
      return

    end

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