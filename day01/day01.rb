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

    zero_count
  end

  def self.part2
    ptr = 50
    zero_count = 0

    File.foreach('day01/test_input.txt') do |line|
      match = line.match(/([LR])(\d+)/)

      dir = match[1]
      amount = match[2].to_i

      ptr = if dir == 'L'
              zero_count += (ptr - 100 - amount) / -100
              zero_count -= 1 if ptr == 0 # when pointer is 0, the op above will be off by 1
              (ptr - amount - 100) % 100
            else
              zero_count += (ptr + amount) / 100
              (ptr + amount + 100) % 100
            end
    end

    zero_count
  end
end
