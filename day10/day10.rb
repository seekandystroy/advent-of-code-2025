# frozen_string_literal: true

module Day10
  # represent the lights as bits, toggles as masks
  # bitwise exclusive or (^ in ruby) is the toggling
  def self.part1
    lights = File.readlines('day10/test_input.txt', chomp: true)
                 .map do |line|
                   line = line.split[0..-2]
                   num_lights = line[0].size - 2
                   [symbols_to_bin(line[0])] + line[1..].map { |toggle| toggle_to_bin(toggle, num_lights) }
                 end

    lights.sum { |light| num_presses_needed(light) }
  end

  def self.symbols_to_bin(symbols)
    symbols.chars[1..-2]
           .map { |symbol| symbol == '#' ? '1' : '0' }
           .join
           .to_i(2)
  end

  def self.toggle_to_bin(toggle, num_lights)
    positions = toggle[1..-2].split(',').map(&:to_i)

    arr = Array.new(num_lights) { 0 }
    positions.each { |pos| arr[pos] = 1 }
    arr.join.to_i(2)
  end

  def self.num_presses_needed(light)
    goal = light[0]
    buttons = light[1..]

    num_presses = 0
    found_solution = false
    until found_solution
      num_presses += 1
      buttons.repeated_combination(num_presses) do |combo|
        result = combo.reduce(0, &:^)
        found_solution = result == goal

        break if found_solution
      end
    end

    num_presses
  end

  private_class_method :symbols_to_bin
  private_class_method :toggle_to_bin
  private_class_method :num_presses_needed
end
