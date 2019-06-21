require './tube_line.rb'

class LondonTube
  attr_reader :coordinates, :route_links

  def initialize(tube_lines)
    @coordinates =
      tube_lines.each_with_object({}) do |tl, h|
        h.merge!(Tubeline.new(tl).stations_with_stop_point_reference)
      end
    @route_links =
      tube_lines.each_with_object([]) do |tl, a|
        a << Tubeline.new(tl).routes_links
      end.flatten
  end
end
