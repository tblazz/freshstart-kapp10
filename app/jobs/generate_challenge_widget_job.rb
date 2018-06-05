require 'htmlentities'
require 'htmlcompressor'

class GenerateChallengeWidgetJob < ActiveJob::Base
  queue_as :normal

  def perform(challenge_id)
    @challenge = Challenge.find(challenge_id)
    scores = []

    #@challenge.runners.uniq.each do |runner|
    #  scores << runner.scores
    #end

    # @challenge.runners.each do |runner|
    #    if runner.scores.present?
    #      runner.scores.each do |s|
    #        scores << s if s.points.to_i > 0
    #      end
    #    end
    # end


    # @scores = scores
    @scores = Score.ordered_by_points.last(10000)

    @categories = @scores.map { |s| s.runner.category }.compact.uniq
    @types = @scores.pluck(:race_type).uniq
    @categories_sorted = Hash.new
    @edition_longest_name = Hash.new
    @edition_lines = Hash.new
    # @challenge.races.scores.order([:race_type,:points]).group_by(&:race_type).each  do |challenge, scores|
    @scores.sort_by(&:points).group_by(&:race_type).each  do |race_type, scores|
      @edition_longest_name[@challenge.name] = scores.map(&:last_name).group_by(&:size).max.last[0].length

      female_sorted = scores.select do |score|
        score.runner.sex && score.runner.sex == 'F'
      end
      male_sorted = scores.select do |score|
        score.runner.sex && (score.runner.sex == 'M' || score.runner.sex == 'H')
      end
      all_sorted = scores.select do |score|
        score.runner.sex && (score.runner.sex == 'M' || score.runner.sex == 'F' || score.runner.sex == '' || score.runner.sex == 'H')
      end
      female_categories = female_sorted.map { |f| f.runner.category }.compact.uniq
      male_categories = male_sorted.map { |m| m.runner.category }.compact.uniq
      all_categories = all_sorted.map { |a| a.runner.category }.compact.uniq

      @categories_sorted[race_type] = { F: female_categories, M: male_categories, ALL: all_categories }
    end
    @generated_at = Time.now
    erb_file = "#{Rails.root}/app/views/challenges/widget.html.erb"
    erb_str = File.read(erb_file)
    renderer = ERB.new(erb_str)
    if renderer
      html = renderer.result(binding)
      compressor = HtmlCompressor::Compressor.new
      KAPP10_WIDGETS_BUCKET.object(@challenge.widget_storage_name).put(content_type: 'text/html', body: compressor.compress(html), acl:'public-read')
      @challenge.update_attribute(:widget, @challenge.widget_gist)
    end
  end

end
