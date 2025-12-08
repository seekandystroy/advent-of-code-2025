# frozen_string_literal: true

module Day08
  def self.part1
    boxes = File.readlines('day08/test_input.txt', chomp: true)
                .map { |line| line.scan(/\d+,?/).map(&:to_i) }

    distances = sorted_distances_between_boxes(boxes)
    circuits = connect_closest(distances, 10)

    circuits.values.map(&:size).sort.last(3).reduce(&:*)
  end

  def self.part2
    boxes = File.readlines('day08/test_input.txt', chomp: true)
                .map { |line| line.scan(/\d+,?/).map(&:to_i) }

    distances = sorted_distances_between_boxes(boxes)
    p1, p2 = connect_until_all_in_one(distances, boxes.size)

    p1[0] * p2[0]
  end

  def self.sorted_distances_between_boxes(boxes)
    distances = []

    boxes.combination(2) do |combo|
      distance = euclidean_distance(combo[0], combo[1])
      distances << [distance, combo[0], combo[1]]
    end

    distances.sort_by! { |dc| dc[0] }
  end

  def self.euclidean_distance(p1, p2)
    Math.sqrt(
      ((p1[0] - p2[0])**2) +
      ((p1[1] - p2[1])**2) +
      ((p1[2] - p2[2])**2)
    )
  end

  def self.connect_closest(distances, num)
    circuits = {}
    circuits_rindex = {}
    next_id = 0

    distances.first(num).each do |dc|
      p1 = dc[1]
      p2 = dc[2]
      circuit_p1_id = circuits_rindex[p1]
      circuit_p2_id = circuits_rindex[p2]

      next if !circuit_p1_id.nil? && circuit_p1_id == circuit_p2_id

      next_id = update_circuits_and_rindex(circuits, circuits_rindex, next_id, p1, p2)
    end

    circuits
  end

  def self.connect_until_all_in_one(distances, target_circuit_size)
    circuits = {}
    circuits_rindex = {}
    next_id = 0

    distances.each do |dc|
      p1 = dc[1]
      p2 = dc[2]
      circuit_p1_id = circuits_rindex[p1]
      circuit_p2_id = circuits_rindex[p2]

      next if !circuit_p1_id.nil? && circuits_rindex[p1] == circuit_p2_id

      next_id = update_circuits_and_rindex(circuits, circuits_rindex, next_id, p1, p2)

      return [p1, p2] if circuits.size == 1 && circuits.values[0].size == target_circuit_size
    end

    []
  end

  def self.update_circuits_and_rindex(circuits, circuits_rindex, next_id, p1, p2)
    circuit_p1_id = circuits_rindex[p1]
    circuit_p2_id = circuits_rindex[p2]

    new_circuit = if circuit_p1_id == circuit_p2_id
                    [p1, p2].to_set
                  else
                    circuit_p1 = circuits[circuit_p1_id] || Set.new
                    circuit_p2 = circuits[circuit_p2_id] || Set.new

                    circuits.delete(circuit_p1_id)
                    circuits.delete(circuit_p2_id)

                    circuit_p1 | circuit_p2 | [p1, p2]
                  end

    circuits[next_id] = new_circuit
    new_circuit.each { |pos| circuits_rindex[pos] = next_id }
    next_id += 1
  end

  private_class_method :sorted_distances_between_boxes
  private_class_method :euclidean_distance
  private_class_method :connect_closest
  private_class_method :connect_until_all_in_one
  private_class_method :update_circuits_and_rindex
end
