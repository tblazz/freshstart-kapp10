require 'csv'

class ProcessResultJob < ActiveJob::Base
  queue_as :default

  def perform(row)
    #on parse la ligne de CSV

    if row

      print(row.to_s)

    end
  end
end