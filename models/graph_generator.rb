class GraphGenerator

  def initialize(tube:, type:)
    @tube = tube
    @g = GraphViz.new( :G, :type => type)
    @existing_nodes = []
    @existing_edges = []
  end

  def generate!
    @tube.routes_links.each do |rl|
      from = @tube.stations_with_stop_point_reference.fetch(rl[:from])
      to = @tube.stations_with_stop_point_reference.fetch(rl[:to])

      unless @existing_nodes.include?(from)
        @g.add_nodes(from)
        @existing_nodes << from
      end
      unless @existing_nodes.include?(to)
        @g.add_nodes(to)
        @existing_nodes << to
      end

      unless @existing_edges.any? { |e| e[:from] == from && e[:to] == to }
        @g.add_edges(from, to)
        @existing_edges << { from: from, to: to }
      end
    end

    g.output(:png => "london_tube_graph.png")
  end
end

