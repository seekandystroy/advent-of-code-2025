# frozen_string_literal: true

module Day03
  def self.part1
    File.readlines('day03/test_input.txt')
        .map { |line| joltage(line) }
        .sum
  end

  def self.joltage(line)
    chars = line.chomp.chars
    frst_indices = Array.new(10)
    scnd_indices = Array.new(10)

    i = 0
    until i == chars.size
      ri = chars.size - 1 - i
      cur = chars[i].to_i
      rcur = chars[ri].to_i

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
  private_class_method :joltage_from_indices
end
