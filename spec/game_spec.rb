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

            board.print_board
    
            result = game.king_in_check?
            expect(result).to eq(false)
    
          end
        end

      end
    end

  end

end