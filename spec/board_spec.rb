# spec/board_spec.rb

require_relative "../lib/board"
require_relative "../lib/piece"

describe Board do

  describe "#arraypos_to_boardpos" do
    
    context "when given 0,0" do
      it "returns 'a1'" do

        board = Board.new()
        result = board.arraypos_to_boardpos([0,0])
        expect(result).to eq("a1")

      end
    end

    context "when given 3,3" do
      it "returns 'd4'" do

        board = Board.new()
        result = board.arraypos_to_boardpos([3,3])
        expect(result).to eq("d4")

      end
    end

    context "when given 7,7" do
      it "returns 'h8'" do

        board = Board.new()
        result = board.arraypos_to_boardpos([7,7])
        expect(result).to eq("h8")

      end
    end

    context "when given 1,6" do
      it "returns 'g2'" do

        board = Board.new()
        result = board.arraypos_to_boardpos([1,6])
        expect(result).to eq("g2")

      end
    end

  end

  describe "#remove_self_checking_moves" do
    
    context "when white can self check... (vs queen)" do

      context "pawn" do

        it "moves.length returns 0" do

          board = Board.new()
          white_king = Piece.new(:king, :white, [0,0], board)
          white_pawn = Piece.new(:pawn, :white, [1,1], board)
          black_queen = Piece.new(:queen, :black, [7,7], board)

          board.place_in(white_king) # maybe make it so that this function can take multiple parameters
          board.place_in(white_pawn)
          board.place_in(black_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(white_pawn)
          result = white_pawn.moves.length
          expect(result).to eq(0)

        end       

      end

      context "knight" do

        it "moves.length returns 0" do

          board = Board.new()
          white_king = Piece.new(:king, :white, [0,0], board)
          white_knight = Piece.new(:knight, :white, [1,1], board)
          black_queen = Piece.new(:queen, :black, [7,7], board)

          board.place_in(white_king) # maybe make it so that this function can take multiple parameters
          board.place_in(white_knight)
          board.place_in(black_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(white_knight)
          result = white_knight.moves.length
          expect(result).to eq(0)

        end       

      end

      context "rook" do

        it "moves.length returns 0" do

          board = Board.new()
          white_king = Piece.new(:king, :white, [0,0], board)
          white_rook = Piece.new(:rook, :white, [1,1], board)
          black_queen = Piece.new(:queen, :black, [7,7], board)

          board.place_in(white_king) # maybe make it so that this function can take multiple parameters
          board.place_in(white_rook)
          board.place_in(black_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(white_rook)
          result = white_rook.moves.length
          expect(result).to eq(0)

        end       

      end

      context "bishop" do

        it "moves.length returns 6" do

          board = Board.new()
          white_king = Piece.new(:king, :white, [0,0], board)
          white_bishop = Piece.new(:bishop, :white, [1,1], board)
          black_queen = Piece.new(:queen, :black, [7,7], board)

          board.place_in(white_king) # maybe make it so that this function can take multiple parameters
          board.place_in(white_bishop)
          board.place_in(black_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(white_bishop)

          result = white_bishop.moves.length
          expect(result).to eq(6)

        end     

      end

      context "queen" do

        it "moves.length returns 6" do

          board = Board.new()
          white_king = Piece.new(:king, :white, [0,0], board)
          white_queen = Piece.new(:queen, :white, [1,1], board)
          black_queen = Piece.new(:queen, :black, [7,7], board)

          board.place_in(white_king) # maybe make it so that this function can take multiple parameters
          board.place_in(white_queen)
          board.place_in(black_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(white_queen)

          result = white_queen.moves.length
          expect(result).to eq(6)

        end   
      end

      context "king (impossible but funny)" do

        it "moves.length returns 0" do

          board = Board.new()
          white_king = Piece.new(:king, :white, [0,0], board)
          white_king2 = Piece.new(:king, :white, [1,1], board)
          black_queen = Piece.new(:queen, :black, [7,7], board)

          board.place_in(white_king) # maybe make it so that this function can take multiple parameters
          board.place_in(white_king2)
          board.place_in(black_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(white_king2)

          result = white_king2.moves.length
          expect(result).to eq(0)

        end   
      end

    end

    context "when black can self check... (vs queen)" do

      context "pawn" do

        it "moves.length returns 0" do

          board = Board.new()
          black_king = Piece.new(:king, :black, [7,0], board)
          black_pawn = Piece.new(:pawn, :black, [6,1], board)
          white_queen = Piece.new(:queen, :white, [0,7], board)

          board.place_in(black_king) # maybe make it so that this function can take multiple parameters
          board.place_in(black_pawn)
          board.place_in(white_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(black_pawn)
          result = black_pawn.moves.length
          expect(result).to eq(0)

        end       

      end

      context "knight" do

        it "moves.length returns 0" do

          board = Board.new()
          black_king = Piece.new(:king, :black, [7,0], board)
          black_knight = Piece.new(:knight, :black, [6,1], board)
          white_queen = Piece.new(:queen, :white, [0,7], board)

          board.place_in(black_king) # maybe make it so that this function can take multiple parameters
          board.place_in(black_knight)
          board.place_in(white_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(black_knight)
          result = black_knight.moves.length
          expect(result).to eq(0)

        end       

      end

      context "rook" do

        it "moves.length returns 0" do

          board = Board.new()
          black_king = Piece.new(:king, :black, [7,0], board)
          black_rook = Piece.new(:rook, :black, [6,1], board)
          white_queen = Piece.new(:queen, :white, [0,7], board)

          board.place_in(black_king) # maybe make it so that this function can take multiple parameters
          board.place_in(black_rook)
          board.place_in(white_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(black_rook)
          result = black_rook.moves.length
          expect(result).to eq(0)

        end       

      end

      context "bishop" do

        it "moves.length returns 6" do

          board = Board.new()
          black_king = Piece.new(:king, :black, [7,0], board)
          black_bishop = Piece.new(:bishop, :black, [6,1], board)
          white_queen = Piece.new(:queen, :white, [0,7], board)

          board.place_in(black_king) # maybe make it so that this function can take multiple parameters
          board.place_in(black_bishop)
          board.place_in(white_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(black_bishop)
          result = black_bishop.moves.length
          expect(result).to eq(6)

        end       

      end

      context "queen" do

        it "moves.length returns 6" do

          board = Board.new()
          black_king = Piece.new(:king, :black, [7,0], board)
          black_queen = Piece.new(:queen, :black, [6,1], board)
          white_queen = Piece.new(:queen, :white, [0,7], board)

          board.place_in(black_king) # maybe make it so that this function can take multiple parameters
          board.place_in(black_queen)
          board.place_in(white_queen)

          board.update_board_and_moves_on_all_pieces

          # board.print_board

          board.remove_self_checking_moves(black_queen)
          result = black_queen.moves.length
          expect(result).to eq(6)

        end       

      end

      
    end

  end
end