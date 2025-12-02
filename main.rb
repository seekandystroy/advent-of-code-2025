# frozen_string_literal: true

require_relative('day01/day01')

puts case ARGV[0]
     when '0101'
       Day01.part1
     when '0102'
       Day01.part2
     else
       'Please choose a day and part to run, in the format DDPP.'
     end
