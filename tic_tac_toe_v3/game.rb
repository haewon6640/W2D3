require_relative('board')
require_relative('human_player')
require_relative('computer_player')

class Game
  def initialize(n, hash)
    @players = Array.new(0)
    hash.each do |mark,robot|
      @players << HumanPlayer.new(mark) if !robot
      @players << ComputerPlayer.new(mark) if robot
    end
    @board = Board.new(n)
    @current_player = @players[0]
    @playerIndex = 0
  end

  def rotate!
    @playerIndex+=1 
    @playerIndex %= @players.length
    @current_player = @players[@playerIndex]
  end

  def play
    while @board.empty_positions?
      @board.print
      begin
        @board.place_mark(@current_player.get_position(@board.legal_positions), @current_player.mark)
      rescue StandardError => e
        p e
        p 'That position is not available.'
        retry
      end
      if @board.win?(@current_player.mark)
        p 'Victory!'
        return true
      end
      rotate!
    end
    p 'Draw'
  end
end
