# frozen_string_literal: true

module Day01
  def self.part1
    ptr = 50
    zero_count = 0

    File.foreach('day01/test_input.txt') do |line|
      match = line.match(/([LR])(\d+)/)

      dir = match[1]
      amount = match[2].to_i

      ptr = if dir == 'L'
              (ptr - amount - 100) % 100
            else
              (ptr + amount + 100) % 100
            end

      zero_count += 1 if ptr == 0
    end

    puts zero_count
  end
end
