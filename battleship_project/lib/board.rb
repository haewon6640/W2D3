class Board
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) { [:N] * n }
    @size = n * n
  end

  def [](position)
    @grid[position[0]][position[1]]
  end

  def []=(position, val)
    if @grid[position[0]][position[1]] != nil
      @grid[position[0]][position[1]] = val
    else 
      raise StandardError
    end
  end

  def num_ships
    count = 0
    @grid.each do |row|
      row.each do |val|
        count += 1 if val == :S
      end
    end
    count
  end

  def attack(position)
    if self[position] == :S
      self[position] = :H
      p 'You sunk my battleship!'
      return true
    end
    self[position] = :X
    false
  end

  def place_random_ships
    newArr = Array.new(@grid.length) { Array.new(@grid.length) }
    newArr.each_index do |i|
      newArr[i].each_index do |j|
        newArr[i][j] = i.to_s + ' ' + j.to_s
      end
    end
    numShips = @size / 4
    randomIndices = newArr.flatten.sample(numShips)
    randomIndices.each do |index|
      ind = index.split
      self[[ind[0].to_i, ind[1].to_i]] = :S
    end
  end

  def hidden_ships_grid
    newGrid = Array.new(@grid.length) { [:N] * @grid.length }
    @grid.each_index do |i|
        @grid[i].each_index do |j|
          newGrid[i][j] =:X if @grid[i][j] == :X
          newGrid[i][j] =:H if @grid[i][j] == :H
        end
    end
    newGrid
  end

  def self.print_grid(arr)
    arr.each do |row|
      puts row.join(" ")
    end
  end

  def cheat
    self.class.print_grid(@grid)
  end

  def print
    self.class.print_grid(hidden_ships_grid)
  end
end
