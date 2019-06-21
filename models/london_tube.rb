require_relative './tube_line.rb'

class LondonTube
  attr_reader :lines_stations_with_stop_point_reference, :lines_routes_links

  def initialize
    @lines_stations_with_stop_point_reference =
      tube_lines.each_with_object({}) do |tl, h|
        h.merge!(Tubeline.new(tl).stations_with_stop_point_reference)
      end
    @lines_routes_links =
      tube_lines.each_with_object([]) do |tl, a|
        a << Tubeline.new(tl).routes_links
      end.flatten
  end

  private

  def tube_lines
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
  end
end
