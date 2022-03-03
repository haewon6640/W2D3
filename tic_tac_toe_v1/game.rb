require_relative('board')
require_relative('human_player')

class Game
  def initialize(player_1_mark, player_2_mark)
    @player1 = HumanPlayer.new(player_1_mark)
    @player2 = HumanPlayer.new(player_2_mark)
    @board = Board.new(3)
    @current_player = @player1
  end

  def switch_turn
    @current_player = @current_player == @player2 ? @player1 : @player2
  end

  def play
    while @board.empty_positions?
      @board.print
      begin
        @board.place_mark(@current_player.get_position, @current_player.mark)
      rescue StandardError => e
        p e
        p 'That position is not available.'
        retry
      end
      if @board.win?(@player1.mark)
        p 'Victory!'
        return true
      end
      switch_turn
    end
    p 'Draw'
  end
end
