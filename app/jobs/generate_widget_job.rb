require 'htmlentities'
require 'htmlcompressor'

class GenerateWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(race_id)
    @race = Race.find(race_id)
		@categories = @race.results.pluck(:categ).uniq
		@categories_sorted = Hash.new
		@race_longest_name = Hash.new
		@race_lines = Hash.new
		@race.results.order([:race_detail,:rank]).group_by(&:race_detail).each  do |race, results|
			@race_longest_name[race] = results.pluck(:name).group_by(&:size).max.last[0].length
			female_sorted = results.select do |result|
				result['sex'] && result['sex'] == "F"
			end
			male_sorted = results.select do |result|
				result['sex'] && (result['sex'] == "M" || result['sex'] == 'H')
			end
			all_sorted = results.select do |result|
				result['sex'] && (result['sex'] == "M" || result['sex'] == "F" || result['sex'] == "" || result['sex'] == 'H')
			end
			female_categories = female_sorted.map { |f| f['categ'] }.uniq
			male_categories = male_sorted.map { |m| m['categ'] }.uniq
			all_categories = all_sorted.map { |a| a['categ'] }.uniq
			@categories_sorted[race.parameterize] = { F: female_categories, M: male_categories, ALL: all_categories }
		end
    @generated_at = Time.now
    erb_file = "#{Rails.root}/app/views/races/widget.html.erb"
    erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    if renderer
      html = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@race.widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @race.update_attribute(:widget_generated_at, @generated_at)
    end
  end
end
