require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player
    def initialize(n)
        @player = Player.new
        @board = Board.new(n)
        @remaining_misses = 10
    end
    
    def start_game
        @board.place_random_ships
        p @board.size/4
        @board.print
    end

    def lose?
        if @remaining_misses <= 0
            p 'you lose'
            return true
        end
        false
    end

    def win?
        if @board.num_ships == 0
            p 'you win'
            return true
        end
        false
    end
    
    def game_over?
        win? || lose?
    end

    def turn
        begin
            move = @player.get_move
            if !@board.attack(move)
                @remaining_misses-=1
            end    
        rescue StandardError => error
            p 'Enter a valid move!'
            retry
        end
        @board.print
        p @remaining_misses
    end

end
