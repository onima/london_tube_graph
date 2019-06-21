require 'nokogiri'
require 'ruby-graphviz'
require 'pry'
require './london_tube.rb'

tube_lines =
  [
    "./londonmetro/jubilee.xml",
    "./londonmetro/northern.xml",
    "./londonmetro/bakerloo.xml",
    "./londonmetro/central.xml",
    "./londonmetro/circle.xml",
    "./londonmetro/district.xml",
    "./londonmetro/hammersmith.xml",
    "./londonmetro/metropolitan.xml",
    "./londonmetro/picadilly.xml",
    "./londonmetro/victoria.xml",
    "./londonmetro/waterloo.xml"
  ]

london_tube = LondonTube.new(tube_lines)

g = GraphViz.new( :G, :type => :digraph)

existing_nodes = []
existing_edges = []

london_tube.lines_routes_links.each do |rl|
  from = london_tube.lines_stations_with_stop_point_reference.fetch(rl[:from])
  to = london_tube.lines_stations_with_stop_point_reference.fetch(rl[:to])

  unless existing_nodes.include?(from)
    g.add_nodes(from)
    existing_nodes << from
  end
  unless existing_nodes.include?(to)
    g.add_nodes(to)
    existing_nodes << to
  end

  unless existing_edges.any? { |e| e[:from] == from && e[:to] == to }
    g.add_edges(from, to)
    existing_edges << { from: from, to: to }
  end
end

g.output(:png => "london_tube.png")
