class HumanPlayer
    
    attr_reader :mark
    
    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        begin
            p "Enter the two positions with space between them like 1 2"
            position = gets.chomp.split(" ")
            position.map! {|val| val.to_i}
        rescue StandardError => error
            p "Please enter the positions in the correct format!"
            retry
        end
    end

end
