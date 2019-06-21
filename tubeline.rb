Stationpoint = Struct.new(:name, :coordinates)

class Tubeline

  def initialize(tube_line_xml_file_path)
    line = File.open(tube_line_xml_file_path) { |f| Nokogiri::XML(f) }
    @annotated_stop_point_ref = line.children.children[0].children
    @route_sections = line.children.children[1].children
  end

  def stations
    @stations ||=
      @annotated_stop_point_ref.each_with_object({}) do |sp, h|
        h.merge!(
          {
            sp.children[0].children.text => sp.children[1].children.text
          }
        )
      end
  end

  def route_links
    @route_links ||=
      @route_sections.flat_map do |rs|
        route_links = rs.children
        route_links.flat_map do |rl|
          { from: rl.children[0].children.text, to: rl.children[1].children.text }
        end
      end
  end
end
