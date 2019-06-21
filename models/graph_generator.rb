class GraphGenerator

  def initialize(tube:, type:, file_name:)
    @tube = tube
    @g = GraphViz.new( :G, :type => type)
    @file_name = file_name
    @existing_nodes = []
    @existing_edges = []
  end

  def generate!
    @tube.lines_routes_links.each do |rl|
      from = @tube.lines_stations_with_stop_point_reference.fetch(rl[:from])
      to = @tube.lines_stations_with_stop_point_reference.fetch(rl[:to])

      unless node_exists?(from)
        @g.add_nodes(from)
        @existing_nodes << from
      end

      unless node_exists?(to)
        @g.add_nodes(to)
        @existing_nodes << to
      end

      unless edge_exists?(from, to)
        @g.add_edges(from, to)
        @existing_edges << { from: from, to: to }
      end
    end

    @g.output(:png => @file_name)
  end

  private

  def node_exists?(node)
    @existing_nodes.include?(node)
  end

  def edge_exists?(from, to)
    @existing_edges.any? { |e| e[:from] == from && e[:to] == to }
  end
end

