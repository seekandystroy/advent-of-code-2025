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

  def self.part2
    file = File.new('day06/test_input.txt')
    ops_nums = parse_cephalopod_math(file)

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

  def self.parse_cephalopod_math(file)
    ops_nums = []

    char_lines = file.readlines.map(&:chars)
    ops = char_lines.pop

    cur_op_idx = 0
    next_op_idx = 0
    until ops[cur_op_idx].nil?
      next_op_idx += 1
      next_op_idx += 1 until ['*', '+', nil].include?(ops[next_op_idx])

      arguments = parse_numbers_from_slice_of_lines(char_lines, cur_op_idx, next_op_idx - 2)

      ops_nums << (arguments << ops[cur_op_idx])

      cur_op_idx = next_op_idx
    end

    ops_nums
  end

  def self.parse_numbers_from_slice_of_lines(char_lines, slice_begin, slice_end)
    char_lines.map { |line| line[slice_begin..slice_end] }
              .reduce do |num_slice, char_slice|
                num_slice.each_with_index do |num_string, i|
                  num_string << char_slice[i]
                end
              end
              .map(&:to_i)
  end

  private_class_method :parse_ops_nums
  private_class_method :parse_cephalopod_math
  private_class_method :parse_numbers_from_slice_of_lines
end
