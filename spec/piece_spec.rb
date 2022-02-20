#spec/piece_spec.rb

require_relative "../lib/piece"
require_relative "../lib/board"

describe Piece do

  describe "#build_moves" do

    context "when white pawn is at starting line" do


      it "all should have 2 moves" do

        lengths = []

        for i in 0..7
          board = Board.new
          white_pawn = Piece.new(:pawn, :white, [1,i], board)
          
          white_pawn.build_moves
          #p white_pawn.moves
          lengths << white_pawn.moves.length
        end
        
        expect(lengths.uniq.length).to eq(1)
        expect(lengths.uniq[0]).to eq(2)

      end
  

    end

  end

end