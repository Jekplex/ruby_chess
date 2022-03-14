#spec/game_spec.rb

require_relative "../lib/game"

require_relative "../lib/board"
require_relative "../lib/piece"

describe Game do

  describe "#king_in_check?" do

    context "white check" do
    
      context "vs black pawn" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            pawn = Piece.new(:pawn, :black, [4,4], board)
    
            board.place_in(king)
            board.place_in(pawn)

            board.update_board_and_moves_on_all_pieces
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            pawn = Piece.new(:pawn, :black, [5,4], board)
    
            board.place_in(king)
            board.place_in(pawn)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end

      context "vs black knight" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            knight = Piece.new(:knight, :black, [4,5], board)
    
            board.place_in(king)
            board.place_in(knight)
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            knight = Piece.new(:knight, :black, [0,0], board)
    
            board.place_in(king)
            board.place_in(knight)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end

      context "vs black bishop" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            bishop = Piece.new(:bishop, :black, [7,7], board)
    
            board.place_in(king)
            board.place_in(bishop)
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            bishop = Piece.new(:bishop, :black, [1,2], board)
    
            board.place_in(king)
            board.place_in(bishop)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end

      context "vs black rook" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            rook = Piece.new(:rook, :black, [7,3], board)
    
            board.place_in(king)
            board.place_in(rook)
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            rook = Piece.new(:rook, :black, [2,2], board)
    
            board.place_in(king)
            board.place_in(rook)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end

      context "vs black queen" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            queen = Piece.new(:queen, :black, [1,1], board)
    
            board.place_in(king)
            board.place_in(queen)
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :white, [3,3], board)
            queen = Piece.new(:queen, :black, [4,5], board)
    
            board.place_in(king)
            board.place_in(queen)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end
    end

    context "black check" do
    
      context "vs white pawn" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            pawn = Piece.new(:pawn, :white, [2,2], board)
    
            board.place_in(king)
            board.place_in(pawn)
            board.update_board_and_moves_on_all_pieces
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            pawn = Piece.new(:pawn, :white, [0,0], board)
    
            board.place_in(king)
            board.place_in(pawn)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end

      context "vs white knight" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            knight = Piece.new(:knight, :white, [4,5], board)
    
            board.place_in(king)
            board.place_in(knight)
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            knight = Piece.new(:knight, :white, [0,0], board)
    
            board.place_in(king)
            board.place_in(knight)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end

      context "vs white bishop" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            bishop = Piece.new(:bishop, :white, [7,7], board)
    
            board.place_in(king)
            board.place_in(bishop)
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            bishop = Piece.new(:bishop, :white, [1,2], board)
    
            board.place_in(king)
            board.place_in(bishop)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end

      context "vs white rook" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            rook = Piece.new(:rook, :white, [7,3], board)
    
            board.place_in(king)
            board.place_in(rook)
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            rook = Piece.new(:rook, :white, [2,2], board)
    
            board.place_in(king)
            board.place_in(rook)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end

      context "vs white queen" do

        context "when in check" do
          it "return true" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            queen = Piece.new(:queen, :white, [1,1], board)
    
            board.place_in(king)
            board.place_in(queen)
    
            result = game.king_in_check?
            expect(result).to eq(true)
    
          end
        end

        context "when not in check" do
          it "return false" do

            board = Board.new
            game = Game.new(board, false)
    
            king = Piece.new(:king, :black, [3,3], board)
            queen = Piece.new(:queen, :white, [4,5], board)
    
            board.place_in(king)
            board.place_in(queen)
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end
    end

  end

  describe "#game_over?" do
    
    context "white check" do

      context "Fool's Mate" do

        it "returns true" do

          board = Board.new()
          game = Game.new(board, true, true)

          # setup board for checkmate
          game.board.move("f2", "f3")
          game.board.move("e7", "e5")
          game.board.move("g2", "g4")
          game.board.move("d8", "h4")
          game.player = 0 # white turn

          result = game.game_over?
          expect(result).to eq(true)

        end

      end

      

    end

    context "black check" do

      context "Scholar's Mate" do

        it "returns true" do

          board = Board.new()
          game = Game.new(board, true, true)

          # setup board for checkmate
          game.board.move("e2", "e4")
          game.board.move("e7", "e5")
          game.board.move("f1", "c4")
          game.board.move("b8", "c6")
          game.board.move("d1", "h5")
          game.board.move("g8", "f6")
          game.board.move("h5", "f7") # check hit
          game.player = 1 # black turn

          #p game.print_board

          result = game.game_over?
          expect(result).to eq(true)

        end

      end

    end

  end

end