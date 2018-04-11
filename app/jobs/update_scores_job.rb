class UpdateScoresJob < ActiveJob::Base
  queue_as :normal

  def perform
    @results = Result.where(processed: false)
    p @results.count

    @results.each do |result|
      p '------------'
      p 'Result :'
      p result.id
      p '------------'
      next if result.runner.nil? || result.race.nil? || result.race.coef.blank?

      begin
        if result.runner.scores.blank?
          s = Score.create(runner_id: result.runner.id,
                           race_id: result.race.id,
                           points: result.points,
                           race_type: result.race.race_type)
        else
          last_score = result.runner.scores.last
          s = Score.create(runner_id: result.runner.id,
                           race_id: result.race.id,
                           points: last_score.points + result.points,
                           race_type: result.race.race_type)
        end
        p s.errors
        result.update(processed: true)
      rescue => e
        p "## ERROR ## : #{result.id}"
        p e
        next
      end

    end
  end
end
