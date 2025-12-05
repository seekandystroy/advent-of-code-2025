# frozen_string_literal: true

require_relative('day01/day01')
require_relative('day02/day02')
require_relative('day03/day03')
require_relative('day04/day04')
require_relative('day05/day05')

puts case ARGV[0]
     when '0101'
       Day01.part1
     when '0102'
       Day01.part2
     when '0201'
       Day02.part1
     when '0202'
       Day02.part2
     when '0301'
       Day03.part1
     when '0302'
       Day03.part2
     when '0401'
       Day04.part1
     when '0402'
       Day04.part2
     when '0501'
       Day05.part1
     when '0502'
       Day05.part2
     else
       'Please choose a day and part to run, in the format DDPP.'
     end
