require 'nokogiri'
require 'ruby-graphviz'
require 'pry'
require './models/london_tube.rb'
require './models/graph_generator.rb'

GraphGenerator.new(tube: LondonTube.new, type: :digraph, file_name: 'london_tube_graph.png').generate!
