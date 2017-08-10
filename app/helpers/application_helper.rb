module ApplicationHelper
  def image_tag_with_at2x(name_at_1x, options={})
    name_at_2x = name_at_1x.gsub(%r{\.\w+$}, '@2x\0')
    image_tag(name_at_1x, options.merge("data-at2x" => asset_path(name_at_2x)))
  end

	def sortable(column, title = nil, race)
    title ||= column.titleize
		css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
		link_to title, race_path(race,
  		params.merge(
    	:sort => column,
    	:direction => direction,
    	:page => nil).permit(:sort, :direction, :page, :search)),
  		{:class => css_class}
		end
end
