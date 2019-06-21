require './tubeline.rb'

class LondonTube
  attr_reader :coordinates, :route_links

  def initialize(tube_lines)
    @coordinates =
      tube_lines.each_with_object({}) do |tl, h|
        h.merge!(Tubeline.new(tl).stations)
      end
    @route_links =
      tube_lines.each_with_object([]) do |tl, a|
        a << Tubeline.new(tl).route_links
      end.flatten
  end
end
