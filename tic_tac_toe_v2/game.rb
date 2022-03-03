require_relative('board')
require_relative('human_player')

class Game
  def initialize(*marks)
    @players = Array.new(0)
    marks.each do |mark|
      @players << HumanPlayer.new(mark)
    end
    @board = Board.new(3)
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
        @board.place_mark(@current_player.get_position, @current_player.mark)
      rescue StandardError => e
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
