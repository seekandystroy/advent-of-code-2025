# frozen_string_literal: true

module Day05
  def self.part1
    file = File.new('day05/test_input.txt')
    ranges = ranges_from_file(file)
    ids = file.readlines.map(&:to_i)

    ids.count { |id| ranges.any? { |range| range.cover?(id) } }
  end

  def self.part2
    file = File.new('day05/test_input.txt')
    ranges = ranges_from_file(file)

    # Set ops are slow for very large ranges
    # Otherwise, the solution could be
    # ranges.map(&:to_set).reduce(&:merge).count

    reduce_to_disjoint_ranges(ranges).sum(&:size)
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

  def self.reduce_to_disjoint_ranges(ranges)
    prev_ranges = nil
    new_ranges = Array.new(ranges)

    until new_ranges == prev_ranges
      prev_ranges = Array.new(new_ranges)
      new_ranges = new_ranges.map do |range|
        new_ranges.reduce(range) do |r1, r2|
          new_range = merge_ranges(r1, r2)
          new_range || r1
        end
      end.uniq
    end

    new_ranges
  end

  def self.merge_ranges(r1, r2)
    return nil unless r1.overlap?(r2)

    be = (r1.minmax + r2.minmax).minmax
    (be[0])..(be[1])
  end

  private_class_method :ranges_from_file
  private_class_method :reduce_to_disjoint_ranges
  private_class_method :merge_ranges
end
