# frozen_string_literal: true

module Day05
  def self.part1
    file = File.new('day05/test_input.txt')
    ranges = ranges_from_file(file)
    ids = file.readlines.map(&:to_i)

    ids.count { |id| ranges.any? { |range| range.cover?(id) } }
  end

  def self.ranges_from_file(file)
    ranges = []

    line = file.gets(chomp: true)
    until line.empty?
      be = line.match(/(\d+)-(\d+)/)
      b = be[1].to_i
      e = be[2].to_i
      ranges << (b..e)

      line = file.gets(chomp: true)
    end

    ranges
  end

  private_class_method :ranges_from_file
end
