# frozen_string_literal: true

module Day03
  def self.part1
    File.readlines('day03/test_input.txt')
        .map { |line| joltage(line) }
        .sum
  end

  def self.part2
    File.readlines('day03/test_input.txt')
        .map { |line| joltage(line, 12) }
        .sum
  end

  def self.joltage(line, n = 2)
    nums = line.chomp.chars.map(&:to_i)
    max_idx = nums.size - 1
    joltage = 0
    ptr = 0

    i = 1
    while i <= n
      check_slice = nums[ptr..(max_idx - n + i)]
      max = check_slice.max
      ptr += check_slice.index(max) + 1
      joltage += max * (10**(n - i))

      i += 1
    end

    joltage
  end

  # Initial solution used to solve part 1, keeping for history
  def self.joltage_with_ptrs(line)
    nums = line.chomp.chars.map(&:to_i)
    frst_indices = Array.new(10)
    scnd_indices = Array.new(10)

    i = 0
    until i == nums.size
      ri = nums.size - 1 - i
      cur = nums[i]
      rcur = nums[ri]

      frst_indices[cur] = i unless frst_indices[cur]
      scnd_indices[rcur] = ri unless scnd_indices[rcur]

      i += 1
    end

    joltage_from_indices(frst_indices, scnd_indices)
  end

  def self.joltage_from_indices(frst_indices, scnd_indices)
    i = 9
    until i == 0
      idx_frst = frst_indices[i]

      unless idx_frst.nil?
        j = 9
        until j == 0
          idx_scnd = scnd_indices[j]
          return (i * 10) + j if !idx_scnd.nil? && idx_scnd > idx_frst

          j -= 1
        end
      end
      i -= 1
    end
  end

  private_class_method :joltage
  private_class_method :joltage_with_ptrs
  private_class_method :joltage_from_indices
end
