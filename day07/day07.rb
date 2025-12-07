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
end
