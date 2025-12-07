# frozen_string_literal: true

module Day07
  def self.part1
    manifold = File.readlines('day07/test_input.txt', chomp: true).map(&:chars)

    startcol = manifold[0].index('S')
    max_idx = manifold[0].size - 1
    next_beams = [startcol]
    manifold[1..].reduce(0) do |splits, line|
      next_beams = next_beams.flat_map do |col|
        next if col < 0 || col > max_idx

        if line[col] == '^'
          splits += 1
          [col - 1, col + 1]
        else
          col
        end
      end.uniq

      splits
    end
  end

  def self.part2
    manifold = File.readlines('day07/test_input.txt', chomp: true).map(&:chars)

    startcol = manifold[0].index('S')
    1 + timelines_dfs(manifold, [1, startcol], {})
  end

  def self.timelines_dfs(manifold, position, visited)
    row, col = position
    return 0 if row == manifold.size - 1

    timelines = visited[position]
    return timelines unless timelines.nil?

    timelines = if manifold[row][col] == '^'
                  1 + timelines_dfs(manifold, [row + 1, col - 1], visited) +
                    timelines_dfs(manifold, [row + 1, col + 1], visited)
                else
                  timelines_dfs(manifold, [row + 1, col], visited)
                end

    # ruby (kinda) passes by reference, visited doesn't need to be returned
    visited[position] = timelines
  end

  private_class_method :timelines_dfs
end
