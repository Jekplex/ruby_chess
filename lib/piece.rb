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

    case @icon

    when Chess.icons[:white][:king], Chess.icons[:black][:king]

      @moves << [@position[0] - 1, @position[1] + 1]
      @moves << [@position[0], @position[1] + 1]
      @moves << [@position[0] + 1, @position[1] + 1]
      @moves << [@position[0] - 1, @position[1]]
      @moves << [@position[0] + 1, @position[1]]
      @moves << [@position[0] - 1, @position[1] - 1]
      @moves << [@position[0], @position[1] - 1]
      @moves << [@position[0] + 1, @position[1] - 1]

      @moves.delete_if { |pos| pos[0] >= 8 || pos[0] < 0 || pos[1] >= 8 || pos[1] < 0 }

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

    end

  end

  def to_s
    @icon
  end

end