# frozen_string_literal: true

module Day09
  def self.part1
    tiles = File.readlines('day09/test_input.txt', chomp: true)
                .map { |line| line.scan(/(\d+),(\d+)/)[0].map(&:to_i) }

    max_area = 0
    tiles.combination(2) do |combo|
      x1 = combo[0][0]
      y1 = combo[0][1]
      x2 = combo[1][0]
      y2 = combo[1][1]

      area = ((x1 - x2).abs + 1) * ((y1 - y2).abs + 1)
      max_area = area if area > max_area
    end

    max_area
  end
end
