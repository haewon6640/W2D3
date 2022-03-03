require('byebug')
class ComputerPlayer
    attr_reader :mark
    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        # debugger
        chosen = legal_positions.sample(1)
        p @mark.to_s + chosen[0].to_s
        chosen[0]
    end

end
