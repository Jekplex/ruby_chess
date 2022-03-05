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
end