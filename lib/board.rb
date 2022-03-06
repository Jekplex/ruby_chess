require 'colorize'

class Board
  
  attr_reader :data, :temp

  def initialize(board_template = nil)

    if board_template != nil
      @data = board_template.data.map(&:clone)
      @temp = []
    else
      @data = Array.new(8) { Array.new(8, "-") }
      @temp = []
    end
    
  end

  def update_board_and_moves_on_all_pieces
    
    update_board_for_all_pieces
    calc_moves_for_all_pieces
    
  end

  def update_board_for_all_pieces
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

  def arraypos_to_boardpos(array_pos)
    
    if array_pos.length != 2
      return nil
    end

    out_string = ""
    out_string += data_pos_to_letter_pos(array_pos[1]).to_s
    out_string += (array_pos[0] + 1).to_s
    #p out_string
    out_string

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

    update_board_for_all_pieces

    # converts boardpos to arraypos
    real_pos = boardpos_to_arraypos(board_pos)

    # exits if position given is not a piece
    if @data[real_pos[0]][real_pos[1]] == "-"
      return "error"
    end

    # update the selected piece moves
    @data[real_pos[0]][real_pos[1]].build_moves

    # makes a deep copy of @data in @temp
    @temp = @data.map(&:clone)

    # # update the selected piece moves
    # @temp[real_pos[0]][real_pos[1]].build_moves

    to_be_deleted = []

    og_moves = @data[real_pos[0]][real_pos[1]].moves

    # for all generated moves... # REMOVES ALL MOVES THAT CAUSES SELF CHECK
    @data[real_pos[0]][real_pos[1]].moves.each do |pos|
      
      # simulate each move
      # and if the move causes a self check, mark for deletion.

      # execute
      piece_boardpos = board_pos
      target_boardpos = arraypos_to_boardpos(pos)
      move_temp(piece_boardpos, target_boardpos)

      # the check
      if Game.king_in_check?(@color_sym, self)
        to_be_deleted << pos
      end

      # reset
      @temp = @data.map(&:clone) # reset board for next simulation
    
    end

    # OG MOVES IS A PATCH THAT SOMEHOW WORKS ¯\_(ツ)_/¯

    #p og_moves 
    @temp[real_pos[0]][real_pos[1]].moves = og_moves

    # delete all the moves that causes self checks
    to_be_deleted.each do |pos|
      @temp[real_pos[0]][real_pos[1]].moves.delete(pos)
    end

    #p @temp[real_pos[0]][real_pos[1]]


    # for all generated moves...
    @temp[real_pos[0]][real_pos[1]].moves.each do |pos|
      
      # check if space is available

      if @temp[pos[0]][pos[1]].to_s != "-"
        if @temp[pos[0]][pos[1]].color_sym == @temp[real_pos[0]][real_pos[1]].color_sym
          @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.blue
          #@temp[real_pos[0]][real_pos[1]].moves.delete(pos)
          to_be_deleted << pos
        else
          @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.red # enemy
        end
      else
        @temp[pos[0]][pos[1]] = @temp[pos[0]][pos[1]].to_s.red # free position
      end
    
    end

    # delete all the friendly positions so that player cannot kill allies
    to_be_deleted.each do |pos|
      @temp[real_pos[0]][real_pos[1]].moves.delete(pos)
    end

    # highlight selected piece
    @temp[real_pos[0]][real_pos[1]] = @temp[real_pos[0]][real_pos[1]].to_s.yellow

    # print board
    print_temp

  end

  def at(pos)
    @data[pos[0]][pos[1]]
  end

  def at_temp(pos)
    @temp[pos[0]][pos[1]]
  end

  def move(old_boardpos, new_boardpos)
    
    # update board on all pieces
    #update_board_and_moves_on_all_pieces

    # grab selected piece
    old_datapos = boardpos_to_arraypos(old_boardpos)
    piece = at(old_datapos)
    
    # remove piece from play
    @data[old_datapos[0]][old_datapos[1]] = "-"

    # set piece new position
    new_datapos = boardpos_to_arraypos(new_boardpos)
    piece.position = new_datapos

    # set piece back into play
    #@data[new_datapos[0]][new_datapos[1]] = piece
    place_in(piece)

    # update all boards
    #update_board_and_moves_on_all_pieces

    # used to check if board updates on all pieces correctly.
    #@data[new_datapos[0]][new_datapos[1]].board.print_board

    print_board

  end

  def move_temp(old_boardpos, new_boardpos)
    
    # update board on all pieces
    #update_board_and_moves_on_all_pieces

    # grab selected piece
    old_datapos = boardpos_to_arraypos(old_boardpos)
    piece = at_temp(old_datapos)
    
    # remove piece from play
    @temp[old_datapos[0]][old_datapos[1]] = "-"

    # set piece new position
    new_datapos = boardpos_to_arraypos(new_boardpos)
    piece.position = new_datapos

    # set piece back into play
    #@data[new_datapos[0]][new_datapos[1]] = piece
    place_in_temp(piece)

    # update all boards
    #update_board_and_moves_on_all_pieces

    # used to check if board updates on all pieces correctly.
    #@data[new_datapos[0]][new_datapos[1]].board.print_board

    #print_temp

  end

  def place_in(piece)
    @data[piece.position[0].to_i][piece.position[1].to_i] = piece
    update_board_and_moves_on_all_pieces
  end

  def place_in_temp(piece)
    @temp[piece.position[0].to_i][piece.position[1].to_i] = piece
    update_board_and_moves_on_all_pieces
  end

  def calc_moves_for_all_pieces
    for i in 0..7
      for j in 0..7
        if at([i, j]).to_s != "-" # if is piece
          at([i, j]).build_moves
        end
      end
    end
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

  def data_pos_to_letter_pos(num)

    case num
      when 0
        return "a"
      when 1
        return "b"
      when 2
        return "c"
      when 3
        return "d"
      when 4
        return "e"
      when 5
        return "f"
      when 6
        return "g"
      when 7
        return "h"
    end

  end

end