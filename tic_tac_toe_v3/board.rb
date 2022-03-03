require('byebug')
class Board

    def initialize(n)
        @grid = Array.new(n) {['_']*n}
    end

    def valid?(position)
        position[0] < @grid.length && position[1] < @grid.length
    end

    def empty?(position)
        @grid[position[0]][position[1]] == '_'
    end

    def place_mark(position, mark)
        raise "Not a valid position" if !valid?(position)
        raise "That position is already filled!" if !empty?(position)
        @grid[position[0]][position[1]] = mark
    end

    def print
        @grid.each {|row| puts row.join(" ")}
    end

    def win_row?(mark)
        @grid.any? {|row| row.all?{|val| val == mark}}
    end

    def win_col?(mark)
        @grid.transpose.any? {|row| row.all? {|val| val == mark}}
    end

    def win_diagonal?(mark)
        return true if (0...@grid.length).all? {|i| @grid[i][i] == mark}
        (0...@grid.length).each do |i|
            return false if @grid[i][@grid.length-i-1] != mark
        end
        true
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        (0...@grid.length).each do |i|
            (0...@grid.length).each do |j|
                return true if empty?([i,j])
            end
        end
        false
    end

    def legal_positions
        positions = Array.new(0)
        @grid.each_index do |i|
            @grid[i].each_index do |j|
                positions << [i,j] if @grid[i][j] == '_'
            end
        end
        positions
    end
end
