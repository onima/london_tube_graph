class Tubeline

  attr_reader :stations_with_stop_point_reference, :routes_links

  def initialize(tube_line_xml_file_path)
    @line = File.open(tube_line_xml_file_path) { |f| Nokogiri::XML(f) }
    @stations_with_stop_point_reference = fetch_stations_with_stop_point_reference
    @routes_links= fetch_routes_links
  end

  private

  def fetch_stations_with_stop_point_reference
    @line.children.children[0].children.each_with_object({}) do |sp, h|
      h.merge!(
        {
          sp.children[0].children.text => sp.children[1].children.text
        }
      )
    end
  end

  def fetch_routes_links
    @line.children.children[1].children.flat_map do |rs|
      route_links = rs.children
      route_links.flat_map do |rl|
        { from: rl.children[0].children.text, to: rl.children[1].children.text }
      end
    end
  end
end
