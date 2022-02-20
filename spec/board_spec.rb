#spec/board_spec.rb

# require_relative "../lib/board"
# require_relative "../lib/piece"

# describe Board do

#   subject(:board) { described_class.new() }

#   describe "#print_moves_for" do
    
#     context 'white pawn' do

#       context 'at 1,0' do
#         it 'should show 2,0 and 3,0 as moves' do
          
#           w_pawn = Piece.new(:pawn, :white, [1,0], board)
#           board.place_in(w_pawn) # automatically updates board on all pieces

#           piece = board.at([1,0])
#           piece.build_moves
#           expect(piece.moves).to eq([[2,0],[3,0]])
          
#         end

#         it 'should show moves positions as red on @temp' do
#           board.print_moves_for("a2")
          
#           p board.temp[2][0].to_s
#           p board.temp[3][0].to_s
#           #p String.colors.find{|x| .colorize(x) === board.temp[2][0].to_s}
#         end

        

#       end

#     end

#   end
# end