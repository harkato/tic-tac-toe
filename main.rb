class Board
  attr_accessor :board, :current_player
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    @current_player = 'X'
  end

  def print_board
    puts '  1 2 3'
    @board.each_with_index do |row, index|
      print "#{index + 1} "
      row.each_with_index do |cell, cell_index|
        print "#{cell}#{cell_index == 2 ? '' : '|'}"
      end
      puts
      puts '  ----- ' unless index == 2
    end
  end

  def play(row, column)
    if row.between?(0, 2) && column.between?(0, 2) && @board[row][column] == ' '
      @board[row][column] = @current_player
      @current_player = @current_player == 'X' ? 'O' : 'X'
      true
    else
      false
    end
  end

  def check_winner
    # Row check
    @board.each do |row|
      return row[0] if row.uniq.length == 1 && row[0] != ' '
    end

    # Column check
    (0..2).each do |column|
      column_values = [@board[0][column], @board[1][column], @board[2][column]]
      return column_values[0] if column_values.uniq.length == 1 && column_values[0] != ' '
    end

    # Diagonal check
    diagonal1 = [@board[0][0], @board[1][1], @board[2][2]]
    diagonal2 = [@board[0][2], @board[1][1], @board[2][0]]

    return diagonal1[0] if diagonal1.uniq.length == 1 && diagonal1[0] != ' '
    return diagonal2[0] if diagonal2.uniq.length == 1 && diagonal2[0] != ' '

    nil
  end
end

# Set game
board = Board.new
winner = nil

until winner || board.board.flatten.none?(' ')
  board.print_board
  puts "Current player: #{board.current_player}"
  print 'Choose a row and a column (example, 1 2): '
  row, column = gets.chomp.split.map(&:to_i)
  if board.play(row - 1, column - 1)
    winner = board.check_winner
  else
    puts 'Invalid play. Try again'
  end
end

board.print_board

if winner
  puts "Player #{winner} wins!"
else
  puts 'Draw!'
end
