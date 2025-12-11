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

  def self.part2
    nodes = File.open('day11/test_input2.txt', chomp: true)
                .to_h do |line|
                  nodes = line.scan(/\w+/)
                  [nodes.first, nodes[1..]]
                end

    paths_to_dac_no_fft   = dfs(nodes, { 'out' => 0, 'fft' => 0 }, 'svr', 'dac')
    paths_from_dac_to_fft = dfs(nodes, { 'out' => 0 }, 'dac', 'fft')
    paths_from_fft_to_out = dfs(nodes, { 'dac' => 0 }, 'fft', 'out')
    paths_to_fft_no_dac   = dfs(nodes, { 'out' => 0, 'dac' => 0 }, 'svr', 'fft')
    paths_from_fft_to_dac = dfs(nodes, { 'out' => 0 }, 'fft', 'dac')
    paths_from_dac_to_out = dfs(nodes, { 'fft' => 0 }, 'dac', 'out')

    (paths_to_dac_no_fft * paths_from_dac_to_fft * paths_from_fft_to_out) +
      (paths_to_fft_no_dac * paths_from_fft_to_dac * paths_from_dac_to_out)
  end

  def self.dfs_to_out(nodes, visited, cur_node = 'you')
    return 1 if cur_node == 'out'
    return visited[cur_node] if visited[cur_node]

    visited[cur_node] = nodes[cur_node].sum do |child|
      dfs_to_out(nodes, visited, child)
    end
  end

  def self.dfs(nodes, visited, cur_node = 'you', end_node = 'out')
    return 1 if cur_node == end_node
    return visited[cur_node] if visited[cur_node]

    visited[cur_node] = nodes[cur_node].sum do |child|
      dfs(nodes, visited, child, end_node)
    end
  end

  private_class_method :dfs_to_out
  private_class_method :dfs
end
