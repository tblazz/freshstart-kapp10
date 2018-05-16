class UpdateScoresJob < ActiveJob::Base
  queue_as :normal

  def perform
    Score.delete_all

    Runner.find_each do |runner|
      p '------------'
      p 'Runner :'
      p runner.id
      p '------------'

      all_results = runner.results.this_year
      next if all_results.count < 1

      begin
        h = {}

        all_results.group_by { |r| r.race.race_type }.each do |race_type, results|
          h[race_type] = results.map(&:points).compact.sum
        end

        h.each do |race_type, points|
          Score.create(runner_id: runner.id, points: points, race_type: race_type)
        end
      rescue => e
        p "## ERROR ## : #{runner.id}"
        p e
        next
      end

    end
  end
end
