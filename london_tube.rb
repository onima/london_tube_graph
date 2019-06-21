require './tube_line.rb'

class LondonTube
  attr_reader :lines_stations_with_stop_point_reference, :lines_routes_links

  def initialize(tube_lines)
    @lines_stations_with_stop_point_reference =
      tube_lines.each_with_object({}) do |tl, h|
        h.merge!(Tubeline.new(tl).stations_with_stop_point_reference)
      end
    @lines_routes_links =
      tube_lines.each_with_object([]) do |tl, a|
        a << Tubeline.new(tl).routes_links
      end.flatten
  end
end
