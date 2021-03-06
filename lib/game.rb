require 'pry'
class Game

attr_accessor :board, :player_1, :player_2, :cells, :token

  WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # bottom row
  [0,3,6], # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [2,4,6], # right diagonal
  [0,4,8] # left diagonal
]
  # def initialize(player_1 = Players::Computer.new("X"), player_2 = Players::Computer.new("O"),board = Board.new)
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"),board = Board.new)
  @player_1 = player_1
  @player_2 = player_2
  @board = board
  #binding.pry
  end

  def current_player
    #binding.pry
    #@board.cells[4]

    # @board.turn_count.cells[3] = player_1.token

    if @board.turn_count.even?
      player_1
    else
      player_2
    end
    # binding.pry
  end

  def won?

    winning = WIN_COMBINATIONS.find do |combo|
      combo.all?{|cell| board.cells[cell] == player_1.token } || combo.all?{ |cell| board.cells[cell] ==  player_2.token}
      #binding.pry
    end
  end

  def draw?
   !won? && board.full?

  end

  def over?
    won? || draw?
  end

  def winner
    if won?
       board.cells[won?[0]]
     else
       return nil
     end
  end

  def turn
    puts "Please Player #{current_player.token} enter 1-9:"
    player = current_player
    player_move = player.move(board)
    if board.valid_move?(player_move)
      board.update(player_move, player)
      board.display
    else
       turn
   end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts 'Cat\'s Game!'
    end
  end

  # def start
  #   puts "Welcome to TicTacToe CLI!"
  #   puts "Please enter 1-9:"
  #
  #
  #   puts "Play Again? y/n"
  # end

end
