require_relative 'chess'
require_relative 'board'
require_relative 'game'

class Piece 

  attr_accessor :type_sym, :color_sym, :position, :icon, :moves, :board

  def initialize(type_sym, color_sym, position, board)
    @type_sym = type_sym
    @color_sym = color_sym
    @position = position
    @icon = Chess.icons[@color_sym][@type_sym]
    @board = board

    @moves = []
    build_moves
  end

  # def delete_moves_that_cause_self_check
  #   # to_be_deleted = []
  #   # starting_board = @board.data.map(&:clone)
  #   # @moves.each do |pos|
  #   #   #@board.arraypos_to_boardpos(@position)
  #   #   @board.move(@board.arraypos_to_boardpos(@position), @board.arraypos_to_boardpos(pos))
  #   #   # check each enemy piece to see if alied king is being attacked.
  #   #   if Game.king_in_check?(@color_sym, @board)
  #   #     to_be_deleted << pos
  #   #   end
  #   #   @board = starting_board.map(&:clone) # reset @board simulation
  #   # end
  #   # to_be_deleted.each { |pos| @moves.delete(pos) }

  #   to_be_deleted = []
  #   sim_board = Board.new(@board)
  #   #sim_board.place_in(self)

  #   # for each position do a simulation...
  #   @moves.each do |pos|
  #     piece_boardpos = sim_board.arraypos_to_boardpos(@position)
  #     target_boardpos = sim_board.arraypos_to_boardpos(pos)
  #     sim_board.move(piece_boardpos, target_boardpos)

  #     if Game.king_in_check?(@color_sym, sim_board)
  #       to_be_deleted << pos
  #     end
  #     sim_board = Board.new(@board) # reset board for next simulation
  #   end
  #   to_be_deleted.each { |pos| @moves.delete(pos) }

  # end

  def build_moves

    # reset moves
    @moves = []

    # build moves depending on type and color and position and board
    # this is probably going to be the longest case statement man has ever seen. lulz

    case @icon

    when Chess.icons[:white][:king], Chess.icons[:black][:king]

      # grabs all positions around the king's current position
      @moves << [@position[0] - 1, @position[1] + 1]
      @moves << [@position[0], @position[1] + 1]
      @moves << [@position[0] + 1, @position[1] + 1]
      @moves << [@position[0] - 1, @position[1]]
      @moves << [@position[0] + 1, @position[1]]
      @moves << [@position[0] - 1, @position[1] - 1]
      @moves << [@position[0], @position[1] - 1]
      @moves << [@position[0] + 1, @position[1] - 1]

      # delete out of bounds
      @moves.delete_if { |pos| pos[0] >= 8 || pos[0] < 0 || pos[1] >= 8 || pos[1] < 0 }

      # delete allies
      to_be_deleted = []
      @moves.each do |pos|
        if @board.at(pos).to_s == "-"
          next
        else
          if @color_sym == @board.at(pos).color_sym 
            to_be_deleted << pos
          end
        end
      end
      to_be_deleted.each { |pos| @moves.delete(pos) }

      # delete any moves that causes a self check...
      # ... tbc
      # delete_moves_that_cause_self_check
      # .. i've tried to code the solution here but it seems to mess everything up
      # i think the solution for this must be built in board.rb
      

    when Chess.icons[:white][:pawn]

      for i in 0..7
        if @position == [1, i]
          @moves << [2, i]
          @moves << [3, i]
        end
      end

      if @moves == [] && @board.at([@position[0] + 1, @position[1]]) == "-"
        @moves << [@position[0] + 1, @position[1]]
      end

      # pawn attack [white]
      if @board.at([@position[0] + 1, @position[1] + 1]) != "-"
        @moves << [@position[0] + 1, @position[1] + 1]
      end
      if @board.at([@position[0] + 1, @position[1] - 1]) != "-"
        @moves << [@position[0] + 1, @position[1] - 1]
      end

      @moves.delete_if { |pos| pos[0] >= 8 || pos[0] < 0 || pos[1] >= 8 || pos[1] < 0 }

    when Chess.icons[:black][:pawn]

      for i in 0..7
        if @position == [6, i]
          @moves << [5, i]
          @moves << [4, i]
        end
      end

      if @moves == [] && @board.at([@position[0] - 1, @position[1]]) == "-"
        @moves << [@position[0] - 1, @position[1]]
      end

      # pawn attack [black]
      if @board.at([@position[0] - 1, @position[1] - 1]) != "-"
        @moves << [@position[0] - 1, @position[1] - 1]
      end
      if @board.at([@position[0] - 1, @position[1] + 1]) != "-"
        @moves << [@position[0] - 1, @position[1] + 1]
      end

      @moves.delete_if { |pos| pos[0] >= 8 || pos[0] < 0 || pos[1] >= 8 || pos[1] < 0 }

    when Chess.icons[:white][:rook], Chess.icons[:black][:rook]

      # north
      for i in 1..7
        pos = [position[0] + i, @position[1]]
        # range check
        if pos[0] >= 8
          next
        end
        if @board.at(pos).to_s != "-"
          @moves << pos
          break
        else
          @moves << pos
        end
      end

      # east
      for j in 1..7
        pos = [position[0], @position[1] + j]
        # range check
        if pos[1] > 7
          next
        end
        if @board.at(pos).to_s != "-"
          @moves << pos
          break
        else
          @moves << pos
        end
      end

      # south
      for k in 1..7
        pos = [position[0] - k, @position[1]]
        # range check
        if pos[0] < 0
          next
        end
        if @board.at(pos).to_s != "-"
          @moves << pos
          break
        else
          @moves << pos
        end
      end

      # west
      for l in 1..7
        pos = [position[0], @position[1] - l]
        # range check
        if pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-"
          @moves << pos
          break
        else
          @moves << pos
        end
      end

      #p @moves

    when Chess.icons[:white][:knight], Chess.icons[:black][:knight]

      (0...8).each do |i|

        case i
        when 0
          @moves << [@position[0] + 1, @position[1] + 2]
        when 1
          @moves << [@position[0] + 1, @position[1] - 2]
        when 2
          @moves << [@position[0] - 1, @position[1] + 2]
        when 3
          @moves << [@position[0] - 1, @position[1] - 2]
        when 4
          @moves << [@position[0] + 2, @position[1] + 1]
        when 5
          @moves << [@position[0] - 2, @position[1] + 1]
        when 6
          @moves << [@position[0] + 2, @position[1] - 1]
        when 7
          @moves << [@position[0] - 2, @position[1] - 1]
        else
          puts 'error!'
        end

      end

      # remove any outlayers based on size of board
      marked = []
      @moves.each do |pos|
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          marked << pos
        end
      end
      @moves.delete_if { |move| marked.include?(move) }

    when Chess.icons[:white][:bishop], Chess.icons[:black][:bishop]

      # top right
      for i in 1..7
        pos = [@position[0] + i, @position[1] + i]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

      # top left
      for i in 1..7
        pos = [@position[0] + i, @position[1] - i]
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

      # bottom left
      for i in 1..7
        pos = [@position[0] - i, @position[1] - i]
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

      # bottom right
      for i in 1..7
        pos = [@position[0] - i, @position[1] + i]
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

    when Chess.icons[:white][:queen], Chess.icons[:black][:queen]

      # n
      for i in 1..7
        pos = [position[0] + i, @position[1]]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-"
          @moves << pos
          break
        else
          @moves << pos
        end
      end

      # ne
      for i in 1..7
        pos = [@position[0] + i, @position[1] + i]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

      # e
      for i in 1..7
        pos = [position[0], @position[1] + i]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-"
          @moves << pos
          break
        else
          @moves << pos
        end
      end

      # se
      for i in 1..7
        pos = [@position[0] - i, @position[1] + i]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

      # s
      for i in 1..7
        pos = [@position[0] - i, @position[1]]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

      # sw
      for i in 1..7
        pos = [@position[0] - i, @position[1] - i]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

      # w
      for i in 1..7
        pos = [@position[0], @position[1] - i]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

      # nw
      for i in 1..7
        pos = [@position[0] + i, @position[1] - i]
        # range check
        if pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
          next
        end
        if @board.at(pos).to_s != "-" # if piece is present at position...
          moves << pos
          break
        else
          moves << pos
        end
      end

    end

  end

  def to_s
    @icon
  end

end