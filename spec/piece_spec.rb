#spec/piece_spec.rb

require_relative "../lib/piece"
require_relative "../lib/board"

describe Piece do

  describe "#initialize" do
    context "when white pawn" do

      it "should build moves" do
        board = Board.new
        white_pawn = Piece.new(:pawn, :white, [0,0], board)
        expect(white_pawn.moves.length).to be > 0
      end

      it "should grab proper icon" do
        board = Board.new
        white_pawn = Piece.new(:pawn, :white, [0,0], board)
        expect(white_pawn.icon).to eq(Chess.icons[:white][:pawn])
      end

    end

    context "when black pawn" do

      it "should build moves" do
        board = Board.new
        pawn = Piece.new(:pawn, :black, [7,0], board)
        expect(pawn.moves.length).to be > 0
      end

      it "should grab proper icon" do
        board = Board.new
        pawn = Piece.new(:pawn, :black, [0,0], board)
        expect(pawn.icon).to eq(Chess.icons[:black][:pawn])
      end

    end
  end

  describe "#build_moves" do

    context "when white king" do

      context "when piece is at bottom left" do
        it "moves.length should be 3" do
          board = Board.new
          white_king = Piece.new(:king, :white, [0,0], board)
          expect(white_king.moves.length).to be 3
        end
      end

      context "when piece is at top left" do
        it "moves.length should be 3" do
          board = Board.new
          white_king = Piece.new(:king, :white, [7,0], board)
          expect(white_king.moves.length).to be 3
        end
      end

      context "when piece is at top right" do
        it "moves.length should be 3" do
          board = Board.new
          white_king = Piece.new(:king, :white, [7,7], board)
          expect(white_king.moves.length).to be 3
        end
      end

      context "when piece is at bottom right" do
        it "moves.length should be 3" do
          board = Board.new
          white_king = Piece.new(:king, :white, [0,7], board)
          expect(white_king.moves.length).to be 3
        end
      end

      context "when piece is at center (d4)" do
        it "moves.length should be 8" do
          board = Board.new
          white_king = Piece.new(:king, :white, [3,3], board)
          expect(white_king.moves.length).to be 8
        end
      end

    end

    context "when white pawn at starting line" do
      context "when at 0" do
        it "moves.length should return 2" do
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,0], board)
          expect(white_pawn.moves.length).to eq(2)
        end
      end

      context "when at 1" do
        it "moves.length should return 2" do
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,1], board)
          expect(white_pawn.moves.length).to eq(2)
        end
      end

      context "when at 2" do
        it "moves.length should return 2" do
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,2], board)
          expect(white_pawn.moves.length).to eq(2)
        end
      end

      context "when at 3" do
        it "moves.length should return 2" do
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,3], board)
          expect(white_pawn.moves.length).to eq(2)
        end
      end

      context "when at 4" do
        it "moves.length should return 2" do
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,4], board)
          expect(white_pawn.moves.length).to eq(2)
        end
      end

      context "when at 5" do
        it "moves.length should return 2" do
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,5], board)
          expect(white_pawn.moves.length).to eq(2)
        end
      end

      context "when at 6" do
        it "moves.length should return 2" do
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,6], board)
          expect(white_pawn.moves.length).to eq(2)
        end
      end

      context "when at 7" do
        it "moves.length should return 2" do
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,7], board)
          expect(white_pawn.moves.length).to eq(2)
        end
      end

    end

    context "when black pawn at starting line" do
      context "when at 0" do
        it "moves.length should return 2" do
          board = Board.new
          black_pawn = Piece.new(:pawn, :black, [6,0], board)
          expect(black_pawn.moves.length).to eq(2)
        end
      end

      context "when at 1" do
        it "moves.length should return 2" do
          board = Board.new
          black_pawn = Piece.new(:pawn, :black, [6,1], board)
          expect(black_pawn.moves.length).to eq(2)
        end
      end

      context "when at 2" do
        it "moves.length should return 2" do
          board = Board.new
          black_pawn = Piece.new(:pawn, :black, [6,2], board)
          expect(black_pawn.moves.length).to eq(2)
        end
      end

      context "when at 3" do
        it "moves.length should return 2" do
          board = Board.new
          black_pawn = Piece.new(:pawn, :black, [6,3], board)
          expect(black_pawn.moves.length).to eq(2)
        end
      end

      context "when at 4" do
        it "moves.length should return 2" do
          board = Board.new
          black_pawn = Piece.new(:pawn, :black, [6,4], board)
          expect(black_pawn.moves.length).to eq(2)
        end
      end

      context "when at 5" do
        it "moves.length should return 2" do
          board = Board.new
          black_pawn = Piece.new(:pawn, :black, [6,5], board)
          expect(black_pawn.moves.length).to eq(2)
        end
      end

      context "when at 6" do
        it "moves.length should return 2" do
          board = Board.new
          black_pawn = Piece.new(:pawn, :black, [6,6], board)
          expect(black_pawn.moves.length).to eq(2)
        end
      end

      context "when at 7" do
        it "moves.length should return 2" do
          board = Board.new
          black_pawn = Piece.new(:pawn, :black, [6,7], board)
          expect(black_pawn.moves.length).to eq(2)
        end
      end

    end   
    
  end

end