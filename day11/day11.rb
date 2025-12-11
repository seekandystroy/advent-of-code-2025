# frozen_string_literal: true

module Day11
  def self.part1
    nodes = File.open('day11/test_input.txt', chomp: true)
                .to_h do |line|
                  nodes = line.scan(/\w+/)
                  [nodes.first, nodes[1..]]
                end

    dfs_to_out(nodes, {})
  end

  def self.dfs_to_out(nodes, visited, cur_node = 'you')
    return 1 if cur_node == 'out'
    return visited[cur_node] if visited[cur_node]

    visited[cur_node] = nodes[cur_node].sum do |child|
      dfs_to_out(nodes, visited, child)
    end
  end

  private_class_method :dfs_to_out
end
