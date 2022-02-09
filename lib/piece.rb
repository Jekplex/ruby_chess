require_relative 'chess'
require_relative 'board'

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

  def build_moves

    # reset moves
    @moves = []

    # build moves depending on type and color and position and board
    
    # this is probably going to be the longest if statement man has ever seen. lulz

    if @icon == Chess.icons[:white][:king] || @icon == Chess.icons[:black][:king]

      @moves << [@position[0] - 1, @position[1] + 1]
      @moves << [@position[0], @position[1] + 1]
      @moves << [@position[0] + 1, @position[1] + 1]
      @moves << [@position[0] - 1, @position[1]]
      @moves << [@position[0] + 1, @position[1]]
      @moves << [@position[0] - 1, @position[1] - 1]
      @moves << [@position[0], @position[1] - 1]
      @moves << [@position[0] + 1, @position[1] - 1]

      @moves.delete_if { |pos| pos[0] >= 8 || pos[0] < 0 || pos[1] >= 8 || pos[1] < 0 }

    elsif @icon == Chess.icons[:white][:pawn]
      
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

    elsif @icon == Chess.icons[:black][:pawn]

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

    elsif @icon == Chess.icons[:black][:rook] || @icons == Chess.icons[:white][:rook]

      # top
      for i in 1..7

        pos = [position[0] + i, @position[1]]

        # range check
        if pos[0] >= 8
          break
        end

        if @board.at(pos) != "-"
          @moves << pos
          break
        else
          @moves << pos
        end

      end

      # # right
      # for i in 1..7

      #   pos = [position[0], @position[1] + i]

      #   if @board.at(pos).to_s != "-"
      #     @moves << pos
      #     break
      #   else
      #     @moves << pos
      #   end

      # end

      # # bottom
      # for i in 1..7

      #   pos = [position[0] - i, @position[1]]

      #   if @board.at(pos).to_s != "-"
      #     @moves << pos
      #     break
      #   else
      #     @moves << pos
      #   end

      # end

      # # left
      # for i in 1..7

      #   pos = [position[0], @position[1] - i]

      #   if @board.at(pos).to_s != "-"
      #     @moves << pos
      #     break
      #   else
      #     @moves << pos
      #   end

      # end

    end

  end

  def to_s
    @icon
  end

end
