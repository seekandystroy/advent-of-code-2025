# frozen_string_literal: true

module Day04
  def self.part1
    grid = grid_from_file(File.new('day04/input.txt'))

    accessible_rolls(grid).size
  end

  def self.part2
    grid = grid_from_file(File.new('day04/input.txt'))

    count = 0
    rolls = accessible_rolls(grid)
    until rolls.size == 0
      count += rolls.size

      rolls.each { |roll| grid[roll.first][roll.last] = '.' }
      rolls = accessible_rolls(grid)
    end

    count
  end

  def self.grid_from_file(file)
    grid = []

    line = file.gets(chomp: true)
    until line.nil?
      grid << line.chars
      line = file.gets(chomp: true)
    end

    grid
  end

  def self.accessible_rolls(grid)
    rolls = []
    row = 0
    col = 0

    while row < grid.size
      col = 0
      while col < grid[row].size
        rolls << [row, col] if grid[row][col] == '@' && adjacent_rolls(grid, row, col) < 4

        col += 1
      end
      row += 1
    end

    rolls
  end

  def self.adjacent_rolls(grid, row, col)
    count = 0
    rows = grid.size
    cols = grid[0].size

    count += 1 if (row > 0) && grid[row - 1][col] == '@'
    count += 1 if row > 0 && col > 0 && grid[row - 1][col - 1] == '@'
    count += 1 if row > 0 && col < cols - 1 && grid[row - 1][col + 1] == '@'
    count += 1 if (row < rows - 1) && grid[row + 1][col] == '@'
    count += 1 if (row < rows - 1) && col > 0 && grid[row + 1][col - 1] == '@'
    count += 1 if (row < rows - 1) && col < cols - 1 && grid[row + 1][col + 1] == '@'
    count += 1 if col > 0 && grid[row][col - 1] == '@'
    count += 1 if col < cols - 1 && grid[row][col + 1] == '@'

    count
  end

  private_class_method :grid_from_file
  private_class_method :accessible_rolls
  private_class_method :adjacent_rolls
end
