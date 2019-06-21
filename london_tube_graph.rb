require 'nokogiri'
require 'ruby-graphviz'
require 'pry'
require './tubeline.rb'
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

london_tube.route_links.each do |rl|
  from = london_tube.coordinates.fetch(rl[:from])
  to = london_tube.coordinates.fetch(rl[:to])
  g.add_nodes(from)
  g.add_nodes(to)
  g.add_edges(from, to)
end

g.output(:png => "london_tube.png")

#stations.each_with_index do |s, index|
#  if stations[index + 1]
#    g.add_edges(s.name, stations[index + 1].name)
#    g.add_edges(stations[index + 1].name, s.name)
#  end
#end


