# frozen_string_literal: true

module Day06
  def self.part1
    file = File.new('day06/test_input.txt')
    ops_nums = parse_ops_nums(file)

    ops_nums.sum do |problem|
      op = problem.pop

      if op == '+'
        problem.sum
      else
        problem.reduce(&:*)
      end
    end
  end

  def self.parse_ops_nums(file)
    ops_nums = file.gets.split.map { |snum| [snum.to_i] }

    line = file.gets
    while line.match?(/(\d+\s+)+/)
      line.split.each_with_index { |snum, i| ops_nums[i] << snum.to_i }
      line = file.gets
    end

    line.split.each_with_index { |op, i| ops_nums[i] << op }

    ops_nums
  end

  private_class_method :parse_ops_nums
end
