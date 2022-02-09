require 'colorize'

class Board
  
  def initialize
    @data = Array.new(8) { Array.new(8, "-") }
    @temp = []
  end

  def update_board_on_pieces
    @data.each do |row|
      row.each do |item|
        if item == "-"
          next
        else
          item.board = self
        end
      end
    end
  end

  def print_board

    top = "   a b c d e f g h\n"
    rows = ""

    @data.each_index do |i|
      r = 8-i
      j = r - 1
      rows += "#{r}| #{@data[j][0]} #{@data[j][1]} #{@data[j][2]} #{@data[j][3]} #{@data[j][4]} #{@data[j][5]} #{@data[j][6]} #{@data[j][7]} |#{r}\n"
    end

    out = top + rows + top
    puts out

  end

  def print_temp

    top = "   a b c d e f g h\n"
    rows = ""

    @temp.each_index do |i|
      r = 8-i
      j = r - 1
      rows += "#{r}| #{@temp[j][0]} #{@temp[j][1]} #{@temp[j][2]} #{@temp[j][3]} #{@temp[j][4]} #{@temp[j][5]} #{@temp[j][6]} #{@temp[j][7]} |#{r}\n"
    end

    out = top + rows + top
    puts out

  end

  def boardpos_to_arraypos(board_pos)

    if board_pos.length != 2 || !board_pos[0].match?(/^[a-h]$/) || !board_pos[1].match?(/^[1-8]$/)
      return nil
    end

    x = board_pos[1].to_i - 1
    y = letter_pos_to_data_pos(board_pos[0])
    return [x, y]
  
  end

  def validate_boardpos_string(board_pos)

    if board_pos.length != 2 || !board_pos[0].match?(/^[a-h]$/) || !board_pos[1].match?(/^[1-8]$/)
      return false
    else
      return true
    end

  end

  def validate_given_boardpos_to_options(board_pos, options)

    datapos = boardpos_to_arraypos(board_pos)
    if options.include?(datapos)
      true
    else
      false
    end

  end

  def print_moves_for(board_pos)

    # converts boardpos to arraypos
    real_pos = boardpos_to_arraypos(board_pos)

    # exits if position given is not a piece
    if @data[real_pos[0]][real_pos[1]] == "-"
      return "error"
    end

    # makes a deep copy of @data in @temp
    @temp = @data.map(&:clone)

    # update the selected piece moves
    @temp[real_pos[0]][real_pos[1]].build_moves
    
    @temp[real_pos[0]][real_pos[1]].moves.each do |pos|
      
      # check if space is available

      if @temp[pos[0]][pos[1]] != "-"
        if @temp[pos[0]][pos[1]].color_sym == @temp[real_pos[0]][real_pos[1]].color_sym
          @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.blue
        else
          @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.red
        end
      else
        @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.red
      end

      # OLD
      # begin
      #   if @temp[pos[0]][pos[1]] != "-"
      #     if @temp[pos[0]][pos[1]].color_sym == @temp[real_pos[0]][real_pos[1]].color_sym
      #       @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.blue
      #     else
      #       @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.red
      #     end
      #   else
      #     @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.red
      #   end
      # rescue => exception
      #   # ??
      # end
    
    end

    # highlight selected piece
    @temp[real_pos[0]][real_pos[1]] = @temp[real_pos[0]][real_pos[1]].to_s.yellow

    # print board
    print_temp

  end

  def at(pos)
    @data[pos[0]][pos[1]]
  end

  def move(old_boardpos, new_boardpos)
    
    # update board on all pieces
    update_board_on_pieces

    # grab selected piece
    old_datapos = boardpos_to_arraypos(old_boardpos)
    piece = at(old_datapos)
    
    # remove piece from play
    @data[old_datapos[0]][old_datapos[1]] = "-"

    # set piece new position
    new_datapos = boardpos_to_arraypos(new_boardpos)
    piece.position = new_datapos

    # set piece back into play
    @data[new_datapos[0]][new_datapos[1]] = piece

    # update all boards
    update_board_on_pieces

    # used to check if board updates on all pieces correctly.
    #@data[new_datapos[0]][new_datapos[1]].board.print_board

    print_board

  end

  def place_in(piece)
    @data[piece.position[0].to_i][piece.position[1].to_i] = piece
  end

  private

  def letter_pos_to_data_pos(char)
    case char
      when "a"
        return 0
      when "b"
        return 1
      when "c"
        return 2
      when "d"
        return 3
      when "e"
        return 4
      when "f"
        return 5
      when "g"
        return 6
      when "h"
        return 7
    end
  end

end