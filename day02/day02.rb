# frozen_string_literal: true

module Day02
  def self.part1
    File.read('day02/test_input.txt')
        .split(',')
        .inject(0) do |acc, range|
          match = range.match(/(\d+)-(\d+)/)
          s = match[1]
          e = match[2]

          (s..e).each do |id|
            acc += id.to_i if id.match?(/\A(\d+)\1\Z/)
          end

          acc
        end
  end
end
