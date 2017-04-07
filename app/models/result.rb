class Result < ActiveRecord::Base
  belongs_to :race

  def rank_total
    rank == 1 ? I18n.t('first_suffix') : rank == 2 ? I18n.t('second_suffix') : I18n.t('third_suffix')
  end

  def sent_message
    race.sms_message % {
      name: name,
      time: time,
      url: "image_path",
      race_name_mail: race.email_name ,
      rank: rank,
      race_detail: race_detail,
      results_url: race.results_url
    }
  end
end
